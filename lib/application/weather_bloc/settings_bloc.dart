//--------------------------------
// 1. IMPORTS
//--------------------------------
// Import the core Flutter BLoC package for state management
import 'package:flutter_bloc/flutter_bloc.dart';
// Import Equatable for value comparison
import 'package:equatable/equatable.dart';
// Import settings related events and states

import 'package:weather_app/application/settings_state.dart';
import 'package:weather_app/application/weather_bloc/settings_event.dart';

//--------------------------------
// 2. SETTINGS BLOC CLASS
//--------------------------------

// This class handles settings-related logic in the app. It listens for SettingsEvent 
// (e.g., toggling temperature unit or theme) and updates the state (SettingsState) accordingly.
// It takes SettingsEvents as input and outputs SettingsStates

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {

 //--------------------------------
 // 3. CONSTRUCTOR
 //--------------------------------
 // Initialize the bloc with default settings
 SettingsBloc() : super(SettingsLoaded(isCelsius: true, isDarkTheme: false)) {

//   isCelsius: true: Temperature unit defaults to Celsius.
// isDarkTheme: false: Theme defaults to light.

   // Register event handlers for different settings events
   on<ToggleTemperatureUnit>(_onToggleUnit);     // Handle temperature unit changes
   on<ToggleTheme>(_onToggleTheme);   
  //  HandlerFunction: The function that processes this event and updates the state.           // Handle theme changes
 }

 //--------------------------------
 // 4. TEMPERATURE UNIT HANDLER
 //--------------------------------
 // Handles switching between Celsius and Fahrenheit
 void _onToggleUnit(
   ToggleTemperatureUnit event,     // Event to toggle temperature unit
   Emitter<SettingsState> emit      // State emitter
 ) {
   // Get current state
   final currentState = state;
   
   // Check if state is already loaded
   if (currentState is SettingsLoaded) {
     // Log the change
     print('Changing temperature unit from: ${currentState.isCelsius ? "Celsius" : "Fahrenheit"}');
     
     // Emit new state with toggled temperature unit
     emit(SettingsLoaded(
       isCelsius: !currentState.isCelsius,    // Toggle the unit
       isDarkTheme: currentState.isDarkTheme,  // Keep current theme
     ));
     
     // Log the new state
     print('Temperature unit changed to: ${!currentState.isCelsius ? "Celsius" : "Fahrenheit"}');
   }
//    ToggleTemperatureUnit: The event received when the user wants to switch temperature units.
// Emitter<SettingsState>: Used to emit a new state.
// Logic:
// Gets the current state.
// Checks if the state is of type SettingsLoaded (i.e., valid and loaded).
// Toggles isCelsius (e.g., Celsius to Fahrenheit).
// Emits the updated state.
// Logs the changes for debugging.
 }

 //--------------------------------
 // 5. THEME HANDLER
//  ToggleTheme: The event received when the user wants to switch themes.
// Logic:
// Gets the current state.
// Checks if the state is valid (SettingsLoaded).
// Toggles isDarkTheme (e.g., light to dark).
// Emits the updated state.
// Logs the changes for debugging.
 //--------------------------------
 // Handles switching between light and dark theme
 void _onToggleTheme(
   ToggleTheme event,               // Event to toggle theme
   Emitter<SettingsState> emit      // State emitter
 ) {
   // Get current state
   final currentState = state;
   
   // Check if state is already loaded
   if (currentState is SettingsLoaded) {
     // Log the change
     print('Changing theme from: ${currentState.isDarkTheme ? "Dark" : "Light"}');
     
     // Emit new state with toggled theme
     emit(SettingsLoaded(
       isCelsius: currentState.isCelsius,      // Keep current unit
       isDarkTheme: !currentState.isDarkTheme,  // Toggle the theme
     ));
     
     // Log the new state
     print('Theme changed to: ${!currentState.isDarkTheme ? "Dark" : "Light"}');
   }
 }

 //--------------------------------
 // 6. HELPER METHODS
//  Converts temperatures:
// Fahrenheit to Celsius: Subtract 32, then multiply by 
// 5/9.
// Celsius to Fahrenheit: Multiply by 
// 9/5 then add 32.
 //--------------------------------
 // Convert temperature between Celsius and Fahrenheit
 double convertTemperature(double temp, bool toCelsius) {
   if (toCelsius) {
     return (temp - 32) * 5/9;  // Fahrenheit to Celsius
   } else {
     return (temp * 9/5) + 32;  // Celsius to Fahrenheit
   }
 }

 // Get current temperature unit symbol
 String getTemperatureSymbol() {
   final currentState = state;
   if (currentState is SettingsLoaded) {
     return currentState.isCelsius ? '°C' : '°F';
   }
   return '°C';  // Default to Celsius
   
  //  Returns the temperature symbol (°C or °F) based on the current state.

 }

 //--------------------------------
 // 7. ERROR HANDLING
 //--------------------------------
 // Handle any errors that occur during settings changes
 void _handleError(String message) {
   // Log error for debugging
   print('Settings Error: $message');
   
   // Emit error state
   emit(SettingsError(message));
   
   // Reset to default settings after error
   emit(SettingsLoaded(isCelsius: true, isDarkTheme: false));
 }

 //--------------------------------
 // 8. STATE VALIDATION
 //--------------------------------
 // Validate current state before operations
 bool _isValidState() {
   final currentState = state;
   return currentState is SettingsLoaded;
 }
}