// Package raindrops converts a number into a string that contains raindrop
// sounds corresponding to certain potential factors (a number that evenly
// divides into another number, leaving no remainder)
package raindrops

import (
	"fmt"
	"math"
)

// Convert accepts a number as an integer argument and converts it to a string of raindrop sounds
func Convert(number int) string {
	s := ""
	factors := []int{3, 5, 7}
	for _, factor := range factors {
		if math.Mod(float64(number), float64(factor)) == 0 {
			switch factor {
			case 3:
				s = s + "Pling"
			case 5:
				s = s + "Plang"
			case 7:
				s = s + "Plong"
			}
		}
	}
	if s != "" {
		return s
	}
	return fmt.Sprint(number)
}
