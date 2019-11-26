module Main where

import           Controller
import           Lib
import           Network.Wai.Handler.Warp
import           Network.Wai.Logger

main :: IO ()
main = withStdoutLogger $ \aplogger -> do
  let settings = setPort 8081 $ setLogger aplogger defaultSettings
  runSettings settings app

