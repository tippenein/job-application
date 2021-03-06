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
       GetApplicants
  :<|> PostApplicant

type GetApplicants =
     "careers"
  :> Get '[JSON] [Applicant]

type PostApplicant =
     "careers"
  :> ReqBody '[JSON] Applicant
  :> Post '[JSON] ApplicantResponse
