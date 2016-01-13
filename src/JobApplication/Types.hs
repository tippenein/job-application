{-# LANGUAGE DeriveAnyClass    #-}
{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards   #-}

module JobApplication.Types
  (
    Applicant(..)
  , ApplicantResponse(..)
  ) where

import Data.Aeson
import Data.SafeCopy
import Data.Text
import Data.Typeable
import GHC.Generics

instance SafeCopy Applicant where
  putCopy Applicant{..} = contain $ do
    safePut name; safePut email; safePut resume; safePut github; safePut website;
  getCopy = contain $ Applicant <$> safeGet <*> safeGet <*> safeGet <*> safeGet <*> safeGet

data Applicant = Applicant {
  name    :: Text,
  email   :: Text,
  resume  :: Text,
  github  :: Maybe Text,
  website :: Maybe Text
} deriving (Show, Eq, Ord, Typeable, ToJSON, FromJSON, Generic)

data ApplicantResponse = ApplicantResponse {
  message :: Text } deriving (Show, Generic, FromJSON, ToJSON)
