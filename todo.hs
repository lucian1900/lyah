#!/usr/bin/runhaskell

import System.Environment
import System.Directory
import System.IO
import Data.List
import Data.Maybe

dispatch :: [(String, [String] -> IO ())]
dispatch = [("add", add),
            ("view", view),
            ("remove", modify remove),
            ("bump", modify bump)]

main = do
    (fileName:command:args) <- getArgs
    let action = fromMaybe wrong (lookup command dispatch)
    action $ fileName:args

wrong :: [String] -> IO ()
wrong args = print $ "Unexpected args: " ++ show args

add :: [String] -> IO ()
add [fileName, todoItem] = appendFile fileName (todoItem ++ "\n")

view :: [String] -> IO ()
view [fileName] = do
    contents <- readFile fileName
    let todoTasks = lines contents
        numberedTasks = zipWith (\n line -> show n ++ " - " ++ line) [0..] todoTasks
    putStr $ unlines numberedTasks

modify :: ([String] -> Int -> [String]) -> [String] -> IO ()
modify f [fileName, numberString] = do
    handle <- openFile fileName ReadMode
    contents <- hGetContents handle

    let number = read numberString
        todoTasks = lines contents
        newTodoItems = f todoTasks number

    (tempName, tempHandle) <- openTempFile "." "temp"
    hPutStr tempHandle $ unlines newTodoItems

    hClose handle
    hClose tempHandle

    removeFile fileName
    renameFile tempName fileName

remove :: [String] -> Int -> [String]
remove tasks number = delete (tasks !! number) tasks

bump :: [String] -> Int -> [String]
bump tasks number = let task = tasks !! number in
    task : (delete task tasks)