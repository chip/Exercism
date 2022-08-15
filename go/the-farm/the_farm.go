package thefarm

// See types.go for the types defined for this exercise.

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
