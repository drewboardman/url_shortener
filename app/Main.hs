module Main where

import           Controller
import           Lib
import           Network.Wai.Handler.Warp

main :: IO ()
main = run 8081 app
