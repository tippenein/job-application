{-# LANGUAGE DeriveGeneric              #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module JobApplication.Client
  (
    getApplicants
  , postApplicant
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

getApplicants' :<|> postApplicant' =
  client applicationAPI host
    where
      host = BaseUrl Https "localhost" 8081

getApplicants = runEitherT $ getApplicants'
postApplicant ap = runEitherT $ postApplicant' ap
