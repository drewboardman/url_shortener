{-# LANGUAGE DeriveGeneric              #-}
{-# LANGUAGE DuplicateRecordFields      #-}
{-# LANGUAGE FlexibleInstances          #-}
{-# LANGUAGE GeneralisedNewtypeDeriving #-}
{-# LANGUAGE ScopedTypeVariables        #-}


module Models where

import           Data.Aeson
import qualified Data.Text                     as T
import           GHC.Generics
import           Servant
import           Database.SQLite.Simple

newtype LongUrl = LongUrl { longUrlText :: T.Text } deriving (Eq, Show, Generic, FromHttpApiData)
instance FromRow LongUrl where
  fromRow = LongUrl <$> field

instance ToJSON LongUrl
instance FromJSON LongUrl

newtype ShortUrl = ShortUrl { fullUrl :: T.Text } deriving (Eq, Show, Generic, FromHttpApiData)
instance ToJSON ShortUrl
instance FromJSON ShortUrl

newtype UrlId = UrlId T.Text deriving Show
