//--------------------------------
// 1. IMPORTS
//--------------------------------
import 'package:equatable/equatable.dart';

//--------------------------------
// 2. BASE SETTINGS EVENT CLASS
//--------------------------------
// we use abstract Acts as a parent class for all the event types related to settings.
// You can’t create an object of SettingsEvent directly. Instead, you define specific 
// events (like toggling temperature or theme) as subclasses of this base class.

abstract class SettingsEvent extends Equatable {
  // The equatable package is imported to make comparing objects easier in Flutter
  // In a Bloc pattern, events need to be compared to determine if they are the same (e.g., to avoid duplicate state updates). 
  // Equatable ensures that events with the same properties are treated as equal.

  const SettingsEvent();

  @override
  List<Object> get props => [];
  // This ensures no properties are used for comparison 
  // (since SettingsEvent itself doesn’t hold any data).
  //  Subclasses can override this if they include data.
}

//--------------------------------
// 3. TEMPERATURE UNIT TOGGLE EVENT
//--------------------------------
// Event for toggling between Celsius and Fahrenheit
// This event is triggered when the user wants to toggle between Celsius and Fahrenheit.
class ToggleTemperatureUnit extends SettingsEvent {}

//--------------------------------
// 4. THEME TOGGLE EVENT
//--------------------------------
// Event for toggling between light and dark theme
// This event is triggered when the user wants to toggle between light and dark themes.
class ToggleTheme extends SettingsEvent {}