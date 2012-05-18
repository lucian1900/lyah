#!/usr/bin/runhaskell

import System.Environment
import System.Directory
import System.IO
import Data.List

dispatch :: [(String, [String] -> IO ())]
dispatch = [("add", add),
            ("view", view),
            ("remove", remove),
            ("bump", bump)]

main = do
    (fileName:command:args) <- getArgs
    let (Just action) = lookup command dispatch
    action $ fileName:args

add :: [String] -> IO ()
add [fileName, todoItem] = appendFile fileName (todoItem ++ "\n")

view :: [String] -> IO ()
view [fileName] = do
    contents <- readFile fileName
    let todoTasks = lines contents
        numberedTasks = zipWith (\n line -> show n ++ " - " ++ line) [0..] todoTasks
    putStr $ unlines numberedTasks

remove :: [String] -> IO ()
remove [fileName, numberString] = do
    handle <- openFile fileName ReadMode
    contents <- hGetContents handle

    let number = read numberString
        todoTasks = lines contents
        newTodoItems = delete (todoTasks !! number) todoTasks

    (tempName, tempHandle) <- openTempFile "." "temp"
    hPutStr tempHandle $ unlines newTodoItems

    hClose handle
    hClose tempHandle

    removeFile fileName
    renameFile tempName fileName

bump :: [String] -> IO ()
bump [fileName, numberString] = do
    handle <- openFile fileName ReadMode
    contents <- hGetContents handle

    let todoTasks = lines contents
        task = todoTasks !! read numberString
        newTodoItems = task : (delete task todoTasks)

    (tempName, tempHandle) <- openTempFile "." "temp"
    hPutStr tempHandle $ unlines newTodoItems

    hClose handle
    hClose tempHandle

    removeFile fileName
    renameFile tempName fileName