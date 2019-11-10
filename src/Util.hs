module Util where

import qualified Data.Text     as T
import           Models
import           System.Random

minimize :: LongUrl -> IO (Either T.Text ShortUrl)
minimize longUrl = undefined

random8str :: IO String
random8str = take 8 . randomRs ('a', 'z') <$> getStdGen
