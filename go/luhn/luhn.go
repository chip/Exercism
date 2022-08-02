package luhn

import (
	"errors"
	"regexp"
	"strconv"
	"unicode"
	"unicode/utf8"
)

// Inspired by (but tweaked):
// https://stackoverflow.com/questions/1752414/how-to-reverse-a-string-in-go
// Accepts a string argument and reverse string
func reverse(s string) string {
	buf := []byte(s)
	size := len(buf)
	for start := 0; start < size; {
		r, n := utf8.DecodeRuneInString(s[start:])
		start += n
		utf8.EncodeRune(buf[size-start:], r)
	}
	return string(buf)
}

// Sanitize string by removing whitespace, then check size and contents of
// buffer, ensuring all digits
func validate(s string) (string, error) {
	space := regexp.MustCompile(`\s+`)
	buf := space.ReplaceAllString(s, "")

	if len(buf) <= 1 {
		return buf, errors.New("cannot process string because it contains less than 1 character")
	}
	for _, char := range buf {
		if !unicode.IsDigit(char) {
			return buf, errors.New("cannot process string because it contains non-digits")
		}
	}
	return buf, nil
}

// Determine if string argument provided passes a Luhn algorithm validity check
// https://en.wikipedia.org/wiki/Luhn_algorithm
func Valid(id string) bool {
	s, err := validate(id)
	if err != nil {
		return false
	}
	sum := 0
	for i, r := range reverse(s) {
		n, _ := strconv.Atoi(string(r))

		if i%2 == 1 {
			n *= 2
			if n > 9 {
				n -= 9
			}
		}
		sum += n
	}
	return sum%10 == 0
}
