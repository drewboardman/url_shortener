{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE FlexibleInstances #-}

module Models
  ( LongUrl(..)
  , ShortUrl(..)
  )
where

import           Data.Aeson
import           Data.Aeson.Types
import           GHC.Generics

data LongUrl = LongUrl { url :: String } deriving (Eq, Show, Generic)
instance ToJSON LongUrl
instance FromJSON LongUrl

data ShortUrl = ShortUrl { id :: String } deriving (Eq, Show, Generic)
instance ToJSON ShortUrl
