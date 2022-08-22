package grains

import (
	"errors"
	"math"
)

func Square(number int) (uint64, error) {
	if number <= 0 || number > 64 {
		return 0, errors.New("number must be between 1-64")
	}
	n := math.Pow(2, float64(number-1))
	return uint64(n), nil
}

func Total() uint64 {
	var sum uint64 = 0

	for i := 1; i <= 64; i++ {
		n, err := Square(i)
		if err == nil {
			sum += n
		}
	}
	return sum
}
