//--------------------------------
// 1. IMPORTS
//--------------------------------
// Import equatable for easy state comparison
import 'package:equatable/equatable.dart';
// Import our weather model to handle weather data
import 'package:weather_app/domain/model/weather_model.dart';

//--------------------------------
// 2. BASE STATE CLASS
//--------------------------------
// Base class for all weather-related states
// Extends Equatable to make states comparable
class WeatherState extends Equatable {
 // Define how states should be compared (empty for base class)
 @override
 List<Object?> get props => [];
}

//--------------------------------
// 3. INITIAL STATE
//--------------------------------
// State when app starts or is reset
// Shows search screen, no weather data yet
class WeatherIsNotSearched extends WeatherState {
 // No additional properties needed for initial state
}

//--------------------------------
// 4. LOADING STATE
//--------------------------------
// State while fetching weather data
// Shows loading indicator to user
class WeatherIsLoading extends WeatherState {
 // No additional properties needed for loading state
}

//--------------------------------
// 5. SUCCESS STATE
//--------------------------------
// State when weather data is successfully loaded
class WeatherIsLoaded extends WeatherState {
 // Store the weather data
 // ignore: prefer_typing_uninitialized_variables
 final _weather;  // Holds the weather information

 // Constructor to initialize weather data
 WeatherIsLoaded(this._weather);

 // Getter to access weather data in a controlled way
 WeatherModel get getWeather => _weather;
 
 // Include weather data in comparison
 @override
 List<Object?> get props => [_weather];
}

//--------------------------------
// 6. ERROR STATE
//--------------------------------
// State when weather data couldn't be loaded
class WeatherIsNotLoaded extends WeatherState {
 // No additional properties needed for error state
}