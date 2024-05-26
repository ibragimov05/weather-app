class WeatherModel {
  final String cityName;
  final int temperature;
  final String mainCondition;
  final String dtTxt;
  final int windSpeed;
  final int humidity;

  WeatherModel({
    required this.cityName,
    required this.temperature,
    required this.mainCondition,
    required this.dtTxt,
    required this.windSpeed,
    required this.humidity,
  });
}
