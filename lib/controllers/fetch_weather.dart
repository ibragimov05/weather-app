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

      return weatherModel;
      // WeatherService().calculateNightTimeWeather(weatherInfo: weatherModel),
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<num> fetchAqi() async {
    final num aqi = await WeatherService().getAirQualityIndex();
    return aqi;
  }

  int calculateNightTimeWeather({required List<WeatherModel> weatherInfo}) {
    List<int> nightTemperatures = [];
    int count = 0;
    for (WeatherModel eachTime in weatherInfo) {
      DateTime time = DateTime.parse(eachTime.dtTxt);
      if (_isInRange(time)) {
        count++;
        nightTemperatures.add(eachTime.temperature);
        if (count == 4) {
          break;
        }
      }
    }

    return ((nightTemperatures
                .reduce((int value, int element) => value + element)) /
            nightTemperatures.length)
        .floor();
  }

  bool _isInRange(DateTime time) {
    DateTime start = DateTime(time.year, time.month, time.day, 18);
    DateTime end = DateTime(time.year, time.month, time.day + 1, 6);

    if (time.hour <= 6) {
      start = DateTime(time.year, time.month, time.day - 1, 18);
      end = DateTime(time.year, time.month, time.day, 7);
    }

    return time.isAfter(start) && time.isBefore(end);
  }
}
