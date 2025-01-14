import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'dart:convert';
import 'package:weather_app/domain/model/weather_model.dart';

class WeatherRepository{
  Future<WeatherModel> getWeather(String city) async{
    //api calling
    final result = await http.get(Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=$city&APPID=43ea6baaad7663dc17637e22ee6f78f2"));

    if(result.statusCode != 200) throw Exception();

    return jsonParsed(result.body);
  }

   Future<WeatherModel> getWeatherByLocation() async {
    Location location = Location();

    try {
      var userLocation = await location.getLocation();
      return _fetchWeatherByCoordinates(userLocation.latitude!, userLocation.longitude!);
    } catch (e) {
      // ignore: avoid_print
      print('Could not get location: $e');
      throw Exception('Could not get location');
    }
  }

  Future<WeatherModel> _fetchWeatherByCoordinates(double lat, double lon) async {
    final response = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&APPID=43ea6baaad7663dc17637e22ee6f78f2"));

    if (response.statusCode != 200) throw Exception("Failed to load weather");

    return jsonParsed(response.body);
  }

  WeatherModel jsonParsed(final response){
    final decoded = json.decode(response);
    final weather = decoded['main'];
    return WeatherModel.fromJson(weather);
  }
}