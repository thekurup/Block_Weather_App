import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/application/weather_bloc/weather_bloc.dart';
import 'package:weather_app/application/weather_bloc/weather_event.dart';
import 'package:weather_app/domain/model/weather_model.dart';

// ignore: must_be_immutable
class ShowWeather extends StatelessWidget {
  WeatherModel weather;
  final String city;

  ShowWeather(this.weather, this.city, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 32, left: 32, top: 10),
      child: Column(
        children: <Widget>[
        Text(
          city,
          style: const TextStyle(color: Colors.white70, fontSize: 30, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),

          Text("${weather.getTemp.round()} C",style: const TextStyle(color: Colors.white70, fontSize: 50)),
          const Text("Temperature",style: TextStyle(color: Colors.white70, fontSize: 14)),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                    children: <Widget>[
                      Text("${weather.getMinTemp.round()} C",style: const TextStyle(color: Colors.white70, fontSize: 30),),
                      const Text("Min Temperature",style: TextStyle(color: Colors.white70, fontSize: 14),),
                    ],
                  ),
               Column(
                    children: <Widget>[
                      Text("${weather.getMaxTemp.round()} C",style: const TextStyle(color: Colors.white70, fontSize: 30),),
                      const Text("Max Temperature",style: TextStyle(color: Colors.white70, fontSize: 14),),
                    ],
                  ),   
            ],
          ),
          const SizedBox(
                height: 20,
              ),

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
                  onPressed: (){
                    BlocProvider.of<WeatherBloc>(context).add(ResetWeather());
                  },
                  child: const Text("Back to Home", style: TextStyle(color: Colors.white70, fontSize: 16),),
        ),
        )
        ],
      ),
    );
  }
}