package clock

import (
	"fmt"
)

// Define the Clock type here.
type Clock struct {
	hour   int
	minute int
}

const (
	hoursPerDay    = 24
	minutesPerHour = 60
)

func New(h, m int) Clock {
	totalMinutes := (h * minutesPerHour) + m
	hour, minute := (totalMinutes/minutesPerHour)%hoursPerDay, totalMinutes%minutesPerHour
	if totalMinutes < 0 {
		if hour == 0 {
			hour = hoursPerDay + h
			if hour == 24 {
				hour--
			}
		} else {
			hour = hoursPerDay + hour - 1
			if m == 0 {
				hour++
			}
		}
	}
	if minute < 0 {
		minute += minutesPerHour
	}
	return Clock{hour: hour, minute: minute}
}

func (c Clock) Add(m int) Clock {
	return New(c.hour, c.minute+m)
}

func (c Clock) Subtract(m int) Clock {
	return New(c.hour, c.minute-m)
}

func (c Clock) String() string {
	return fmt.Sprintf("%02d:%02d", c.hour, c.minute)
}
