{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE FlexibleInstances #-}

module Models where

import           GHC.Generics
import           Data.Aeson
import           Data.Aeson.Types

data LongUrl = LongUrl { url :: String } deriving (Eq, Show, Generic)
instance ToJSON LongUrl

data ShortUrl = ShortUrl { id :: String } deriving (Eq, Show, Generic)
instance ToJSON ShortUrl
