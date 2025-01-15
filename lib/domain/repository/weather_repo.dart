//--------------------------------
// 1. IMPORT SECTION
//--------------------------------
// We need these packages to make our weather app work:
import 'package:http/http.dart' as http;    // This helps us make API calls to get weather data
import 'package:location/location.dart';     // This helps us get the user's current location
import 'dart:convert';                       // This helps us work with JSON data (convert API response to readable format)
import 'package:weather_app/domain/model/weather_model.dart';  // This is our custom model to store weather data

//--------------------------------
// 2. WEATHER REPOSITORY CLASS
//--------------------------------
// Think of this class as a manager that handles all weather-related data fetching
// It's like a bridge between the weather API and our app
class WeatherRepository {

  //--------------------------------
  //  GET WEATHER BY CITY NAME
  //--------------------------------
  // This method gets weather data when user searches for a specific city
  // Future<WeatherModel> means it will return weather data, but not immediately (it takes time to fetch)
  Future<WeatherModel> getWeather(String city) async {
    // Step 1: Make API call to get weather data
    // It's like making a phone call to a weather service and asking for specific city's weather
    final result = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$city&APPID=43ea6baaad7663dc17637e22ee6f78f2"));

    // Step 2: Check if we got the weather data successfully
    // Status code 200 means success, anything else means something went wrong
    if (result.statusCode != 200) throw Exception();

    // Step 3: Convert the received data into our WeatherModel format
    return jsonParsed(result.body);
  }

  //--------------------------------
  // 4. GET WEATHER BY CURRENT LOCATION
  //--------------------------------
  // This method gets weather data based on user's current location
  Future<WeatherModel> getWeatherByLocation() async {
    // Step 1: Create a tool to get device location
    Location location = Location();

    // Step 2: Try to get the user's location
    try {
      // Ask device for current location
      var userLocation = await location.getLocation();
      
      // Step 3: Use location coordinates to get weather
      // The '!' means we're sure latitude and longitude won't be null
      return _fetchWeatherByCoordinates(
          userLocation.latitude!, 
          userLocation.longitude!
      );
    } catch (e) {
      // If anything goes wrong (like user denied location access):
      print('Could not get location: $e');
      throw Exception('Could not get location');
    }
  }

  //--------------------------------
  // 5. PRIVATE HELPER METHOD FOR COORDINATES
  //--------------------------------
  // This is a private helper method (that's what _ means)
  // It gets weather data using latitude and longitude
  Future<WeatherModel> _fetchWeatherByCoordinates(double lat, double lon) async {
    // Step 1: Make API call with coordinates
    final response = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&APPID=43ea6baaad7663dc17637e22ee6f78f2"));

    // Step 2: Check if call was successful
    if (response.statusCode != 200) throw Exception("Failed to load weather");

    // Step 3: Convert response to WeatherModel
    return jsonParsed(response.body);
  }

  //--------------------------------
  // 6. JSON PARSING HELPER
  //--------------------------------
  // This method converts the raw API response into our WeatherModel format
  WeatherModel jsonParsed(final response) {
    // Step 1: Convert the JSON string into a Map (like a dictionary)
    final decoded = json.decode(response);
    
    // Step 2: Get the 'main' section which has all weather data
    final weather = decoded['main'];
    
    // Step 3: Create a WeatherModel object from this data
    return WeatherModel.fromJson(weather);
  }
}