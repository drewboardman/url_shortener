module Util where

import qualified Dao                           as D
import qualified Data.Text                     as T
import qualified Data.List.Safe                as S
import           Models
import           System.Random

minifyLongUrl :: LongUrl -> IO (Maybe ShortUrl)
minifyLongUrl longUrl = do
  identifier <- D.insertLongUrl longUrl
  let short = ShortUrl . toShortStr <$> identifier
  return short

fetchLongUrl :: ShortUrl -> IO (Maybe LongUrl)
fetchLongUrl shortUrl = do
  let maybeId = parseShort shortUrl
  case maybeId of
    Just int -> D.fetchLongUrl int
    Nothing -> pure Nothing

toShortStr :: Int -> T.Text
toShortStr intId = T.pack "drew.io/" `T.append` T.pack (show intId)

parseShort :: ShortUrl -> Maybe Int
parseShort t = read . T.unpack <$> S.last (T.split (== '/') (fullUrl t))

random8str :: IO String
random8str = genToStr 8 <$> getStdGen

genToStr :: (RandomGen g) => Int -> g -> String
genToStr l = take l . randomRs ('a', 'z')
