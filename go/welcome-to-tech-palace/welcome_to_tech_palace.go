package techpalace

import (
	"fmt"
	"strings"
)

// WelcomeMessage returns a welcome message for the customer.
func WelcomeMessage(customer string) string {
	var b strings.Builder
	fmt.Fprintf(&b, "Welcome to the Tech Palace, %s", strings.ToUpper(customer))
	return b.String()
}

// AddBorder adds a border to a welcome message.
func AddBorder(welcomeMsg string, numStarsPerLine int) string {
	stars := strings.Repeat("*", numStarsPerLine)
	s := []string{stars, welcomeMsg, stars}
	return strings.Join(s, "\n")
}

// CleanupMessage cleans up an old marketing message.
func CleanupMessage(oldMsg string) string {
	s := strings.ReplaceAll(oldMsg, "*", "")
	s = strings.ReplaceAll(s, "\n", "")
	return strings.TrimSpace(s)
}
