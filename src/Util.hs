module Util where

import qualified Data.Text     as T
import           Models
import           System.Random

minimize :: LongUrl -> IO (Either T.Text ShortUrl)
minimize longUrl = undefined

random8str :: IO String
random8str = genToStr 8 <$> getStdGen

genToStr :: (RandomGen g) => Int -> g -> String
genToStr l = take l . randomRs ('a', 'z')
