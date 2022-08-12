package lasagna

// Calculate preparation time by multiplying the number of layers by the averagePrepTimePerLayer
// Set a default of 2 if avgPrepTimePerLayer arg is 0 to ensure a positive time returned
func PreparationTime(layers []string, avgPrepTimePerLayer int) int {
	if avgPrepTimePerLayer == 0 {
		avgPrepTimePerLayer = 2
	}
	return len(layers) * avgPrepTimePerLayer
}

// Calculate the amount of noodles in grams (int) and sauce in liters (float64) for layers arg
func Quantities(layers []string) (int, float64) {
	noodles := 0
	sauce := 0.0
	for _, layer := range layers {
		if layer == "noodles" {
			noodles += 50
		}
		if layer == "sauce" {
			sauce += 0.2
		}
	}
	return noodles, sauce
}

// Fetch the last item from the friends ingredient list and set it as the last item of my ingredients
func AddSecretIngredient(friendsList []string, myList []string) {
	lastItemIndex := len(friendsList) - 1
	secretIngredient := friendsList[lastItemIndex]
	lastItemIndex = len(myList) - 1
	myList[lastItemIndex] = secretIngredient
}

// The amounts listed in your cookbook only yield enough lasagna for two portions.
// Since you want to cook for more people next time, you want to calculate the
// amounts for different numbers of portions.
//
// Return revised amounts that includes the elements scaled according to their
// scaling factor (i.e., portions / 2)
func ScaleRecipe(amounts []float64, portions int) []float64 {
	servingsPerAmount := 2.0
	scalingFactor := float64(portions) / servingsPerAmount
	scaledAmounts := make([]float64, len(amounts))
	for i, amount := range amounts {
		scaledAmounts[i] = amount * scalingFactor
	}
	return scaledAmounts
}
