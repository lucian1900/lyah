#!/usr/bin/runhaskell

import System.Environment (getArgs)
import qualified Data.ByteString.Lazy as B

main = do
    (file1:file2:_) <- getArgs