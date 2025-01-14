// Import the core Flutter material design widgets and components
import 'package:flutter/material.dart';
// Import the flutter_bloc package for BLoC pattern implementation
import 'package:flutter_bloc/flutter_bloc.dart';
// Import the weather repository that handles data fetching
import 'package:weather_app/domain/repository/weather_repo.dart';
// Import the screen for displaying current weather
import 'package:weather_app/presentation/current_weather.dart';
// Import the WeatherBloc that manages the app's state
import 'application/weather_bloc/weather_bloc.dart';
// Import the search page screen
import 'presentation/search_page.dart';

// The main entry point of the application
void main() {
  // Initialize and run the app with MainApp as the root widget
  runApp(const MainApp());
}

// Define the root widget of the application
// StatelessWidget is used because this widget doesn't need to maintain any state
class MainApp extends StatelessWidget {

  const MainApp({super.key});

  // The build method that creates the widget tree
  @override
  Widget build(BuildContext context) {
    // BlocProvider makes the WeatherBloc available to all child widgets in the tree
    return BlocProvider(
      // Create a new instance of WeatherBloc with a WeatherRepository
      // This WeatherBloc will manage all weather-related state changes
      create: (context) => WeatherBloc(WeatherRepository()),
      
      // MaterialApp is the root widget that provides material design functionality
      child: const MaterialApp(
        // Set the app's background color
        color: Colors.black,
        // Hide the debug banner in the top-right corner of the app
        debugShowCheckedModeBanner: false,
        // Set MainScreen as the home screen (initial screen) of the app
        home: MainScreen(),
      ),
    );
  }
}

// Define the main screen widget that shows the navigation buttons
// This is a StatelessWidget as it doesn't need to maintain any internal state
class MainScreen extends StatelessWidget {
  // Constructor with optional key parameter for widget identification
  const MainScreen({super.key});

  // Build method to create the widget tree for MainScreen
  @override
  Widget build(BuildContext context) {
    // Scaffold provides the basic material design layout structure
    return Scaffold(
      // Set the background color to a dark grey shade
      // The [] operator is used to access predefined shades of the color
      backgroundColor: Colors.grey[900],
      
      // Center widget aligns its child in the middle of the available space
      body: Center(
        // Column arranges its children in a vertical array
        child: Column(
          // Center the column's content vertically in the available space
          mainAxisAlignment: MainAxisAlignment.center,
          
          // List of widgets to be displayed vertically
          children: [
            // Button for navigating to city search functionality
            ElevatedButton(
              // Define what happens when the button is pressed
              onPressed: () {
                // Navigate to the SearchPage screen when pressed
                // Navigator.push adds a new route to the navigation stack
                Navigator.push(
                  context,
                  // MaterialPageRoute provides platform-specific transitions
                  MaterialPageRoute(builder: (context) => const SearchPage()),
                );
              },
              // Button text with extra padding using spaces
              child: const Text("      Search by City      "),
            ),
            
            // Add vertical spacing of 10 logical pixels between buttons
            const SizedBox(height: 10),
            
            // Button for getting weather at current location
            ElevatedButton(
              // Define what happens when the button is pressed
              onPressed: () {
                // Navigate to the CurrentWeather screen when pressed
                Navigator.push(
                  context,
                  // MaterialPageRoute provides platform-specific transitions
                  MaterialPageRoute(builder: (context) => const CurrentWeather()),
                );
              },
              // Button text with extra padding using spaces
              child: const Text("    Current Location    "),
            ),
          ],
        ),
      ),
    );
  }
}