module Main where

import           Controller
import           Network.Wai.Handler.Warp
import           Network.Wai.Logger

main :: IO ()
main = withStdoutLogger $ \aplogger -> do
  let settings = setPort 9000 $ setLogger aplogger defaultSettings
  runSettings settings app
