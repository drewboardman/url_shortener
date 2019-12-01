{-# LANGUAGE ScopedTypeVariables #-}

module Actions where

import qualified Dao            as D
import qualified Data.List.Safe as S
import qualified Data.Text      as T
import           Models

minifyLongUrl :: LongUrl -> IO (Maybe ShortUrl)
minifyLongUrl longUrl = do
  maybeKey <- D.insertLongUrl longUrl
  let short = ShortUrl . toShortStr <$> maybeKey
  return short

fetchLongUrl :: ShortUrl -> IO (Maybe LongUrl)
fetchLongUrl shortUrl = do
  let maybeId = parseShort shortUrl
  case maybeId of
    Just int -> D.fetchLongUrl int
    Nothing  -> pure Nothing

toShortStr :: T.Text -> T.Text
toShortStr randIdStr = T.pack "drew.io/" `T.append` randIdStr

parseShort :: ShortUrl -> Maybe T.Text
parseShort t = S.last (T.split (== '/') (shortUrlValue t))
