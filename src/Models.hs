{-# LANGUAGE DeriveGeneric              #-}
{-# LANGUAGE DuplicateRecordFields      #-}
{-# LANGUAGE FlexibleInstances          #-}
{-# LANGUAGE GeneralisedNewtypeDeriving #-}
{-# LANGUAGE ScopedTypeVariables        #-}


module Models where

import           Data.Aeson
import qualified Data.Text              as T
import           Database.SQLite.Simple
import           GHC.Generics
import           Servant

newtype LongUrl = LongUrl { longUrlValue :: T.Text } deriving (Eq, Show, Generic, FromHttpApiData)
instance FromRow LongUrl where
  fromRow = LongUrl <$> field

instance ToJSON LongUrl
instance FromJSON LongUrl

newtype ShortUrl = ShortUrl { shortUrlValue :: T.Text } deriving (Eq, Show, Generic, FromHttpApiData)
instance ToJSON ShortUrl
instance FromJSON ShortUrl

newtype UrlId = UrlId T.Text deriving Show
