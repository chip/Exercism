package luhn

import (
	"errors"
	"fmt"
	"regexp"
	"strconv"
	"strings"
	"unicode"
	"unicode/utf8"
)

// Best example I could understand for reversing a string
// https://stackoverflow.com/questions/1752414/how-to-reverse-a-string-in-go
// func Reverse(s string) string {
// 	size := len(s)
// 	buf := make([]byte, size)
// 	for start := 0; start < size; {
// 		r, n := utf8.DecodeRuneInString(s[start:])
// 		start += n
// 		utf8.EncodeRune(buf[size-start:], r)
// 	}
// 	return string(buf)
// }

func __reverse(s string) string {
	size := len(s)
	buf := make([]byte, size)
	for start := 0; start < size; {
		r, n := utf8.DecodeRuneInString(s[start:])
		start += n
		utf8.EncodeRune(buf[size-start:], r)
	}
	return string(buf)
}

func reverse(x string) (string, error) {
	s := strings.TrimSpace(x)
	buf := []byte(s)
	size := len(buf)
	for start := 0; start < size; {
		r, n := utf8.DecodeRuneInString(s[start:])
		if !unicode.IsDigit(r) {
			return x, errors.New("cannot process string because it contains non-digits")
		}
		start += n
		utf8.EncodeRune(buf[size-start:], r)
	}
	return string(buf), nil
}

// function checkLuhn(string purportedCC) {
//     int nDigits := length(purportedCC)
//     int sum := 0;
//     int parity := (nDigits-2)modulus 2
//     for i from 0 to nDigits - 1 {
//         int digit := integer(purportedCC[i])
//         if i modulus 2 = parity
//             digit := digit × 2
//         if digit > 9
//             digit := digit - 9
//         sum := sum + digit
//     }
//     return (sum modulus 10) = 0
// }
//

// func _sanitize(cc string) (string, error) {
// 	cc = strings.TrimSpace(cc)
// size := len(cc)
// buf := make([]byte, size)
// if _, err := regexp.Match(`^[0-9]+$`, cc); err != nil {
// 	return buf, errors.New("cannot process string because it contains non-digits")
// }
// }

func sanitize(cc string) (string, error) {
	// buf := strings.Trim(cc, "")

	space := regexp.MustCompile(`\s+`)
	buf := space.ReplaceAllString(cc, "")
	// fmt.Printf("%q", s) // "Hello world!"

	fmt.Println("sanitize buf: [", buf, "]")
	if len(buf) <= 1 {
		return buf, errors.New("cannot process string because it contains less than 1 character")
	}
	for _, char := range buf {
		n, _ := strconv.Atoi(string(char))
		fmt.Println("sanitize n:", n, " char:", char)
		if !unicode.IsDigit(char) {
			return buf, errors.New("cannot process string because it contains non-digits")
		}
	}
	return buf, nil
}

// func _sanitize(cc string) []rune {
// 	runes := make([]rune, len(cc))
// 	for i, char := range cc {
// 		if unicode.IsDigit(char) {
// 			runes[i] = char
// 		}
// 	}
// 	return runes
// }
//
func Valid(id string) bool {
	s, err := sanitize(id)
	fmt.Println(err)
	if err != nil {
		return false
	}
	sum := 0
	reversed, err := reverse(s)
	if err != nil {
		return false
	}
	fmt.Println("reversed:", reversed)
	for i, r := range reversed {
		n, _ := strconv.Atoi(string(r))

		fmt.Printf("i: %d, char: %d\n", i, n)
		// if unicode.IsDigit(char) {
		// letter := string(char)
		// n, _ := strconv.Atoi(letter)
		// n, _ := strconv.Atoi(char)
		// fmt.Printf("n: %d\n", n)
		if i%2 == 1 {
			n *= 2
			fmt.Printf("n *=2: %d\n", n)
			if n > 9 {
				n -= 9
				fmt.Printf("n (after): %d\n", n)
			}
		}
		sum += n
		fmt.Printf("sum: %d\n", sum)
		// } else {
		// 	return false
		// }
	}
	return sum%10 == 0
}
