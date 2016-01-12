{-# LANGUAGE DeriveGeneric              #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module JobApplication.Client
  (
    getApplications
  , postApplication
  ) where

import Control.Monad.Trans.Either
import Data.Aeson
import Data.Text
import GHC.Generics (Generic)
import Servant
import Servant.Client

import JobApplication.API

-- getUsers' :: Maybe Integer -> Maybe Email -> EitherT ServantError IO [User]

type Action a = EitherT ServantError IO a

run :: Action a -> IO a
run action = do
    result <- runEitherT action
    case result of
        Left message -> error (show message)
        Right x -> return x

getApplications' :<|> postApplication' =
  client applicationAPI host
    where
      host = BaseUrl Https "localhost" 8081

getApplications = runEitherT $ getApplications'
postApplication ap = runEitherT $ postApplication' ap
