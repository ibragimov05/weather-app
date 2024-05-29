import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/utils/functions/current_main_weather.dart';
import 'package:weather_app/utils/functions/isdark.dart';

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
      height: 130.h,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      margin: EdgeInsets.only(left: isFirst ? 20.w : 0.w, right: 10.w),
      decoration: BoxDecoration(
        color: IsDark.check(context)
            ? isFirst
                ? Color(0xFF242b40)
                : Color(0xFF313a57)
            : isFirst
                ? Color(0xFF242b40).withOpacity(0.9)
                : Color(0xFF242b40).withOpacity(0.3),
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
              color: isFirst
                  ? Colors.white
                  : IsDark.check(context)
                      ? Colors.white
                      : Color(0xFF242b40),
              fontWeight: FontWeight.w600,
            ),
          ),
          Lottie.asset(
              currentMainWeather(mainWeather: mainCondition, isNight: false),
              height: 40.h,
              width: 40.w),

          Text(
            '$temperature°',
            style: TextStyle(
              color: isFirst
                  ? Colors.white
                  : IsDark.check(context)
                      ? Colors.white
                      : Color(0xFF242b40),
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
