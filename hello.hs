#!/usr/bin/runhaskell

main = do
    putStrLn "Name: "
    name <- getLine
    putStrLn $ "Hey " ++ name ++ "!"
