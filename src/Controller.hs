{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}

module Controller where

import           Data.Text
import           Data.Time                      ( UTCTime )
import           Models                         ( LongUrl
                                                , ShortUrl
                                                )
import           Servant.API

type UrlApi
  = "minimize" :> QueryParam "longUrl" LongUrl :> Get '[JSON] [ShortUrl]
