import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/application/weather_bloc/weather_event.dart';
import 'package:weather_app/application/weather_bloc/weather_state.dart';
import 'package:weather_app/domain/model/weather_model.dart';
import 'package:weather_app/domain/repository/weather_repo.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState>{
  final WeatherRepository weatherRepo;
  
  WeatherBloc(this.weatherRepo) : super(WeatherIsNotSearched()) {
    on<SearchWeather>(_onSearchWeather);
    on<ResetWeather>(_onResetWeather);
    on<FetchWeatherByLocation>(_onFetchWeatherByLocation); 
  }

  Future<void> _onSearchWeather(SearchWeather event, Emitter<WeatherState> emit) async {
    emit(WeatherIsLoading());

    try {
      WeatherModel weather = await weatherRepo.getWeather(event.city);
      emit(WeatherIsLoaded(weather));
    } catch (_) {
      emit(WeatherIsNotLoaded());
    }
  }

  Future<void> _onFetchWeatherByLocation(FetchWeatherByLocation event, Emitter<WeatherState> emit) async {
    emit(WeatherIsLoading());

    try {
      WeatherModel weather = await weatherRepo.getWeatherByLocation();
      emit(WeatherIsLoaded(weather));
    } catch (_) {
      emit(WeatherIsNotLoaded());
    }
  }

  void _onResetWeather(ResetWeather event, Emitter<WeatherState> emit) {
    emit(WeatherIsNotSearched());
  }
}