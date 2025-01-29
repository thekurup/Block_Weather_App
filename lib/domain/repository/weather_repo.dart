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
 // Store API key and base URL as constants for better maintenance
 final String apiKey = "43ea6baaad7663dc17637e22ee6f78f2";
 final String baseUrl = "https://api.openweathermap.org/data/2.5/weather";

 //--------------------------------
 //  GET WEATHER BY CITY NAME
 //--------------------------------
 // This method gets weather data when user searches for a specific city
 // Future<WeatherModel> means it will return weather data, but not immediately (it takes time to fetch)
 Future<WeatherModel> getWeather(String city) async {
   // Step 1: Make API call to get weather data
   // It's like making a phone call to a weather service and asking for specific city's weather
   final result = await http.get(Uri.parse(
       // Uri.parse like converting a text address into a proper format the web understands
       // It's like converting a written address into GPS coordinates
       "$baseUrl?q=$city&APPID=$apiKey"));

   // Step 2: Check if we got the weather data successfully
   // Status code 200 means success, anything else means something went wrong
   if (result.statusCode != 200) throw Exception();

   // Step 3: Convert the received json data into our WeatherModel format
   return jsonParsed(result.body);
 }

 //--------------------------------
 // 4. GET WEATHER BY CURRENT LOCATION
 //--------------------------------
 // This method gets weather data based on user's current location
 Future<WeatherModel> getWeatherByLocation() async {
   // Creates instance of location service
   Location location = Location();

   // Step 2: Try to get the user's location
   try {
     // Ask device for current location
     var userLocation = await location.getLocation();
     
     // Step 3: Use location coordinates to get weather
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
 // 5. FETCH WEATHER BY COORDINATES
 //--------------------------------
 // Private method to get weather data using latitude and longitude
 Future<WeatherModel> _fetchWeatherByCoordinates(double lat, double lon) async {


   // Step 1: Make API call with coordinates
   final response = await http.get(Uri.parse(
       "$baseUrl?lat=$lat&lon=$lon&APPID=$apiKey"));

   // Step 2: Check if call was successful
   if (response.statusCode != 200) throw Exception("Failed to load weather");

   // Step 3: Convert response to WeatherModel
   return jsonParsed(response.body);
 }

 //--------------------------------
// 6. SAVE WEATHER DATA (POST WITH CONSOLE LOGGING)
Future<bool> saveWeather(WeatherModel weather, String city) async {
  //   The function takes two parameters:
// WeatherModel weather: Contains weather details such as temperature, humidity, etc.
// String city: The name of the city.
  final response = await http.post(
      Uri.parse('https://run.mocky.io/v3/aa153933-3e4b-4bcf-a9f2-829164eaa1c4'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'city': city,
        'temp': weather.temp,
        'temp_min': weather.tempMin,
        'temp_max': weather.tempMax,
        'humidity': weather.humidity,
      }),
    );
//     A mock API endpoint (https://run.mocky.io/v3/...) created using Mocky.
// Headers: Specifies the request's content type (application/json), indicating that the body contains JSON data.
// Body: Converts weather data into a JSON string using json.encode.
// Data included:
// City name.
// Current temperature (temp).
// Minimum temperature (temp_min).
// Maximum temperature (temp_max).
// Humidity.

  try {
    // Log the data that would be sent in a real POST request
    print('\n------- POST Request Simulation -------');
    print('Endpoint: https://your-api-endpoint/weather');
    print('Headers: {Content-Type: application/json}');
    print('Body: {');
    print('  "city": "$city",');
    print('  "temperature": ${weather.temp.round()},');
    print('  "min_temp": ${weather.tempMin.round()},');
    print('  "max_temp": ${weather.tempMax.round()},');
    print('  "humidity": ${weather.humidity}');
    print('}');
    
    // Make a real POST request to save weather data
    
    // Check if the POST request was successful
    if (response.statusCode == 200) {
      print('POST Request: Success (200 OK)');
      return true;
    } else {
      print('POST Request: Failed (Status: ${response.statusCode})');
      return false;
    }
  } catch (e) {
    // Log any errors during POST request
    print('Error in POST request: $e');
    return false;
  }
}

 //--------------------------------
 // 7. JSON PARSING HELPER
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