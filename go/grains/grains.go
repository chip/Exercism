package grains

import (
	"errors"
)

const chessSquares int = 64

func Square(x int) (grains uint64, err error) {
	if x < 1 || x > chessSquares {
		err = errors.New("number must be between 1-64")
	}
	return 1 << uint64(x-1), err
}

func Total() (total uint64) {
	for i := 1; i <= chessSquares; i++ {
		n, _ := Square(i)
		total += n
	}
	return total
}
