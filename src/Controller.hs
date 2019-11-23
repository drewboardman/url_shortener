{-# LANGUAGE DataKinds           #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeOperators       #-}

module Controller where

import           Control.Monad.IO.Class
import           Models
import           Servant
import           Util

type Api =
  -- GET: /minimize/<longUrl> -- returns shortened URL
   "minimize" :> QueryParam "longUrl" LongUrl :> Get '[JSON] ShortUrl
  -- GET: /expand/<shortUrl> -- returns the original URL
   :<|> "expand" :> QueryParam "shortUrl" ShortUrl :> Get '[JSON] LongUrl

app :: Application
app = serve urlApi shortenerServer

-- this is important boilerplate
-- you need it to guide type inference
urlApi :: Proxy Api
urlApi = Proxy

shortenerServer :: Server Api
shortenerServer = minimize :<|> expand where

  minimize :: Maybe LongUrl -> Handler ShortUrl
  minimize Nothing  = throwError err404
  minimize (Just l) = do
    maybeShortened <- liftIO $ minifyLongUrl l
    case maybeShortened of
      Just s  -> return s
      Nothing -> throwError err500

  expand :: Maybe ShortUrl -> Handler LongUrl
  expand s = undefined
