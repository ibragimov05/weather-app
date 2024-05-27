import 'package:weather_app/controllers/weather_service.dart';
import 'package:weather_app/models/weather_model.dart';

class FetchWeather {
  Future<List<WeatherModel>> fetchWeather() async {
    Map<String, dynamic> locationInfo = await WeatherService().getCurrentCity();

    try {
      final List<WeatherModel> weatherModel = await WeatherService().getWeather(
        cityName: locationInfo['city'],
        latitude: locationInfo['latitude'],
        longitude: locationInfo['longitude'],
      );
      for(var each in weatherModel){
        print('${each.temperature}, ${each.dtTxt}, ${each.mainCondition}');
      }
      return weatherModel;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<num> fetchAqi() async {
    final num aqi = await WeatherService().getAirQualityIndex();
    return aqi;
  }
}
