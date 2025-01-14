import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/application/weather_bloc/weather_bloc.dart';
import 'package:weather_app/application/weather_bloc/weather_event.dart';
import 'package:weather_app/application/weather_bloc/weather_state.dart';
import 'weather_display.dart';

class CurrentWeather extends StatelessWidget {
  const CurrentWeather({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherBloc = BlocProvider.of<WeatherBloc>(context);

    return Scaffold(
      backgroundColor: Colors.grey[600],
      appBar: AppBar(title: const Text("Current Location Weather")),
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherIsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is WeatherIsLoaded) {
            return ShowWeather(state.getWeather, "Current Location");
          } else if (state is WeatherIsNotLoaded) {
            return const Center(child: Text("Failed to fetch weather"));
          } else {
            return const Center(
              child: Text(
                "Press the button to fetch weather", 
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          weatherBloc.add(FetchWeatherByLocation());
        },
        child: const Icon(Icons.my_location),
      ),
    );
  }
}
