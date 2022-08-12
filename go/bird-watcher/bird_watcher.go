package birdwatcher

// TotalBirdCount return the total bird count by summing
// the individual day's counts.
func TotalBirdCount(birdsPerDay []int) int {
	sum := 0
	for _, count := range birdsPerDay {
		sum += count
	}
	return sum
}

// BirdsInWeek returns the total bird count by summing
// only the items belonging to the given week.
func BirdsInWeek(birdsPerDay []int, week int) int {
	daysPerWeek := 7
	upperBound := daysPerWeek * week
	lowerBound := upperBound - daysPerWeek
	birds := birdsPerDay[lowerBound:upperBound]
	return TotalBirdCount(birds)
}

// FixBirdCountLog returns the bird counts after correcting
// the bird counts for alternate days.
func FixBirdCountLog(birdsPerDay []int) []int {
	for index, count := range birdsPerDay {
		if index%2 == 0 {
			birdsPerDay[index] = count + 1
		}
	}
	return birdsPerDay
}
