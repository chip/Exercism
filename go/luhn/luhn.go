package luhn

import (
	"errors"
	"log"
	"regexp"
	"strconv"
)

func isDigit(s rune) bool {
	re := regexp.MustCompile(`^[0-9]+$`)
	return re.MatchString(string(s))
}

// Sanitize string by removing whitespace
func sanitize(s string) string {
	space := regexp.MustCompile(`\s+`)
	return space.ReplaceAllString(s, "")
}

// Validate size and contents of buffer, ensuring all digits
func validate(s string) error {
	if len(s) <= 1 {
		return errors.New("cannot process string because it contains less than 1 character")
	}
	for _, char := range s {
		if !isDigit(char) {
			return errors.New("cannot process string because it contains non-digits")
		}
	}
	return nil
}

// Determine if string argument provided passes a Luhn algorithm validity check
// https://en.wikipedia.org/wiki/Luhn_algorithm
func Valid(id string) bool {
	s := sanitize(id)

	err := validate(s)
	if err != nil {
		log.Println(err)
		return false
	}

	sum := 0
	counter := 0

	for i := len(s) - 1; i >= 0; i-- {
		counter++
		n, err := strconv.Atoi(string(s[i]))
		if err != nil {
			log.Println(err)
			return false
		}

		if counter%2 == 0 {
			n *= 2
			if n > 9 {
				n -= 9
			}
		}
		sum += n
	}
	return sum%10 == 0
}
