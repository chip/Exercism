// Package isogram can determine if a word or phrase is without a repeating letter
package isogram

import (
	"strings"
	"unicode"
)

// Determine if a given word is a "non-pattern" word:
// (contains no repeating letters, excluding spaces and hyphens)
func IsIsogram(word string) bool {
	s := strings.ToLower(word)

	for i, letter := range s {
		if unicode.IsLetter(letter) && strings.ContainsRune(s[i+1:], letter) {
			return false
		}
	}
	return true
}
