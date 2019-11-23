module Util where

import           Dao
import qualified Data.Text     as T
import           Models
import           System.Random

minifyLongUrl :: LongUrl -> IO (Maybe ShortUrl)
minifyLongUrl longUrl = do
  identifier <- insertLongUrl longUrl
  let short = ShortUrl . toShortStr <$> identifier
  return short

toShortStr :: Int -> T.Text
toShortStr intId = T.pack "drew.io/" `T.append` T.pack (show intId)

-- see if it's hard to get offline hoogle
-- last is unsafe
-- how to T.Text -> Maybe Int
parseShort :: T.Text -> T.Text
parseShort = last . T.split (== '/')

random8str :: IO String
random8str = genToStr 8 <$> getStdGen

genToStr :: (RandomGen g) => Int -> g -> String
genToStr l = take l . randomRs ('a', 'z')
