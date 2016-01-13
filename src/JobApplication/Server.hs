{-# LANGUAGE OverloadedStrings #-}
module JobApplication.Server (runServer) where

import Control.Monad.IO.Class (liftIO)
import Control.Monad.Trans.Either
import Data.Text
import Network.Wai as Wai
import Network.Wai.Handler.Warp
import Network.Wai.Middleware.RequestLogger
import Servant

import JobApplication.API as API
import JobApplication.Database as Database
import JobApplication.Types as Types

server :: Server ApplicationAPI
server =
       getApplicants
  :<|> postApplicant

getApplicants :: EitherT ServantErr IO [Types.Applicant]
getApplicants = do
  applicants <- liftIO $ Database.selectApplicants(100)
  return $ applicants

postApplicant :: Types.Applicant -> EitherT ServantErr IO Types.ApplicantResponse
postApplicant a = do
  liftIO $ Database.insertApplicant(a)
  return $ Types.ApplicantResponse "thanks"

app :: Wai.Application
app = logStdout (serve API.applicationAPI server)

runServer :: Port -> IO ()
runServer port = run port app
