{-# LANGUAGE DeriveGeneric              #-}
{-# LANGUAGE DuplicateRecordFields      #-}
{-# LANGUAGE FlexibleInstances          #-}
{-# LANGUAGE GeneralisedNewtypeDeriving #-}
{-# LANGUAGE ScopedTypeVariables        #-}


module Models
  ( LongUrl(..)
  , ShortUrl(..)
  )
where

import           Data.Aeson
import qualified Data.Text    as T
import           GHC.Generics
import           Servant

newtype LongUrl = LongUrl { longUrlText :: T.Text } deriving (Eq, Show, Generic, FromHttpApiData)
instance ToJSON LongUrl
instance FromJSON LongUrl

newtype ShortUrl = ShortUrl { shortUrlId :: T.Text } deriving (Eq, Show, Generic)
instance ToJSON ShortUrl
