//--------------------------------
// 1. IMPORTS
//--------------------------------
// Import equatable package for easy comparison of objects
import 'package:equatable/equatable.dart';
import 'package:weather_app/domain/model/weather_model.dart';

//--------------------------------
// 2. BASE EVENT CLASS
//--------------------------------
// Base class for all weather-related events
// Extends Equatable to make it easy to compare events
class WeatherEvent extends Equatable {
 // Override props to tell Equatable how to compare events
 // Empty list since base class has no properties to compare
 @override
 List<Object> get props => [];
}

//--------------------------------
// 3. SEARCH EVENT
//--------------------------------
// Event triggered when user searches weather by city name
class SearchWeather extends WeatherEvent {
 // Property to store the city name
 final String city;  // City name to search for

 // Constructor to initialize the city name
 SearchWeather(this.city);

 // Override props to include city in comparison
 // This means two SearchWeather events with the same city
 // will be considered equal
 @override
 List<Object> get props => [city];
}

//--------------------------------
// 4. RESET EVENT
//--------------------------------
// Event triggered when user wants to reset/clear the weather data
// No properties needed since it's just a reset trigger
class ResetWeather extends WeatherEvent {}

//--------------------------------
// 5. LOCATION FETCH EVENT
//--------------------------------
// Event triggered when user wants weather for current location
// No properties needed since it uses device location
class FetchWeatherByLocation extends WeatherEvent {}

//--------------------------------
// 6. SAVE WEATHER EVENT
//--------------------------------
// Event triggered when user wants to save weather data
class SaveWeather extends WeatherEvent {
 // Weather data to be saved
 final WeatherModel weather;
 // City name for the weather data
 final String city;

 // Constructor to initialize weather and city
 SaveWeather(this.weather, this.city);

 // Include both weather and city in comparison
 // This ensures unique identification of save events
 @override
 List<Object> get props => [weather, city];
}

//--------------------------------
// 7. SAVE SUCCESS EVENT
//--------------------------------
// Event triggered when weather data is successfully saved
class WeatherSaved extends WeatherEvent {
 // Message to confirm save operation
 final String message;

 // Constructor to initialize success message
 WeatherSaved(this.message);

 @override
 List<Object> get props => [message];
}

//--------------------------------
// 8. SAVE ERROR EVENT
//--------------------------------
// Event triggered when weather save operation fails
class WeatherSaveError extends WeatherEvent {
 // Error message for failed save operation
 final String error;

 // Constructor to initialize error message
 WeatherSaveError(this.error);

 @override
 List<Object> get props => [error];
}