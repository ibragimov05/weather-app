import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

import '../models/weather_model.dart';

class WeatherService {
  final String _QUERY_URl_WEATHER =
      'https://api.openweathermap.org/data/2.5/forecast';
  final String _QUERY_URL_AQI =
      'http://api.airvisual.com/v2/nearest_city?key=2dc59163-6980-4447-85cb-ce3525eabe0c';
  final String _api_key = 'd06f8846dd44a3bc15a190ad6dde1af2';

  Future<List<WeatherModel>> getWeather({
    required String cityName,
    required double latitude,
    required double longitude,
  }) async {
    final response = await http.get(
      Uri.parse(
          '$_QUERY_URl_WEATHER?lat=$latitude&lon=$longitude&appid=$_api_key'),
    );

    if (response.statusCode == 200) {
      List<WeatherModel> weatherInfo = [];

      /// converting to map
      var responseBody = jsonDecode(response.body);
      DateTime currentDataTime = DateTime.now();
      int count = 0;

      /// adding result to list
      for (var each in responseBody['list']) {
        /// getting weather info before current data
        if (currentDataTime.isBefore(DateTime.parse(each['dt_txt']))) {
          count++;
          weatherInfo.add(
            WeatherModel(
              cityName: cityName,
              temperature: (each['main']['temp'] - 273.15).round(),
              mainCondition: each['weather'][0]['main'],
              dtTxt: each['dt_txt'],
              windSpeed: (each['wind']['speed'] * 3.6).round(),
              humidity: each['main']['humidity'],
            ),
          );
        }
        if (count == 9) {
          break;
        }
      }
      return weatherInfo;
    } else {
      throw Exception('Error in WeatherService');
    }
  }

  Future<num> getAirQualityIndex() async {
    final Uri query = Uri.parse(_QUERY_URL_AQI);
    final response = await http.get(query);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      return data['data']['current']['pollution']['aqius'];
    } else {
      throw Exception('Error in getAirQualityIndex');
    }
  }

  Future<Map<String, dynamic>> getCurrentCity() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    /// current city name
    String? city = placemarks[0].locality;

    return {
      'city': city ?? '',
      'latitude': position.latitude,
      'longitude': position.longitude,
    };
  }

  /// night time weather calculator
}
