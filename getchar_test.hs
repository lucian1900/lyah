#!/usr/bin/runhaskell

main = do
	c <- getChar
	if c /= ' '
		then do
			putChar c
			main
		else return ()