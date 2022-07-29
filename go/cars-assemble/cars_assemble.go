package cars

import "math"

// CalculateWorkingCarsPerHour calculates how many working cars are
// produced by the assembly line every hour.
func CalculateWorkingCarsPerHour(productionRate int, successRate float64) float64 {
	return float64(productionRate) * successRate / 100
}

// CalculateWorkingCarsPerMinute calculates how many working cars are
// produced by the assembly line every minute.
func CalculateWorkingCarsPerMinute(productionRate int, successRate float64) int {
	CarsPerHour := CalculateWorkingCarsPerHour(productionRate, successRate)
	CarsPerMinute := CarsPerHour / float64(60)
	return int(math.Floor(CarsPerMinute))
}

// CalculateCost works out the cost of producing the given number of cars.
func CalculateCost(carsCount int) uint {
	costOfOneCar := 10000
	groupsOfTen := carsCount / 10
	if groupsOfTen == 0 {
		return uint(carsCount) * uint(costOfOneCar)
	}
	costOfTenCars := 95000
	groupCost := groupsOfTen * costOfTenCars
	remainder := carsCount - (groupsOfTen * 10)
	remainderCost := remainder * costOfOneCar

	return uint(groupCost) + uint(remainderCost)
}
