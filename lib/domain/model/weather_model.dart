//--------------------------------
// 1. FILE DESCRIPTION
//--------------------------------
// This file is like a blueprint for our weather data
// It defines how we store and handle all weather-related information

// Tells Dart to ignore warnings about variable types
// We're doing this because our API data comes in a flexible format
// ignore_for_file: prefer_typing_uninitialized_variables

//--------------------------------
// 2. WEATHER MODEL CLASS
//--------------------------------
// This class is like a container that holds all weather information
class WeatherModel {
 //--------------------------------
 // 3. WEATHER PROPERTIES
 //--------------------------------
 // These are all the weather details we store
 // 'final' means once we set these values, they can't be changed
 final temp;        // Main temperature (comes in Kelvin from API)
 final feelsLike;   // How warm it actually feels
 final tempMin;     // Lowest temperature
 final tempMax;     // Highest temperature
 final pressure;    // Air pressure (like how heavy the air is)
 final humidity;    // How much water is in the air (%)
 final seaLevel;    // Air pressure at sea level
 final grndLevel;   // Air pressure at ground level

 //--------------------------------
 // 4. TEMPERATURE CONVERTERS
 //--------------------------------
 // These are special methods that automatically convert temperatures
 // from Kelvin (what API gives us) to Celsius (what users understand)
 // Formula: Take Kelvin temperature and subtract 272.5
 
 // Get current temperature in Celsius
 double get getTemp => temp - 272.5;
 
 // Get minimum temperature in Celsius
 double get getMinTemp => tempMin - 272.5;
 
 // Get maximum temperature in Celsius
 double get getMaxTemp => tempMax - 272.5;

 //--------------------------------
 // 5. MAIN CONSTRUCTOR
 //--------------------------------
 // This is like a recipe for creating a new WeatherModel
 // It sets up all our weather properties when we create a new model
 WeatherModel(
   this.temp,       // Regular temperature
   this.feelsLike,  // "Feels like" temperature
   this.tempMin,    // Minimum temperature
   this.tempMax,    // Maximum temperature
   this.pressure,   // Air pressure
   this.humidity,   // Humidity level
   this.seaLevel,   // Sea level pressure
   this.grndLevel   // Ground level pressure
 );

 //--------------------------------
 // 6. JSON CONSTRUCTOR
 //--------------------------------
 // This special constructor creates a WeatherModel from API data
 // We use 'factory' because it's a special way to create a WeatherModel
 // Map<String, dynamic> means we accept data where:
 //   - Keys are strings (like 'temp', 'humidity')
 //   - Values can be any type (numbers, strings, etc.)
 factory WeatherModel.fromJson(Map<String, dynamic> json) {
   // Create and return a new WeatherModel using data from JSON
   return WeatherModel(
     json['temp'],         // Get main temperature
     json['feels_like'],   // Get feels like temperature
     json['temp_min'],     // Get minimum temperature
     json['temp_max'],     // Get maximum temperature
     json['pressure'],     // Get pressure reading
     json['humidity'],     // Get humidity level
     json['sea_level'],    // Get sea level pressure
     json['grnd_level']    // Get ground level pressure
   );
 }
}