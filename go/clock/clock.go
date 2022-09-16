package clock

import (
	"fmt"
	"log"
	"math"
)

// Define the Clock type here.
type Clock struct {
	hour   int
	minute int
}

const (
	hoursPerDay      = 24
	secondsPerMinute = 60
	minutesPerHour   = 60
	secondsPerHour   = secondsPerMinute * minutesPerHour
)

func debug(h, m int) bool {
	return h == -91 && m == 0
}

func New(h, m int) Clock {
	totalMinutes := (h * minutesPerHour) + m
	hour, minute := totalMinutes/minutesPerHour, totalMinutes%minutesPerHour
	if math.Abs(float64(hour)) >= float64(hoursPerDay) {
		hour = hour % hoursPerDay
	}
	if debug(h, m) {
		fmt.Println("h", h, "m", m, "hour", hour, "minute", minute, "totalMinutes", totalMinutes)
	}

	// 	h -1 m 15 hour 0 minute -45 totalMinutes -45
	// hour % hoursPerDay 0
	// *** h -1 m 15 hour 25 minute -45 totalMinutes -45
	// RETURN h -1 m 15 hour 25 minute 15 totalMinutes -45
	//
	// --- FAIL: TestCreateClock (0.00s)
	//     --- FAIL: TestCreateClock/negative_hour (0.00s)
	//         clock_test.go:11: New(-1, 15) = "01:15", want "23:15"
	//
	if totalMinutes < 0 {
		// hour = hoursPerDay + (hour % hoursPerDay) - h
		if debug(h, m) {
			fmt.Println("hour % hoursPerDay", hour%hoursPerDay)
		}
		if hour == 0 {
			if debug(h, m) {
				fmt.Println("hour == 0")
			}
			hour = hoursPerDay + h
		} else {
			if debug(h, m) {
				fmt.Println("else", hour%hoursPerDay)
			}
			hour = hoursPerDay + (hour % hoursPerDay) - 1
			if hour < 0 {
				if debug(h, m) {
					fmt.Println("if hour < 0", hour)
				}
				// hour--
			} else {
				if debug(h, m) {
					fmt.Println("if hour > 0", hour)
				}
				// hour = hoursPerDay + (hour % hoursPerDay) + 1
				if m == 0 {
					hour++
				}
			}
		}
		// hour = hoursPerDay + (hour % hoursPerDay) - h
	}
	if debug(h, m) {
		fmt.Println("*** h", h, "m", m, "hour", hour, "minute", minute, "totalMinutes", totalMinutes)
	}
	// if m < 0 && minute != 0 {
	// 	hour = hoursPerDay - (totalMinutes / minutesPerHour) + 1
	// 	hour = hoursPerDay + h - (totalMinutes / minutesPerHour) + 1
	// }
	// if h < 0 {
	// 	hour = hour % hoursPerDay
	// }
	if minute < 0 {
		minute += minutesPerHour
	}
	if debug(h, m) {
		fmt.Println("RETURN h", h, "m", m, "hour", hour, "minute", minute, "totalMinutes", totalMinutes)
		fmt.Println("")
	}
	return Clock{hour: hour, minute: minute}
}

func __New(h, m int) Clock {
	n := -4820
	if m == n {
		log.Println(">>>> >>> >>> >>> >>> >>> >>> >>> >>> >>> >>> >>> >> NEW TEST")
		log.Println("h", h)
		log.Println("m", m)
	}
	hoursFromMinutes := m / minutesPerHour
	if m == n {
		log.Println("hoursFromMinutes", hoursFromMinutes)
	}
	if m < 0 {
		hoursFromMinutes = int(math.Round(float64(hoursFromMinutes)))
	}
	if m == n {
		log.Println("hoursFromMinutes", hoursFromMinutes)
	}
	hour := (h + int(hoursFromMinutes)) % hoursPerDay
	rem := math.Mod(float64(m), float64(minutesPerHour))
	if m == n {
		fmt.Println("math.Mod", rem)
	}

	if rem < 0 && h > 1 {
		hour--
	}

	// hour := int(hoursFromMinutes) % hoursPerDay
	// if math.Mod(float64(m), float64(minutesPerHour)) < 0 {
	// 	hour += h
	// }
	if m == n {
		log.Println("hour", hour)
	}
	if hour < 0 {
		hour += hoursPerDay
		if m == n {
			log.Println("hour (part 2):", hour)
		}
	}
	minute := int(math.Mod(float64(m), float64(minutesPerHour)))
	if m == n {
		log.Println("minute", minute)
	}
	if minute < 0 {
		minute += minutesPerHour
		if m == n {
			log.Println("minute < 0", minute)
		}
		// if h == 1 {
		// 	hour--
		// }
	}
	// if hoursFromMinutes > float64(int(hoursFromMinutes)) && minute < 0 {
	// 	hour -= h
	// }
	return Clock{hour: hour, minute: minute}
}

func (c Clock) Add(m int) Clock {
	c.minute += m
	return c
}

func (c Clock) Subtract(m int) Clock {
	c.minute -= m
	return c
}

func (c Clock) String() string {
	hour := c.hour % 24
	return fmt.Sprintf("%02d:%02d", hour, c.minute)
}
