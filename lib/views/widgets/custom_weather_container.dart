import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/utils/extensions/sized_box_extension.dart';
import 'package:weather_app/utils/functions/current_main_weather.dart';
import 'package:weather_app/views/widgets/custom_column_maker.dart';
import 'package:weather_app/views/widgets/location_text.dart';
import 'package:weather_app/views/widgets/temperature_text.dart';

class CustomWeatherContainer extends StatelessWidget {
  final bool animatedContainerPressed;
  final bool isNight;
  final num airQualityIndex;
  final num nightTimeWeather;
  final List<WeatherModel> weatherModel;

  const CustomWeatherContainer({
    super.key,
    required this.animatedContainerPressed,
    required this.isNight,
    required this.airQualityIndex,
    required this.nightTimeWeather,
    required this.weatherModel,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: double.infinity,
      height: animatedContainerPressed ? 350.h : 135.h,
      padding: EdgeInsets.all(20.sp),
      decoration: BoxDecoration(
        color: isNight ? Color(0xFF242b40) : Color(0xFF3B8BDD),
        borderRadius: BorderRadius.circular(30.r),
      ),
      duration: const Duration(milliseconds: 500),
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: animatedContainerPressed
            ? SizedBox(
                height: 300.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    LocationText(
                      currentLocation:
                          weatherModel[weatherModel.length - 1].cityName,
                      isNight: isNight ? true : false,
                    ),
                    10.height(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TemperatureText(
                              text: weatherModel[0].temperature.toString(),
                            ),
                            Text(
                              weatherModel[0].mainCondition,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.6),
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        Lottie.asset(
                          currentMainWeather(
                            mainWeather: weatherModel[weatherModel.length - 1]
                                .mainCondition,
                            isNight: isNight ? true : false,
                          ),
                          height: 140.h,
                          width: 140.w,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomColumnMaker(
                          infoType: 'Wind Now',
                          infoNumber: weatherModel[0].windSpeed,
                          symbolText: 'km',
                          isSelected: false,
                        ),
                        CustomColumnMaker(
                          infoType: 'Humidity',
                          infoNumber: weatherModel[0].humidity,
                          symbolText: '%',
                          isSelected: false,
                        ),
                        CustomColumnMaker(
                          infoType: 'AQI',
                          infoNumber: airQualityIndex,
                          symbolText: 'us',
                          isSelected: true,
                        ),
                      ],
                    ),
                  ],
                ),
              )

            /// for little animated container
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (animatedContainerPressed)
                        LocationText(
                          currentLocation: weatherModel[0].cityName,
                          isNight: isNight ? true : false,
                        ),
                      10.height(),
                      TemperatureText(
                        text: nightTimeWeather.toString(),
                      ),
                      Text(
                        weatherModel[0].mainCondition,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      40.height(),
                    ],
                  ),
                  Lottie.asset(
                    currentMainWeather(
                      mainWeather:
                          weatherModel[weatherModel.length - 1].mainCondition,
                      isNight: isNight ? true : false,
                    ),
                    height: 100.h,
                    width: 100.w,
                  ),
                ],
              ),
      ),
    );
  }
}
