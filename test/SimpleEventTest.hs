module Main where

import qualified Control.Concurrent.MVar as M
import qualified Refract.Bus as R
import           Refract.Event
import           System.Exit             (exitFailure, exitSuccess)

newtype MessageEvent = MessageEvent String
instance Event MessageEvent where
    base = MessageEvent ""

showMessage :: MessageEvent -> IO ()
showMessage (MessageEvent msg) = putStrLn msg

main :: IO ()
main = do
    bus <- R.createBlankBus (base :: MessageEvent)
    (R.Bus _ before) <- M.readMVar bus
    R.associate' showMessage bus
    (R.Bus _ after) <- M.readMVar bus
    if length before == length after then exitFailure else exitSuccess
