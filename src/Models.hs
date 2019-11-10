{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE FlexibleInstances #-}

module Models where

import           Data.Aeson
import           Data.Aeson.Types
import           GHC.Generics

data LongUrl = LongUrl { url :: String } deriving (Eq, Show, Generic)
instance ToJSON LongUrl

data ShortUrl = ShortUrl { id :: String } deriving (Eq, Show, Generic)
instance ToJSON ShortUrl
