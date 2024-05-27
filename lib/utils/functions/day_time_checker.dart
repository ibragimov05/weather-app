import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_model.dart';

Color checkDayTime(List<WeatherModel> weatherModel) {
  String weatherType =
      weatherModel[weatherModel.length - 1].mainCondition.toLowerCase();
  if (weatherType == 'rain') {
    return Color(0xFF566f97);
  }
  return Colors.black;
  // return DateTime.now().hour >= 6 && DateTime.now().hour < 18
  //     ? Color(0xFFbad0f5)
  //     : Colors.black.withOpacity(0.1);
}
