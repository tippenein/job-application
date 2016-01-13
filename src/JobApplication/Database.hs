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

insertApplicant :: Applicant -> Update Database ()
insertApplicant ap = do
  Database applicants <- get
  put (Database (ap:applicants))

selectApplicants :: Int -> Query Database [Applicant]
selectApplicants limit = do
  Database applicants <- ask
  return (take limit applicants)

$(makeAcidic ''Database ['insertApplicant, 'selectApplicants])
$(deriveSafeCopy 0 'base ''Database)
