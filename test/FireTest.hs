module Main where

import qualified Control.Concurrent.MVar as M
import System.Exit (exitSuccess, exitFailure)
import Refract.Event
import Refract.Bus

newtype MessageEvent = MessageEvent String
instance Filter MessageEvent where
instance Event MessageEvent where

showMessage :: MessageEvent -> IO ()
showMessage (MessageEvent msg) = putStrLn msg

showMessage' :: MessageEvent -> IO ()
showMessage' (MessageEvent msg) = putStrLn $ "second: " ++ msg



main :: IO ()
main = do
    bus <- createBlankBus (MessageEvent "fuck")
    associate showMessage bus
    associate showMessage' bus
    fire (MessageEvent "test, 1.") bus
    fire (MessageEvent "test, 2.") bus
    fire (MessageEvent "test, 3.") bus