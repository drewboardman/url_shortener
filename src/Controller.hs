{-# LANGUAGE DataKinds           #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeOperators       #-}

module Controller where

import           Control.Monad.IO.Class
import qualified Data.Text as T
import           Models
import           Servant
import           Util

type Api =
  -- GET: /minimize/<longUrl> -- returns shortened URL
   "minimize" :> QueryParam "longUrl" T.Text :> Get '[JSON] ShortUrl
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

  minimize :: Maybe T.Text -> Handler ShortUrl
  minimize Nothing  = throwError err404
  minimize (Just text) = do
    maybeShortened <- liftIO $ minifyLongUrl $ LongUrl text
    case maybeShortened of
      Just s  -> pure s
      Nothing -> throwError err500

  expand :: Maybe ShortUrl -> Handler LongUrl
  expand Nothing  = throwError err404
  expand (Just s) = do
    maybeLong <- liftIO $ fetchLongUrl s
    case maybeLong of
      Just l -> pure l
      Nothing -> throwError err500
