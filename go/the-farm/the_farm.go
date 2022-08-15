package thefarm

import (
	"errors"
	"fmt"
)

// See types.go for the types defined for this exercise.

var ErrNegativeFodderError = errors.New("negative fodder")
var ErrDivisionByZeroError = errors.New("division by zero")

func ErrSillyNephewError(cows int) error {
	return fmt.Errorf("silly nephew, there cannot be %d cows", cows)
}

// DivideFood computes the fodder amount per cow for the given cows.
func DivideFood(weightFodder WeightFodder, cows int) (float64, error) {
	amount, err := weightFodder.FodderAmount()
	if err == ErrScaleMalfunction && amount > 0 {
		amount *= 2
	}
	if err != nil && err != ErrScaleMalfunction {
		return 0, ErrNonScaleMalfunction
	}
	if amount < 0 {
		if err == nil || err == ErrScaleMalfunction {
			return 0, ErrNegativeFodderError
		}
	}
	if cows == 0 {
		return 0, ErrDivisionByZeroError
	}
	if cows > 0 {
		return amount / float64(cows), nil
	} else {
		return 0, ErrSillyNephewError(cows)
	}
}
