{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE TemplateHaskell    #-}
{-# LANGUAGE TypeFamilies       #-}

module JobApplication.Database
  (
    insertApplicant
  , selectApplicants
  ) where

import Control.Monad.Reader (ask)
import Control.Monad.State (get, put)
import Data.Acid
import Data.SafeCopy

import JobApplication.Types

data Database = Database [Applicant]
$(deriveSafeCopy 0 'base ''Database)

insertApp :: Applicant -> Update Database ()
insertApp ap = do
  Database applicants <- get
  put (Database (ap:applicants))

selectApp :: Int -> Query Database [Applicant]
selectApp limit = do
  Database applicants <- ask
  return (take limit applicants)

$(makeAcidic ''Database ['insertApp, 'selectApp])

insertApplicant :: Applicant -> IO ()
insertApplicant ap = do
  database <- openLocalState (Database [])
  update database (InsertApp ap)
  closeAcidState database
  putStrLn $ "saved application " ++ show ap

selectApplicants :: Int -> IO [Applicant]
selectApplicants limit = do
  database <- openLocalState (Database [])
  putStrLn $ "The last " ++ show limit ++ "applicants:\n" -- ++ (map show applicants)
  applicants <- query database (SelectApp limit)
  closeAcidState database
  return applicants
