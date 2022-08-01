// Package scrabble provides a function for computing the Scrabble score of a given word
package scrabble

import "strings"

// Compute Scrabble score given a word string argument
func Score(word string) int {
	score := 0
	for _, letter := range strings.ToUpper(word) {
		switch letter {
		case 'A', 'E', 'I', 'O', 'U', 'L', 'N', 'R', 'S', 'T':
			score++
		case 'D', 'G':
			score = score + 2
		case 'B', 'C', 'M', 'P':
			score = score + 3
		case 'F', 'H', 'V', 'W', 'Y':
			score = score + 4
		case 'K':
			score = score + 5
		case 'J', 'X':
			score = score + 8
		case 'Q', 'Z':
			score = score + 10
		}
	}
	return score
}
