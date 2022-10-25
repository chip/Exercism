package letter

import "fmt"

// FreqMap records the frequency of each rune in a given text.
type FreqMap map[rune]int

// Frequency counts the frequency of each rune in a given text and returns this
// data as a FreqMap.
func Frequency(s string) FreqMap {
	m := FreqMap{}
	for _, r := range s {
		m[r]++
	}
	return m
}

// ConcurrentFrequency counts the frequency of each rune in the given strings,
// by making use of concurrency.
func ConcurrentFrequency(l []string) FreqMap {
	var s string
	for _, r := range l {
		s += r
	}
	go Frequency(s)

	// var input string
	// fmt.Scanln(&input)
	var m FreqMap{}
	fmt.Scanln(&m)

	return m
}
