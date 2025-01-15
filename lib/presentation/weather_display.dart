//--------------------------------
// 1. IMPORTS
//--------------------------------
// Core Flutter material design widgets
import 'package:flutter/material.dart';
// BLoC pattern implementation
import 'package:flutter_bloc/flutter_bloc.dart';
// Weather-related components
import 'package:weather_app/application/weather_bloc/weather_bloc.dart';
import 'package:weather_app/application/weather_bloc/weather_event.dart';
import 'package:weather_app/domain/model/weather_model.dart';

//--------------------------------
// 2. SHOW WEATHER WIDGET
//--------------------------------
// Widget to display weather information
// ignore: must_be_immutable
class ShowWeather extends StatelessWidget {
 // Weather data model instance
 WeatherModel weather;
 // City name or "Current Location"
 final String city;

 // Constructor initializing weather data and city
 ShowWeather(this.weather, this.city, {super.key});

 @override
 Widget build(BuildContext context) {
   //--------------------------------
   // 3. MAIN CONTAINER
   //--------------------------------
   return Container(
     // Padding for layout spacing
     padding: const EdgeInsets.only(right: 32, left: 32, top: 10),
     // Vertical arrangement of weather info
     child: Column(
       children: <Widget>[
         //--------------------------------
         // 4. LOCATION HEADER
         //--------------------------------
         // Display city name or "Current Location"
         Text(
           city,
           style: const TextStyle(
             color: Colors.white70, 
             fontSize: 30, 
             fontWeight: FontWeight.bold
           )
         ),
         // Vertical spacing
         const SizedBox(height: 10),

         //--------------------------------
         // 5. CURRENT TEMPERATURE
         //--------------------------------
         // Display current temperature in Celsius
         Text(
           "${weather.getTemp.round()} C",
           style: const TextStyle(color: Colors.white70, fontSize: 50)
         ),
         // Temperature label
         const Text(
           "Temperature",
           style: TextStyle(color: Colors.white70, fontSize: 14)
         ),

         //--------------------------------
         // 6. MIN-MAX TEMPERATURES
         //--------------------------------
         // Row for minimum and maximum temperatures
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
             // Minimum Temperature Column
             Column(
               children: <Widget>[
                 Text(
                   "${weather.getMinTemp.round()} C",
                   style: const TextStyle(color: Colors.white70, fontSize: 30),
                 ),
                 const Text(
                   "Min Temperature",
                   style: TextStyle(color: Colors.white70, fontSize: 14),
                 ),
               ],
             ),
             // Maximum Temperature Column
             Column(
               children: <Widget>[
                 Text(
                   "${weather.getMaxTemp.round()} C",
                   style: const TextStyle(color: Colors.white70, fontSize: 30),
                 ),
                 const Text(
                   "Max Temperature",
                   style: TextStyle(color: Colors.white70, fontSize: 14),
                 ),
               ],
             ),   
           ],
         ),
         // Vertical spacing
         const SizedBox(height: 20),

         //--------------------------------
         // 7. BACK BUTTON
         //--------------------------------
         // Full-width button container
         SizedBox(
           width: double.infinity,
           height: 50,
           child: TextButton(
             // Button styling
             style: TextButton.styleFrom(
               shape: const RoundedRectangleBorder(
                 borderRadius: BorderRadius.all(Radius.circular(10)),
               ),
               backgroundColor: Colors.lightBlue,
             ),
             // Reset weather state on press
             onPressed: () {
               BlocProvider.of<WeatherBloc>(context).add(ResetWeather());
             },
             // Button text
             child: const Text(
               "Back to Home", 
               style: TextStyle(color: Colors.white70, fontSize: 16),
             ),
           ),
         )
       ],
     ),
   );
 }
}