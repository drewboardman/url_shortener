{-# LANGUAGE DataKinds           #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeOperators       #-}

module Controller where

import           Data.Text
import           Models
import           Servant

type Api =
  -- GET: /minimize/<longUrl> -- returns shortened URL
   "minimize" :> QueryParam "longUrl" LongUrl :> Get '[JSON] ShortUrl

app :: Application
app = serve urlApi shortenerServer

-- this is important boilerplate
-- you need it to guide type inference
urlApi :: Proxy Api
urlApi = Proxy

shortenerServer :: Server Api
shortenerServer = minimize where

  minimize :: Maybe LongUrl -> Handler ShortUrl
  minimize Nothing        = throwError err404
  minimize (Just longUrl) = return (ShortUrl $ pack "foo") -- implement me
