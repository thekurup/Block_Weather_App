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

//--------------------------------
// 7. SAVING STATE
//--------------------------------
// State when weather data is being saved
class WeatherIsSaving extends WeatherState {
 // No additional properties needed while saving
}

//--------------------------------
// 8. SAVE SUCCESS STATE
//--------------------------------
// State when weather data is successfully saved
class WeatherSaveSuccess extends WeatherState {
 // Success message to display to user
 final String message;

 // Constructor to initialize success message
 WeatherSaveSuccess(this.message);

 // Include message in state comparison
 @override
 List<Object?> get props => [message];
}

//--------------------------------
// 9. SAVE ERROR STATE
//--------------------------------
// State when weather data save operation fails
class WeatherSaveError extends WeatherState {
 // Error message to display to user
 final String error;

 // Constructor to initialize error message
 WeatherSaveError(this.error);

 // Include error message in state comparison
 @override
 List<Object?> get props => [error];
}