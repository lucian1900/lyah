#!/usr/bin/runhaskell

import System.Environment (getArgs)
import qualified Data.ByteString.Lazy as B

main = do
    (source:dest:_) <- getArgs
    copyFile source dest

copyFile :: FilePath -> FilePath -> IO ()
copyFile source dest = do
    contents <- B.readFile source
    B.writeFile dest source