{-# LANGUAGE ScopedTypeVariables #-}

module Dao where

import           Data.Maybe
import qualified Data.Text              as T
import           Database.SQLite.Simple
import           Models

data LongUrlEntry = LongUrlEntry {id :: Int, url :: String } deriving Show

instance FromRow LongUrlEntry where
  fromRow = LongUrlEntry <$> field <*> field

newtype RowId = RowId {rowId :: Int} deriving Show

instance FromRow RowId where
  fromRow = RowId <$> field

-- TODO: use a string random for the identifier
insertLongUrl :: LongUrl -> IO (Maybe Int)
insertLongUrl l = do
  conn <- open "test.db"
  let entry  = T.unpack $ longUrlText l
      upsert = Query $ T.pack "INSERT or IGNORE INTO urls (str) VALUES (?)"
      getId  = Query $ T.pack "SELECT last_insert_rowid()"
  _ <- execute conn upsert $ Only (entry :: String)
  r <- query_ conn getId :: IO [RowId]
  return $ rowId <$> listToMaybe r
