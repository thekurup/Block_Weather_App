//--------------------------------
// 1. IMPORTS
//--------------------------------
// Import required packages and local files
import 'package:flutter_bloc/flutter_bloc.dart';    // For BLoC pattern implementation
import 'package:weather_app/application/weather_bloc/weather_event.dart';    // Weather events
import 'package:weather_app/application/weather_bloc/weather_state.dart';    // Weather states
import 'package:weather_app/domain/model/weather_model.dart';               // Weather data model
import 'package:weather_app/domain/repository/weather_repo.dart';           // Weather data repository

//--------------------------------
// 2. WEATHER BLOC CLASS
//--------------------------------
// This class manages all weather-related state changes and business logic
// It takes WeatherEvents as input and outputs WeatherStates
class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
 //--------------------------------
 // 3. PROPERTIES
 //--------------------------------
 // Repository instance to handle data fetching
 final WeatherRepository weatherRepo;
 
 //--------------------------------
 // 4. CONSTRUCTOR
 //--------------------------------
 // Initialize the bloc with repository and register event handlers
 WeatherBloc(this.weatherRepo) : super(WeatherIsNotSearched()) {
   // Register handlers for different events
   on<SearchWeather>(_onSearchWeather);                 // Handle city search
   on<ResetWeather>(_onResetWeather);                  // Handle reset action
   on<FetchWeatherByLocation>(_onFetchWeatherByLocation);  // Handle location-based weather
 }

 //--------------------------------
 // 5. EVENT HANDLERS
 //--------------------------------
 // Handler for city search event
 Future<void> _onSearchWeather(
   SearchWeather event,         // Contains city name
   Emitter<WeatherState> emit   // Used to emit new states
 ) async {
   // Step 1: Show loading indicator
   emit(WeatherIsLoading());

   try {
     // Step 2: Attempt to fetch weather data
     WeatherModel weather = await weatherRepo.getWeather(event.city);
     // Step 3: If successful, emit loaded state with weather data
     emit(WeatherIsLoaded(weather));
   } catch (_) {
     // Step 4: If error occurs, emit error state
     emit(WeatherIsNotLoaded());
   }
 }

 // Handler for location-based weather fetch event
 Future<void> _onFetchWeatherByLocation(
   FetchWeatherByLocation event,  // Event trigger
   Emitter<WeatherState> emit     // State emitter
 ) async {
   // Step 1: Show loading indicator
   emit(WeatherIsLoading());

   try {
     // Step 2: Attempt to fetch weather for current location
     WeatherModel weather = await weatherRepo.getWeatherByLocation();
     // Step 3: If successful, emit loaded state with weather data
     emit(WeatherIsLoaded(weather));
   } catch (_) {
     // Step 4: If error occurs, emit error state
     emit(WeatherIsNotLoaded());
   }
 }

 // Handler for reset event
 void _onResetWeather(
   ResetWeather event,         // Reset trigger
   Emitter<WeatherState> emit  // State emitter
 ) {
   // Reset to initial state (not searched)
   emit(WeatherIsNotSearched());
 }
}