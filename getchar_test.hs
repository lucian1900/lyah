#!/usr/bin/runhaskell

main = do
	c <- getChar
	if c /= ' '
		then do
			putchar c
			main
		else return ()