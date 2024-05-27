import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/utils/functions/current_main_weather.dart';

class CustomContainerForecastByTime extends StatelessWidget {
  final bool isFirst;
  final String weatherTime;
  final String mainCondition;
  final num temperature;

  const CustomContainerForecastByTime({
    super.key,
    required this.isFirst,
    required this.weatherTime,
    required this.mainCondition,
    required this.temperature,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.h,
      // width: 50.w,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      margin: EdgeInsets.only(left: isFirst ? 20.w : 0.w, right: 10.w),
      decoration: BoxDecoration(
        color: isFirst ? Color(0xFF242b40) : Color(0xFF10131c),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            isFirst
                ? 'Now'
                : weatherTime.split(' ')[1].toString().substring(0, 5),
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          // currentMainWeather
          Lottie.asset(
            currentMainWeather(mainWeather: mainCondition, isNight: false),
            height: 40.h,
            width: 40.w
          ),
          
          Text(
            '$temperature°',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
