package meteorology

import "fmt"

type TemperatureUnit int

const (
	Celsius    TemperatureUnit = 0
	Fahrenheit TemperatureUnit = 1
)

// Add a String method to the TemperatureUnit type
func (tu TemperatureUnit) String() string {
	if tu == 0 {
		return "°C"
	}
	return "°F"
}

type Temperature struct {
	degree int
	unit   TemperatureUnit
}

// Add a String method to the Temperature type
func (t Temperature) String() string {
	return fmt.Sprintf("%d %s", t.degree, t.unit.String())
}

type SpeedUnit int

const (
	KmPerHour    SpeedUnit = 0
	MilesPerHour SpeedUnit = 1
)

// Add a String method to SpeedUnit
func (su SpeedUnit) String() string {
	if su == 0 {
		return "km/h"
	}
	return "mph"
}

type Speed struct {
	magnitude int
	unit      SpeedUnit
}

// Add a String method to Speed
func (sp Speed) String() string {
	return fmt.Sprintf("%d %s", sp.magnitude, sp.unit.String())
}

type MeteorologyData struct {
	location      string
	temperature   Temperature
	windDirection string
	windSpeed     Speed
	humidity      int
}

// Add a String method to MeteorologyData
// Output: San Francisco: 57 °F, Wind NW at 19 mph, 60% Humidity
func (m MeteorologyData) String() string {
	s := "%s: %s, Wind %s at %s, %d%% Humidity"
	return fmt.Sprintf(s, m.location, m.temperature.String(), m.windDirection, m.windSpeed.String(), m.humidity)
}
