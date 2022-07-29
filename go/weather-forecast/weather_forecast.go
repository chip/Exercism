// Package weather is used for weather forecasting in the country of Goblinocus.
package weather

// CurrentCondition describes the current weather.
var CurrentCondition string

// CurrentLocation describes the current city in Goblinocus.
var CurrentLocation string

// Forecast returns the current weather conditions given the city and condition provided.
func Forecast(city, condition string) string {
	CurrentLocation, CurrentCondition = city, condition
	return CurrentLocation + " - current weather condition: " + CurrentCondition
}
