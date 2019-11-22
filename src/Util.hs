module Util where

import qualified Data.Text                     as T
import           Models
import           Dao
import           System.Random

minimize :: LongUrl -> IO (Maybe ShortUrl)
minimize longUrl = do
  identifier <- insertLongUrl longUrl
  let short = ShortUrl . toShortStr <$> identifier
  return short

toShortStr :: Int -> T.Text
toShortStr intId = T.pack "drew.io/" `T.append` T.pack (show intId)

random8str :: IO String
random8str = genToStr 8 <$> getStdGen

genToStr :: (RandomGen g) => Int -> g -> String
genToStr l = take l . randomRs ('a', 'z')
