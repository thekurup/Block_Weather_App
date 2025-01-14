import 'package:equatable/equatable.dart';

class WeatherEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class SearchWeather extends WeatherEvent{
  final String city;

  SearchWeather(this.city);

  @override
  List<Object> get props => [city];
}

class ResetWeather extends WeatherEvent{}

class FetchWeatherByLocation extends WeatherEvent {}