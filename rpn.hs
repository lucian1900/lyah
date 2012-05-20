#!/usr/bin/runhaskell

solveRPN :: String -> Float
solveRPN = head . foldl compute [] . words
    where compute (x:y:ys) "*" = (x * y):ys
          compute (x:y:ys) "+" = (x + y):ys
          compute (x:y:ys) "-" = (y - x):ys
          compute (x:y:ys) "/" = (y / x):ys
          compute (x:y:ys) "^" = (y ** x):ys
          compute (x:xs) "ln" = log x:xs
          compute xs "sum" = [sum xs]
          compute xs numberString = read numberString:xs