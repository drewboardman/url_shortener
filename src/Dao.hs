{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE OverloadedStrings #-} -- this is for the queries

module Dao where

import           Data.Maybe
import qualified Data.Text                     as T
import           Database.SQLite.Simple
import           Models

newtype RowId = RowId {rowId :: Int} deriving Show

instance FromRow RowId where
  fromRow = RowId <$> field

-- TODO: use a string random for the identifier
insertLongUrl :: LongUrl -> IO Int
insertLongUrl l = do
  conn <- open "urls.db"
  let entry  = T.unpack $ longUrlText l
      upsert = "INSERT or IGNORE INTO urls (longUrl) VALUES (?)"
  _ <- execute conn upsert $ Only (entry :: String)
  r <- lastInsertRowId conn
  return $ fromIntegral r

-- how is this safe?
fetchLongUrl :: Int -> IO (Maybe LongUrl)
fetchLongUrl identifier = do
  conn <- open "urls.db"
  let select = "SELECT * FROM urls WHERE rowId = ?"
  results <- query conn select (Only (identifier :: Int)) :: IO [LongUrl]
  return $ listToMaybe results
