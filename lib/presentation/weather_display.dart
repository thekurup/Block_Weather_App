//--------------------------------
// 1. IMPORTS
//--------------------------------
// Core Flutter material design widgets
import 'package:flutter/material.dart';
// BLoC pattern implementation
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/application/settings_state.dart';
import 'package:weather_app/application/weather_bloc/settings_bloc.dart';
// Weather-related components
import 'package:weather_app/application/weather_bloc/weather_bloc.dart';
import 'package:weather_app/application/weather_bloc/weather_event.dart';
import 'package:weather_app/application/weather_bloc/weather_state.dart';
// Settings-related components
import 'package:weather_app/application/weather_bloc/settings_event.dart';
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

  // Helper method for temperature conversion
  String _getTemperature(double temp, bool isCelsius) {
    if (isCelsius) {
      return "${temp.round()}°C";
    } else {
      double fahrenheit = (temp * 9/5) + 32;
      return "${fahrenheit.round()}°F";
    }
  }

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
          // 5. CURRENT TEMPERATURE WITH SETTINGS
          //--------------------------------
          // Use BlocBuilder to handle temperature unit changes
          BlocBuilder<SettingsBloc, SettingsState>(
            builder: (context, state) {
              final isCelsius = state is SettingsLoaded ? state.isCelsius : true;
              return Column(
                children: [
                  Text(
                    _getTemperature(weather.getTemp, isCelsius),
                    style: const TextStyle(color: Colors.white70, fontSize: 50)
                  ),
                  const Text(
                    "Temperature",
                    style: TextStyle(color: Colors.white70, fontSize: 14)
                  ),
                ],
              );
            },
          ),

          //--------------------------------
          // 6. MIN-MAX TEMPERATURES WITH SETTINGS
          //--------------------------------
          // BlocBuilder for min-max temperatures with unit settings
          BlocBuilder<SettingsBloc, SettingsState>(
            builder: (context, state) {
              final isCelsius = state is SettingsLoaded ? state.isCelsius : true;
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // Minimum Temperature Column
                  Column(
                    children: <Widget>[
                      Text(
                        _getTemperature(weather.getMinTemp, isCelsius),
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
                        _getTemperature(weather.getMaxTemp, isCelsius),
                        style: const TextStyle(color: Colors.white70, fontSize: 30),
                      ),
                      const Text(
                        "Max Temperature",
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                    ],
                  ),   
                ],
              );
            },
          ),
          // Vertical spacing
          const SizedBox(height: 20),

          //--------------------------------
          // 7. SAVE BUTTON WITH API DEMONSTRATION
          //--------------------------------
          // Full-width save button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: TextButton(
              style: TextButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                backgroundColor: Colors.green,
              ),
              onPressed: () async {
                try {
                  // Show saving message
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Saving weather data...'),
                      duration: Duration(seconds: 1),
                    ),
                  );

                  // Log GET demonstration
                  print('------- Weather Data Demonstration -------');
                  print('City: $city');
                  print('Current Temperature: ${weather.getTemp.round()}°C');
                  print('Min Temperature: ${weather.getMinTemp.round()}°C');
                  print('Max Temperature: ${weather.getMaxTemp.round()}°C');

                  // Add save weather event to bloc
                  context.read<WeatherBloc>().add(
                    SaveWeather(weather, city)
                  );

                  // Show success message
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Weather data saved successfully!'),
                      backgroundColor: Colors.green,
                      duration: Duration(seconds: 2),
                    ),
                  );
                } catch (e) {
                  // Show error message if save fails
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error saving data: $e'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: const Text(
                "Save Weather Data",
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
            ),
          ),

          // Spacing between buttons
          const SizedBox(height: 10),

          //--------------------------------
          // 8. SETTINGS BUTTONS
          //--------------------------------
          // Temperature unit toggle button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: TextButton(
              style: TextButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                backgroundColor: Colors.purple,
              ),
              onPressed: () {
                context.read<SettingsBloc>().add(ToggleTemperatureUnit());
              },
              child: BlocBuilder<SettingsBloc, SettingsState>(
                builder: (context, state) {
                  final isCelsius = state is SettingsLoaded ? state.isCelsius : true;
                  return Text(
                    "Switch to ${isCelsius ? 'Fahrenheit' : 'Celsius'}",
                    style: const TextStyle(color: Colors.white70, fontSize: 16),
                  );
                },
              ),
            ),
          ),

          // Spacing between buttons
          const SizedBox(height: 10),

          //--------------------------------
          // 9. BACK BUTTON
          //--------------------------------
          // Full-width button container
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
                BlocProvider.of<WeatherBloc>(context).add(ResetWeather());
              },
              child: const Text(
                "Back to Home", 
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}