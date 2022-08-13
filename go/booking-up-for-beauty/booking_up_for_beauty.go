package booking

import (
	"fmt"
	"os"
	"time"
)

const (
	appointmentFormat = "1/2/2006 15:04:05"
	hasPassedFormat   = "January _2, 2006 15:04:05"
	afternoonFormat   = "Monday, January _2, 2006 15:04:05"
	descriptionFormat = "Monday, January 2, 2006, at 15:04"
	anniversaryFormat = "2006-01-02 00:00:00 +0000 UTC"
)

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
	t := parseDateUsingFormat(date, appointmentFormat)
	return t.UTC()
}

// HasPassed returns whether a date has passed.
func HasPassed(date string) bool {
	t, err := time.Parse(hasPassedFormat, date)
	if err != nil {
		fmt.Println(err)
	}
	return time.Now().After(t)
}

// IsAfternoonAppointment returns whether a time is in the afternoon.
func IsAfternoonAppointment(date string) bool {
	t, err := time.Parse(afternoonFormat, date)
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
	t := parseDateUsingFormat(date, appointmentFormat)
	return "You have an appointment on " + t.Format(descriptionFormat) + "."
}

// AnniversaryDate returns a Time with this year's anniversary.
// => 2020-09-15 00:00:00 +0000 UTC
func AnniversaryDate() time.Time {
	now := time.Now()
	anniversary := fmt.Sprintf("%d%s", now.Year(), "-09-15 00:00:00 +0000 UTC")

	t := parseDateUsingFormat(anniversary, "2006-01-02 00:00:00 +0000 UTC")
	return t
}
