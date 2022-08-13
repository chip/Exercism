package booking

import (
	"fmt"
	"os"
	"time"
)

func parseAppointmentDate(date string) time.Time {
	return parseDateUsingFormat(date, "1/2/2006 15:04:05")
}

func parseDateUsingFormat(date string, format string) time.Time {
	t, err := time.Parse(format, date)
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
	return t
}

// Schedule returns a time.Time from a string containing a date.
func Schedule(date string) time.Time {
	t := parseAppointmentDate(date)
	return t.UTC()
}

// HasPassed returns whether a date has passed.
func HasPassed(date string) bool {
	t, err := time.Parse("January _2, 2006 15:04:05", date)
	if err != nil {
		fmt.Println(err)
	}
	return time.Now().After(t)
}

// IsAfternoonAppointment returns whether a time is in the afternoon.
func IsAfternoonAppointment(date string) bool {
	t, err := time.Parse("Monday, January _2, 2006 15:04:05", date)
	if err != nil {
		fmt.Println(err)
	}
	hour := t.Hour()
	return hour >= 12 && hour < 18
}

// Description returns a formatted string of the appointment time.
// Description("7/25/2019 13:45:00")
// => "You have an appointment on Thursday, July 25, 2019, at 13:45."
func Description(date string) string {
	t := parseAppointmentDate(date)
	return "You have an appointment on " + t.Format("Monday, January 2, 2006, at 15:04") + "."
}

// AnniversaryDate returns a Time with this year's anniversary.
// => 2020-09-15 00:00:00 +0000 UTC
func AnniversaryDate() time.Time {
	return time.Date(time.Now().Year(), time.September, 15, 0, 0, 0, 0, time.UTC)
}
