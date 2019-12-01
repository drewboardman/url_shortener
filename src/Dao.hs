{-# LANGUAGE OverloadedStrings   #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Dao where

import           Data.Maybe
import qualified Data.Text              as T
import           Database.SQLite.Simple
import           Models
import           System.Random

newtype RowId = RowId {rowId :: Int} deriving Show
data LongUrlRow = LongUrlRow {url :: T.Text, key :: T.Text} deriving Show

instance ToRow LongUrlRow where
  toRow (LongUrlRow url_ key_) = toRow (url_, key_)

instance FromRow LongUrlRow where
  fromRow = LongUrlRow <$> field <*> field

instance FromRow RowId where
  fromRow = RowId <$> field

insertLongUrl :: LongUrl -> IO (Maybe T.Text)
insertLongUrl l = do
  conn <- open "urls.db"
  execute_
    conn
    "CREATE TABLE IF NOT EXISTS urls (url TEXT NOT NULL, key TEXT NOT NULL, UNIQUE(url))"
  rand <- T.pack <$> random8str
  -- TODO: what happens if the rand isn't unique?
  let urlToInsert = longUrlValue l
      upsert      = "INSERT or IGNORE INTO urls (url, key) VALUES (?, ?)"
  _    <- execute conn upsert $ LongUrlRow urlToInsert rand
  rows <-
    query conn
          "SELECT key FROM urls WHERE url = ?"
          (Only (urlToInsert :: T.Text)) :: IO [Only String]
  return $ T.pack . fromOnly <$> listToMaybe rows

-- how is this safe?
fetchLongUrl :: T.Text -> IO (Maybe LongUrl)
fetchLongUrl identifier = do
  conn <- open "urls.db"
  execute_
    conn
    "CREATE TABLE IF NOT EXISTS urls (url TEXT NOT NULL, key TEXT NOT NULL, UNIQUE(url))"
  let select = "SELECT * FROM urls WHERE key = ?"
  results <- query conn select (Only (identifier :: T.Text)) :: IO [LongUrlRow]
  return $ LongUrl . url <$> listToMaybe results

random8str :: IO String
random8str = genToStr 8 <$> newStdGen

genToStr :: (RandomGen g) => Int -> g -> String
genToStr l = take l . randomRs ('a', 'z')
