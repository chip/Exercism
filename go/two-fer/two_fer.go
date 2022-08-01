// Package twofer returns a greeting for a given name argument. If no name is provided, name is assigned to "you".
package twofer

import "fmt"

// ShareWith accepts a name string argument and returns a string greeting
func ShareWith(name string) string {
	defaultName := "you"
	greeting := "One for %s, one for me."
	if name == "" {
		name = defaultName
	}
	return fmt.Sprintf(greeting, name)
}
