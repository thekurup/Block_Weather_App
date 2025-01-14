// ignore_for_file: prefer_typing_uninitialized_variables

class WeatherModel{
  final temp;
  final feelsLike;
  final tempMin;
  final tempMax;
  final pressure;
  final humidity;
  final seaLevel;
  final grndLevel;

  double get getTemp => temp-272.5;
  double get getMinTemp => tempMin-272.5;
  double get getMaxTemp => tempMax-272.5;

  WeatherModel(
    this.temp, 
    this.feelsLike, 
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.humidity,
    this.seaLevel,
    this.grndLevel
    );

    factory WeatherModel.fromJson(Map<String, dynamic> json){
      return WeatherModel(
       json['temp'],
       json['feels_like'], 
       json['temp_min'], 
       json['temp_max'], 
       json['pressure'], 
       json['humidity'], 
       json['sea_level'], 
       json['grnd_level']
       );
    }
}