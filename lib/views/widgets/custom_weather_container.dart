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
  final List<WeatherModel> weatherModel;
  final Function() onButtonTapped;

  const CustomWeatherContainer({
    super.key,
    required this.animatedContainerPressed,
    required this.isNight,
    required this.airQualityIndex,
    required this.weatherModel,
    required this.onButtonTapped,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onButtonTapped();
      },
      child: AnimatedContainer(
        width: double.infinity,
        height: animatedContainerPressed ? 450.h : 250.h,
        padding: EdgeInsets.all(20.sp),
        decoration: BoxDecoration(
          color: isNight ? Color(0xFF171B26) : Color(0xFF3B8BDD),
          borderRadius: BorderRadius.circular(30.r),
        ),
        duration: const Duration(milliseconds: 500),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (animatedContainerPressed)
                LocationText(
                  currentLocation: weatherModel[0].cityName,
                  isNight: isNight ? true : false,
                ),
              20.height(),
              if (animatedContainerPressed)
                Lottie.asset(
                  currentMainWeather(
                    mainWeather: weatherModel[0].mainCondition,
                    isNight: isNight ? true : false,
                  ),
                  height: 140.h,
                  width: 140.w,
                ),
              10.height(),
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
              40.height(),
              if (animatedContainerPressed)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomColumnMaker(
                      infoType: 'Wind Now',
                      infoNumber: weatherModel[0].windSpeed,
                      symbolText: 'km',
                    ),
                    CustomColumnMaker(
                      infoType: 'Humidity',
                      infoNumber: weatherModel[0].humidity,
                      symbolText: '%',
                    ),
                    CustomColumnMaker(
                      infoType: 'AQI',
                      infoNumber: airQualityIndex,
                      symbolText: 'us',
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
