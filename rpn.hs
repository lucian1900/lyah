#!/usr/bin/runhaskell

solveRPN :: (Num a, Read a) => String -> a
solveRPN = head . foldl compute [] . words
    where compute (x:y:ys) "*" = (x * y):ys
          compute (x:y:ys) "+" = (x + y):ys
          compute (x:y:ys) "-" = (y - x):ys
          compute xs numberString = read numberString:xs