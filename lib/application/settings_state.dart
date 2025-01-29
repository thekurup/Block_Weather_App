//--------------------------------
// 1. IMPORTS
//--------------------------------
// Import equatable for state comparison
import 'package:equatable/equatable.dart';

//--------------------------------
// 2. BASE SETTINGS STATE CLASS
//--------------------------------
// Abstract base class for all settings-related states
abstract class SettingsState extends Equatable {
  // Define comparison method for states
  @override
  List<Object> get props => [];
}

//--------------------------------
// 3. INITIAL STATE
//--------------------------------
// Initial state when settings are not yet loaded
class SettingsInitial extends SettingsState {
  // No additional properties needed for initial state
}

//--------------------------------
// 4. SETTINGS LOADED STATE
//--------------------------------
// State when settings are loaded and ready
class SettingsLoaded extends SettingsState {
  // Temperature unit preference (Celsius/Fahrenheit)
  final bool isCelsius;
  
  // Theme preference (Light/Dark)
  final bool isDarkTheme;

  // Constructor with default values
  SettingsLoaded({
    this.isCelsius = true,     // Default to Celsius
    this.isDarkTheme = false,  // Default to Light theme
  });

  // Create a copy of current state with some properties changed
  SettingsLoaded copyWith({
    bool? isCelsius,
    bool? isDarkTheme,
  }) {
    return SettingsLoaded(
      isCelsius: isCelsius ?? this.isCelsius,
      isDarkTheme: isDarkTheme ?? this.isDarkTheme,
    );
  }

  // Override comparison method
  @override
  List<Object> get props => [isCelsius, isDarkTheme];
}

//--------------------------------
// 5. SETTINGS ERROR STATE
//--------------------------------
// State when settings operation fails
class SettingsError extends SettingsState {
  // Error message to display
  final String message;

  // Constructor to initialize error message
  SettingsError(this.message);

  // Include message in state comparison
  @override
  List<Object> get props => [message];
}