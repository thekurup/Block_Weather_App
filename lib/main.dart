//--------------------------------
// 1. IMPORTS
//--------------------------------
// Core Flutter material design widgets and utilities
import 'package:flutter/material.dart';
// BLoC pattern implementation package
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/application/settings_state.dart';
import 'package:weather_app/application/weather_bloc/settings_bloc.dart';
// Weather data repository
import 'package:weather_app/domain/repository/weather_repo.dart';
// Screen for displaying current location weather
import 'package:weather_app/presentation/current_weather.dart';
// Weather state management bloc
import 'application/weather_bloc/weather_bloc.dart';
// Settings bloc for app preferences
import 'package:weather_app/application/weather_bloc/settings_event.dart';
// Screen for city search functionality
import 'presentation/search_page.dart';

//--------------------------------
// 2. APP ENTRY POINT
//--------------------------------
// Main function that starts the application
void main() {
 // Initialize and launch the app with MainApp as root
 runApp(const MainApp());
}

//--------------------------------
// 3. ROOT WIDGET
//--------------------------------
// Root widget of the application
// Uses StatelessWidget as it doesn't need to maintain state
class MainApp extends StatelessWidget {
 // Constructor with optional key for widget identification
 const MainApp({super.key});

 // Build method defining the widget structure
 @override
 Widget build(BuildContext context) {
   // MultiBlocProvider to provide multiple blocs to the widget tree
  // MultiBlocProvider makes sure both WeatherBloc and SettingsBloc are available to all child widgets 
  // in the widget tree. This means any widget can access the state and events from these BLoCs.
   return MultiBlocProvider(
     // List of bloc providers
     providers: [
       // Weather bloc provider for weather functionality
       BlocProvider(
         create: (context) => WeatherBloc(WeatherRepository()),
       ),
       // Settings bloc provider for app preferences
       BlocProvider(
       
         create: (context) => SettingsBloc(),
       ),
     ],
     
     // MaterialApp sets up the basic app structure
     child: BlocBuilder<SettingsBloc, SettingsState>(
       // It listens for changes in SettingsBloc 
        // and rebuilds the widget whenever the SettingsState changes
       // Build UI based on settings state
       builder: (context, state) {
        // the builder function gets executed every time the SettingsState changes. 
        // The state is passed as an argument to this function.
         // Get current theme from settings
         final isDark = state is SettingsLoaded ? state.isDarkTheme : false;
         
         return MaterialApp(
           // App theme color and settings
           theme: isDark ? ThemeData.dark() : ThemeData.light(),
           // Remove debug banner from top-right corner
           debugShowCheckedModeBanner: false,
           // Initial screen of the app
           home: const MainScreen(),
         );
       }
     ),
   );
 }
}

//--------------------------------
// 4. MAIN SCREEN
//--------------------------------
// Main screen widget with navigation buttons
class MainScreen extends StatelessWidget {
 // Constructor with key parameter
 const MainScreen({super.key});

 // Build method for creating the screen's UI
 @override
 Widget build(BuildContext context) {
   // Get settings bloc instance
   final settingsBloc = context.read<SettingsBloc>();
   
   // Scaffold provides the basic screen structure
   return Scaffold(
     // Dark grey background color
     backgroundColor: Colors.grey[900],
     
     // Center everything in the screen
     body: Center(
       // Vertical arrangement of widgets
       child: Column(
         // Center content vertically
         mainAxisAlignment: MainAxisAlignment.center,
         
         // List of widgets to display
         children: [
           //--------------------------------
           // 5. CITY SEARCH BUTTON
           //--------------------------------
           ElevatedButton(
             // Navigation handler
             onPressed: () {
               // Navigate to search page
               Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) => const SearchPage()),
               );
             },
             // Button label with padding
             child: const Text("      Search by City      "),
           ),
           
           // Vertical space between buttons
           const SizedBox(height: 10),
           
           //--------------------------------
           // 6. CURRENT LOCATION BUTTON
           //--------------------------------
           ElevatedButton(
             // Navigation handler
             onPressed: () {
               // Navigate to current weather page
               Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) => const CurrentWeather()),
               );
             },
             // Button label with padding
             child: const Text("    Current Location    "),
           ),

           //--------------------------------
           // 7. SETTINGS BUTTONS
           //--------------------------------
           // Vertical space before settings
           const SizedBox(height: 20),
           
           // Temperature unit toggle button
           
           
           // Theme toggle button
           ElevatedButton(
             onPressed: () {
               // Toggle theme
               settingsBloc.add(ToggleTheme());
             },
             child: const Text("Toggle Theme"),
           ),
         ],
       ),
     ),
   );
 }
}