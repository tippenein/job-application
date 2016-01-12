{-# LANGUAGE DataKinds     #-}
{-# LANGUAGE TypeOperators #-}

module JobApplication.API
  (
    applicationAPI
  , ApplicationAPI
  ) where

import Data.Proxy
import JobApplication.Types
import Servant.API

applicationAPI :: Proxy ApplicationAPI
applicationAPI = Proxy

type ApplicationAPI =
       GetApplications
  :<|> PostApplication

type GetApplications =
     "careers"
  :> Get '[JSON] [Application]

type PostApplication =
     "careers"
  :> ReqBody '[JSON] Application
  :> Post '[JSON] ApplicationResponse
