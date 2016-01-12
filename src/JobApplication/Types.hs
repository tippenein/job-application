{-# LANGUAGE DeriveAnyClass    #-}
{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}

module JobApplication.Types
  (
    Application(..)
  , ApplicationResponse(..)
  ) where

import Data.Aeson
import Data.Text
import GHC.Generics


data Application = Application {
  name    :: Text,
  email   :: Text,
  resume  :: Text,
  github  :: Maybe Text,
  website :: Maybe Text
} deriving (Show, Eq, ToJSON, FromJSON, Generic)

data ApplicationResponse = ApplicationResponse {
  message :: Text } deriving (Show, Generic, FromJSON, ToJSON)
