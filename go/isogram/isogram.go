// Package isogram can determine if a word or phrase is without a repeating letter
// package isogram
package isogram

import "strings"

// Determine if a given word is a "non-pattern" word (i.e., contains no
// repeating letters, excluding spaces and hyphens)
func IsIsogram(word string) bool {
	if word == "" {
		return true
	}
	isogram := true
	letterSet := map[rune]struct{}{}
	for _, letter := range strings.ToLower(word) {
		if letter == ' ' || letter == '-' {
			continue
		}
		_, found := letterSet[letter]
		if found {
			isogram = false
			break
		}
		letterSet[letter] = struct{}{}
	}
	return isogram
}
