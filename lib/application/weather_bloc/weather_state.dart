import 'package:equatable/equatable.dart';
import 'package:weather_app/domain/model/weather_model.dart';

class WeatherState extends Equatable{
  @override
  List<Object?> get props => [];
}

class WeatherIsNotSearched extends WeatherState{

}

class WeatherIsLoading extends WeatherState{

}

class WeatherIsLoaded extends WeatherState{
  // ignore: prefer_typing_uninitialized_variables
  final _weather;

  WeatherIsLoaded(this._weather);

  WeatherModel get getWeather => _weather;
  
  @override
  List<Object?> get props => [_weather];
}

class WeatherIsNotLoaded extends WeatherState{

}