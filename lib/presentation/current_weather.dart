//--------------------------------
// 1. IMPORTS
//--------------------------------
// Core Flutter material design widgets
import 'package:flutter/material.dart';
// BLoC pattern implementation
import 'package:flutter_bloc/flutter_bloc.dart';
// Weather-related bloc components
import 'package:weather_app/application/weather_bloc/weather_bloc.dart';
import 'package:weather_app/application/weather_bloc/weather_event.dart';
import 'package:weather_app/application/weather_bloc/weather_state.dart';
// Custom weather display widget
import 'weather_display.dart';

//--------------------------------
// 2. CURRENT WEATHER WIDGET
//--------------------------------
// Screen for displaying weather at user's current location
class CurrentWeather extends StatelessWidget {
 // Constructor with key parameter
 const CurrentWeather({super.key});

 @override
 Widget build(BuildContext context) {
   //--------------------------------
   // 3. BLOC ACCESS
   //--------------------------------
   // Get WeatherBloc instance from context for state management
   final weatherBloc = BlocProvider.of<WeatherBloc>(context);

   //--------------------------------
   // 4. SCREEN STRUCTURE
   //--------------------------------
   return Scaffold(
     // Set medium grey background color
     backgroundColor: Colors.grey[600],
     // App bar with title
     appBar: AppBar(title: const Text("Current Location Weather")),
     
     //--------------------------------
     // 5. MAIN CONTENT WITH BLOC BUILDER
     //--------------------------------
     // BlocBuilder handles UI updates based on weather states
     body: BlocBuilder<WeatherBloc, WeatherState>(
       builder: (context, state) {
         //--------------------------------
         // 6. STATE HANDLING
         //--------------------------------
         // Loading State: Show spinner while fetching data
         if (state is WeatherIsLoading) {
           return const Center(child: CircularProgressIndicator());
         } 
         // Loaded State: Show weather data
         else if (state is WeatherIsLoaded) {
           return ShowWeather(state.getWeather, "Current Location");
         } 
         // Error State: Show error message
         else if (state is WeatherIsNotLoaded) {
           return const Center(child: Text("Failed to fetch weather"));
         } 
         // Initial State: Show instruction message
         else {
           return const Center(
             child: Text(
               "Press the button to fetch weather", 
               style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)
             )
           );
         }
       },
     ),
     
     //--------------------------------
     // 7. FLOATING ACTION BUTTON
     //--------------------------------
     // Button to trigger location-based weather fetch
     floatingActionButton: FloatingActionButton(
       onPressed: () {
         // Add event to fetch weather for current location
         weatherBloc.add(FetchWeatherByLocation());
//          User taps "Current Location" button
// FetchWeatherByLocation event is created
// WeatherBloc calls getWeatherByLocation()
// Location service asks for permission
// If allowed:

// Gets GPS coordinates
// Calls API with coordinates
// Returns weather data


// If denied/error:

// Throws exception
// UI shows error message
       },
       // Location icon
       child: const Icon(Icons.my_location),
     ),
   );
 }
}