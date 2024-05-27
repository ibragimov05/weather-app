import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/controllers/fetch_weather.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/utils/extensions/sized_box_extension.dart';
import 'package:weather_app/utils/functions/day_time_checker.dart';
import 'package:weather_app/views/widgets/custom_weather_container.dart';
import 'package:weather_app/views/widgets/forecast_by_time.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final FetchWeather _fetchWeatherController = FetchWeather();
  List<WeatherModel> _weatherModel = [];
  num _airQualityIndex = 0;
  bool isFound = false;
  bool animatedContainerDay = true;
  bool animatedContainerNight = false;
  Color _backgroundColor = Colors.white;

  void _fetchWeather() async {
    List<WeatherModel> weatherModel =
        await _fetchWeatherController.fetchWeather();
    if (weatherModel.isNotEmpty) {
      setState(() {
        isFound = true;
        _weatherModel = weatherModel;
        _backgroundColor = checkDayTime(_weatherModel);
      });
    }
  }

  void _fetchAqi() async {
    _airQualityIndex = await _fetchWeatherController.fetchAqi();
  }

  @override
  void initState() {
    super.initState();
    _fetchAqi();
    _fetchWeather();
  }

  Future<void> _refresh() async {
    _fetchWeather();
    _fetchAqi();
    _backgroundColor = checkDayTime(_weatherModel);
    await Future.delayed(
      const Duration(seconds: 2),
    );
  }

  void onDayTap() {
    animatedContainerDay = true;
    animatedContainerNight = false;
    setState(() {});
  }

  void onNightTap() {
    animatedContainerDay = false;
    animatedContainerNight = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: RefreshIndicator(
        backgroundColor: Colors.white,
        color: Colors.black,
        strokeWidth: 2,
        onRefresh: _refresh,
        child: Center(
          child: isFound
              ? ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: 20.0.w, right: 20.0.w, top: 20.h),
                      child: Column(
                        children: [
                          Row(
                            // crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ZoomTapAnimation(
                                onTap: () {},
                                child: Icon(
                                  Icons.settings,
                                  size: 30.sp,
                                ),
                              ),
                            ],
                          ),
                          10.height(),

                          /// day time weather info
                          CustomWeatherContainer(
                            animatedContainerPressed: animatedContainerDay,
                            isNight: false,
                            weatherModel: _weatherModel,
                            onButtonTapped: onDayTap,
                            airQualityIndex: _airQualityIndex,
                          ),
                          20.height(),

                          /// night time weather info
                          CustomWeatherContainer(
                            animatedContainerPressed: animatedContainerNight,
                            isNight: true,
                            weatherModel: _weatherModel,
                            onButtonTapped: onNightTap,
                            airQualityIndex: _airQualityIndex,
                          ),
                        ],
                      ),
                    ),
                    20.height(),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          for (int i = 0; i < _weatherModel.length; i++)
                            CustomContainerForecastByTime(
                              isFirst: i == 0 ? true : false,
                              weatherTime: _weatherModel[i].dtTxt,
                              mainCondition: _weatherModel[i].mainCondition,
                              temperature: _weatherModel[i].temperature,
                            ),
                        ],
                      ),
                    ),
                  ],
                )

              /// loading widget
              : CircularProgressIndicator(
                  color: Colors.grey.withOpacity(0.5),
                  backgroundColor: Colors.white,
                  strokeAlign: 1.sp,
                  strokeWidth: 5.sp,
                  strokeCap: StrokeCap.square,
                ),
        ),
      ),
    );
  }
}
