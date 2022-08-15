package thefarm

import (
	"errors"
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
