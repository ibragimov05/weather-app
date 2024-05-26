import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/controllers/fetch_weather.dart';
import 'package:weather_app/controllers/weather_service.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/utils/extensions/sized_box_extension.dart';
import 'package:weather_app/views/widgets/location_text.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final WeatherService _weatherService = WeatherService();
  final FetchWeather _fetchWeatherController = FetchWeather();
  List<WeatherModel> _weatherModel = [];
  bool isFound = false;
  bool animatedContainerDay = true;
  bool animatedContainerNight = false;

  void _fetchWeather() async {
    List<WeatherModel> weatherModel =
        await _fetchWeatherController.fetchWeather();
    if (weatherModel.isNotEmpty) {
      setState(() {
        isFound = true;
        _weatherModel = weatherModel;
      });
    }
  }

  void _nightTimeWeather() {
    for (var each in _weatherModel) {
      print('${each.temperature}, ${each.dtTxt}');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
    _nightTimeWeather();
  }

  Future<void> _refresh() async {
    _fetchWeather();
    await Future.delayed(const Duration(seconds: 2));
    _nightTimeWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2F3237),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w, top: 20.h),
            child: ListView(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      animatedContainerDay = true;
                      animatedContainerNight = false;
                    });
                  },
                  child: AnimatedContainer(
                    width: double.infinity,
                    height: animatedContainerDay ? 500.h : 200.h,
                    padding: EdgeInsets.all(20.sp),
                    decoration: BoxDecoration(
                      color: Color(0xFF3B8BDD),
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    duration: const Duration(milliseconds: 500),
                    child: Column(
                      children: [
                        if (animatedContainerDay)
                          LocationText(
                            currentLocation:
                                isFound ? _weatherModel[0].cityName : '',
                            isNight: false,
                          ),
                        Text(
                          '${isFound ? _weatherModel[0].temperature : 'loading'}C',
                          style: const TextStyle(color: Colors.yellow),
                        ),
                      ],
                    ),
                  ),
                ),
                30.height(),

                /// night time
                GestureDetector(
                  onTap: () {
                    setState(() {
                      animatedContainerDay = false;
                      animatedContainerNight = true;
                    });
                  },
                  child: AnimatedContainer(
                    width: double.infinity,
                    padding: EdgeInsets.all(20.sp),
                    height: animatedContainerNight ? 500.h : 200.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.r),
                      color: Color(0xFF171B26),
                    ),
                    duration: const Duration(milliseconds: 500),
                    child: Column(
                      children: [
                        if (animatedContainerNight)
                          LocationText(
                            currentLocation:
                                isFound ? _weatherModel[0].cityName : '',
                            isNight: true,
                          ),
                        Text(
                          '${isFound ? _weatherModel[0].temperature : 'loading'}C',
                          style: const TextStyle(color: Colors.yellow),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
