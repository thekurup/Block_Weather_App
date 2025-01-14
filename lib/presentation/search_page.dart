import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/application/weather_bloc/weather_bloc.dart';
import 'package:weather_app/application/weather_bloc/weather_event.dart';
import 'package:weather_app/application/weather_bloc/weather_state.dart';
import 'weather_display.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherBloc = BlocProvider.of<WeatherBloc>(context);
    var cityController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(title: const Text("Search Weather")),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
           const Center(
              child: SizedBox(
                height: 180,
                width: 180,
                
              ),
            ),
            BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
                if (state is WeatherIsNotSearched) {
                  return Container(
                    padding: const EdgeInsets.only(left: 32, right: 32),
                    child: Column(
                      children: [
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
                        TextFormField(
                          controller: cityController,
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
                              weatherBloc.add(SearchWeather(cityController.text));
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
                } else if (state is WeatherIsLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is WeatherIsLoaded) {
                  return ShowWeather(state.getWeather, cityController.text);
                } else {
                  return Column(
                    children: [
                      const Center(
                        child: Text(
                          "Place not found. Please try another place",
                          style: TextStyle(color: Colors.red, fontSize: 16),
                        ),
                      ),
                      const SizedBox(height: 20),
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
