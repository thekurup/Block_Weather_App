//--------------------------------
// 1. IMPORTS
//--------------------------------
// Import equatable package for easy comparison of objects
import 'package:equatable/equatable.dart';

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