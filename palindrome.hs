#!/usr/bin/runhaskell

isPalindrome :: String -> Bool
isPalindrome input = input == reverse input

palindromeDecision :: String -> String
palindromeDecision input =
	if isPalindrome input
		then "palindrome"
		else "not a palindrome"

palindromeLines :: String -> String
palindromeLines = unlines . (map palindromeDecision) . lines

main = interact palindromeLines