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

// 2022/09/14 20:12:05 >>>> >>> >>> >>> >>> >>> >>> >>> >>> >>> >>> >>> >> NEW TEST
// 2022/09/14 20:12:05 h 1
// 2022/09/14 20:12:05 m -4820
// 2022/09/14 20:12:05 remainder -80.33333333333333
// 2022/09/14 20:12:05 hoursFromMinutes -80
// 2022/09/14 20:12:05 totalHours -55
// 2022/09/14 20:12:05 hour -7
// 2022/09/14 20:12:05 hour 2 17
// 2022/09/14 20:12:05 hour 3 41
// 2022/09/14 20:12:05 minute -20
// 2022/09/14 20:12:05 minute < 0 40

// --- FAIL: TestCreateClock (0.00s)
//     --- FAIL: TestCreateClock/negative_minutes_roll_over_continuously (0.00s)
//         clock_test.go:11: New(1, -4820) = "17:40", want "16:40"
func New(h, m int) Clock {
	log.Println(">>>> >>> >>> >>> >>> >>> >>> >>> >>> >>> >>> >>> >> NEW TEST")
	log.Println("h", h)
	log.Println("m", m)
	remainder := float64(m) / float64(minutesPerHour)
	log.Println("remainder", remainder)
	hoursFromMinutes := remainder
	if m < 0 {
		hoursFromMinutes = math.Round(remainder)
	}
	log.Println("hoursFromMinutes", hoursFromMinutes)
	totalHours := hoursPerDay + h + int(hoursFromMinutes)
	if h < 0 {
		totalHours += hoursPerDay
		// totalHours = int(math.Remainder(float64(h), float64(hoursPerDay)))
	}
	log.Println("totalHours", totalHours)
	hour := int(totalHours % hoursPerDay)
	log.Println("hour", hour)
	if hour < 0 {
		hour += hoursPerDay
		log.Println("hour 2", hour)
	}
	if hoursFromMinutes < 0 {
		hour += hoursPerDay
		log.Println("hour 3", hour)
	}
	// log.Println("hour 4", hour)
	minute := int(math.Mod(float64(m), float64(minutesPerHour)))
	log.Println("minute", minute)
	// if m < 0.0 {
	// if math.Signbit(float64(minute)) {
	if minute < 0 {
		// minute = int(minutesPerHour + math.Mod(float64(m), float64(minutesPerHour)))
		minute += minutesPerHour
		log.Println("minute < 0", minute)
	}
	// if minute < 0 {
	// 	hour--
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
	// if c.hour >= 24 {
	// 	hour = c.hour % 24
	// }
	return fmt.Sprintf("%02d:%02d", hour, c.minute)
}
