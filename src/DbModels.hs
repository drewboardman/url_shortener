{-# LANGUAGE EmptyDataDecls             #-}
{-# LANGUAGE FlexibleContexts           #-}
{-# LANGUAGE GADTs                      #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses      #-}
{-# LANGUAGE OverloadedStrings          #-}
{-# LANGUAGE QuasiQuotes                #-}
{-# LANGUAGE ScopedTypeVariables        #-}
{-# LANGUAGE TemplateHaskell            #-}
{-# LANGUAGE TypeFamilies               #-}

module DbModels where

import           Conduit
import           Control.Monad.IO.Class  (liftIO)
import           Control.Monad.IO.Unlift
import           Control.Monad.Logger
import           Control.Monad.Reader
import qualified Data.Text               as T
import           Database.Persist
import           Database.Persist.Sqlite
import           Database.Persist.TH
import           Models
import           Util

share [mkPersist sqlSettings, mkSave "entityDefs"] [persistLowerCase|
LongUrlEntry
  longUrl String
  identifier String
  deriving Show
|]

runSqlite' :: (MonadUnliftIO m) => T.Text -> ReaderT SqlBackend (NoLoggingT (ResourceT m)) a -> m a
runSqlite' = runSqlite

-- change this to the following:
-- 1: Check if the longUrl is already in there
-- 2: If so, return the strId
-- 3: Otherwise insert and return the strId
insertLongUrl :: LongUrl -> IO (Maybe T.Text)
insertLongUrl l = runSqlite' ":memory:" $ do
  urlEntry <- liftIO $ toLongUrlEntry l
  longUrlId <- insert urlEntry
  returnedLongUrlEntry <- get longUrlId
  let (LongUrlEntry _ identifier) = returnedLongUrlEntry
  liftIO $ (T.pack <$> identifier)

toIdentifier :: Maybe LongUrlEntry -> Maybe T.Text
toIdentifier l = LongUrlEntryIdentifier <$> l

toLongUrlEntry :: LongUrl -> IO LongUrlEntry
toLongUrlEntry (LongUrl url) = LongUrlEntry (T.unpack url) <$> random8str

newtype Person = Person { name :: String }

getName :: Maybe Person -> Maybe String
getName p = name <$> p
