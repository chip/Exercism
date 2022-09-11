package clock

import (
	"fmt"
	"math"
)

// Define the Clock type here.
type Clock struct {
	hour   int
	minute int
}

func New(h, m int) Clock {
	if m >= 60 {
		tmpClock := convertMinutes(m)

		if tmpClock.hour > 0 {
			h += tmpClock.hour
		}
		m += tmpClock.minute
	}
	return Clock{hour: h, minute: m}
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

func convertMinutes(m int) Clock {
	minutesPerHour := 60.0
	hours := int(math.Mod(float64(m), minutesPerHour))
	minutes := int(math.Remainder(float64(m), minutesPerHour))
	return Clock{hour: hours, minute: minutes}
}
