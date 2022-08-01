// Package diffsquares can be used to calculate the square of a sum of numbers or sum of squares
package diffsquares

// Given n and some function fn, return the sum of each fn calculation.
// Given n and a nil function, return the sum of each number up to n.
func reduce(n int, fn func(x int) int) int {
	sum := 0
	for i := 1; i <= n; i++ {
		if fn != nil {
			sum += fn(i)
		} else {
			sum += i
		}
	}
	return sum
}

// Return the square of a given number x
func square(x int) int {
	return x * x
}

// Return the square of a sum of numbers
func SquareOfSum(n int) int {
	sum := reduce(n, nil)
	return sum * sum
}

// Return the sum for all n squares
func SumOfSquares(n int) int {
	return reduce(n, square)
}

// Return the difference of the two calculations above
func Difference(n int) int {
	return SquareOfSum(n) - SumOfSquares(n)
}
