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
import JobApplication.Types as Types

server :: Server ApplicationAPI
server =
       getApplications
  :<|> postApplication

getApplications :: EitherT ServantErr IO [Types.Application]
getApplications = return []

postApplication :: Types.Application -> EitherT ServantErr IO Types.ApplicationResponse
postApplication a =
  return $ Types.ApplicationResponse "thanks"

app :: Wai.Application
app = logStdout (serve API.applicationAPI server)

runServer :: Port -> IO ()
runServer port = run port app
