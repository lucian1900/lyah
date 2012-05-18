#!/usr/bin/runhaskell

--main = do
--    contents <- getContents
--    putStr (shortLinesOnly contents)
main = interact shortLinesOnly

shortLinesOnly :: String -> String
shortLinesOnly = unlines . filter ((< 10) . length) . lines