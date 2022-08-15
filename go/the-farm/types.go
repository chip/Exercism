package thefarm

import (
	"errors"
	"fmt"
)

// This file contains types used in the exercise but should not be modified.

// WeightFodder returns the amount of available fodder.
type WeightFodder interface {
	FodderAmount() (float64, error)
}

// ErrScaleMalfunction indicates an error with the scale.
var ErrScaleMalfunction = errors.New("sensor error")

// ErrNonScaleMalfunction indicates an error unrelated with the scale.
var ErrNonScaleMalfunction = errors.New("non-scale error")

var ErrNegativeFodderError = errors.New("negative fodder")
var ErrDivisionByZeroError = errors.New("division by zero")

func ErrSillyNephewError(cows int) error {
	return fmt.Errorf("silly nephew, there cannot be %d cows", cows)
}
