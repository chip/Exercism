// Package hamming calculates the Hamming Distance between two DNA strands
package hamming

import "errors"

// Distance accepts 2 DNA strand string arguments and returns the hamming distance
func Distance(a, b string) (int, error) {
	if len(a) != len(b) {
		return 0, errors.New("cannot calculate hamming distance because strings provided are of unequal length")
	}
	count := 0
	for i := 0; i < len(a); i++ {
		if a[i] != b[i] {
			count++
		}
	}
	return count, nil
}
