//--------------------------------
// 1. IMPORTS
//--------------------------------
// Core Flutter material design widgets and utilities
import 'package:flutter/material.dart';
// BLoC pattern implementation package
import 'package:flutter_bloc/flutter_bloc.dart';
// Import weather-related blocs, events and states
import 'package:weather_app/application/weather_bloc/weather_bloc.dart';
import 'package:weather_app/application/weather_bloc/weather_event.dart';
import 'package:weather_app/application/weather_bloc/weather_state.dart';
// Import weather display widget
import 'weather_display.dart';

//--------------------------------
// 2. SEARCH PAGE WIDGET
//--------------------------------
// Screen for searching weather by city name
class SearchPage extends StatelessWidget {
 // Constructor with key parameter
 const SearchPage({super.key});

 @override
 Widget build(BuildContext context) {
   // Get the WeatherBloc instance from context
   final weatherBloc = BlocProvider.of<WeatherBloc>(context);
   // Controller for the city input text field
   var cityController = TextEditingController();

   //--------------------------------
   // 3. SCREEN STRUCTURE
   //--------------------------------
   return Scaffold(
     // Dark grey background
     backgroundColor: Colors.grey[800],
     // App bar with title
     appBar: AppBar(title: const Text("Search Weather")),
     // Make the content scrollable
     body: SingleChildScrollView(
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         crossAxisAlignment: CrossAxisAlignment.start,
         children: <Widget>[
           // Empty space at top for design
           const Center(
             child: SizedBox(
               height: 180,
               width: 180,
             ),
           ),
           
           //--------------------------------
           // 4. BLOC BUILDER
           //--------------------------------
           // Rebuilds UI based on WeatherState changes
           BlocBuilder<WeatherBloc, WeatherState>(
             builder: (context, state) {
               //--------------------------------
               // 5. INITIAL SEARCH STATE, 
               // the state inside builder ithinte based ann ui chnge avunth 
               // that ee state chnge chaiunth listen chaith ui rebuild chaim
               //--------------------------------
               if (state is WeatherIsNotSearched) {
                 return Container(
                   padding: const EdgeInsets.only(left: 32, right: 32),
                   child: Column(
                     children: [
                       // Title texts
                       const Text(
                         "Search Weather",
                         style: TextStyle(
                           fontSize: 40,
                           fontWeight: FontWeight.w500,
                           color: Colors.white70,
                         ),
                       ),
                       const Text(
                         "Instantly",
                         style: TextStyle(
                           fontSize: 40,
                           fontWeight: FontWeight.w200,
                           color: Colors.white70,
                         ),
                       ),
                       const SizedBox(height: 24),
                       
                       //--------------------------------
                       // 6. SEARCH INPUT FIELD
                       //--------------------------------
                       TextFormField(
                         controller: cityController,
                         //city controller vech ann nml user search enter chaiunn city access chaiunth
                         decoration: const InputDecoration(
                           prefixIcon: Icon(Icons.search, color: Colors.white70),
                           enabledBorder: OutlineInputBorder(
                             borderRadius: BorderRadius.all(Radius.circular(10)),
                             borderSide: BorderSide(
                               color: Colors.white70,
                               style: BorderStyle.solid,
                             ),
                           ),
                           focusedBorder: OutlineInputBorder(
                             borderRadius: BorderRadius.all(Radius.circular(10)),
                             borderSide: BorderSide(
                               color: Colors.blue,
                               style: BorderStyle.solid,
                             ),
                           ),
                           hintText: "City Name",
                           hintStyle: TextStyle(color: Colors.white70),
                         ),
                         style: const TextStyle(color: Colors.white70),
                       ),
                       const SizedBox(height: 20),
                       
                       //--------------------------------
                       // 7. SEARCH BUTTON
                       //--------------------------------
                       SizedBox(
                         width: double.infinity,
                         height: 50,
                         child: TextButton(
                           style: TextButton.styleFrom(
                             shape: const RoundedRectangleBorder(
                               borderRadius: BorderRadius.all(Radius.circular(10)),
                             ),
                             backgroundColor: Colors.lightBlue,
                           ),
                           onPressed: () {
                             // Add search event with city name
                             weatherBloc.add(SearchWeather(cityController.text));

                             //bloc working in search page 

//                             User Input Trigger

                        // User types city name "London" in search field
                        // Presses search or submits


                        // Event Dispatch

                        // UI creates FetchWeatherEvent(city: "London")
                        // Event is added to BLoC using add() method


                        // BLoC Processing

                        // BLoC receives FetchWeatherEvent
                        // Immediately emits WeatherLoading state
                        // Calls repository to fetch data


                        // Repository & API Call

                        // Repository makes API call
                        // Converts response to Weather model


                        // State Updates

                        // Success: BLoC emits WeatherLoaded with weather data
                        // Error: BLoC emits WeatherError with message

                        
                             // Clear the input field
                             cityController.clear();
                           },
                           child: const Text(
                             "Search",
                             style: TextStyle(color: Colors.white70, fontSize: 16),
                           ),
                         ),
                       ),
                     ],
                   ),
                 );
               } 
               //--------------------------------
               // 8. LOADING STATE
               //--------------------------------
               else if (state is WeatherIsLoading) {
                 return const Center(child: CircularProgressIndicator());
               }
               //--------------------------------
               // 9. LOADED STATE
               //--------------------------------
               else if (state is WeatherIsLoaded) {
                 return ShowWeather(state.getWeather, cityController.text);
               }
               //--------------------------------
               // 10. ERROR STATE
               //--------------------------------
               else {
                 return Column(
                   children: [
                     // Error message
                     const Center(
                       child: Text(
                         "Place not found. Please try another place",
                         style: TextStyle(color: Colors.red, fontSize: 16),
                       ),
                     ),
                     const SizedBox(height: 20),
                     // Retry button
                     SizedBox(
                       width: 320,
                       height: 50,
                       child: TextButton(
                         style: TextButton.styleFrom(
                           shape: const RoundedRectangleBorder(
                             borderRadius: BorderRadius.all(Radius.circular(10)),
                           ),
                           backgroundColor: Colors.lightBlue,
                         ),
                         onPressed: () {
                           // Reset weather state to initial
                           BlocProvider.of<WeatherBloc>(context).add(ResetWeather());
                         },
                         child: const Text(
                           "Retry",
                           style: TextStyle(color: Colors.white70, fontSize: 16),
                         ),
                       ),
                     ),
                   ],
                 );
               }
             },
           ),
         ],
       ),
     ),
   );
 }
}