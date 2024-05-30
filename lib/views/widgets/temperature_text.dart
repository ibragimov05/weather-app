import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TemperatureText extends StatelessWidget {
  final String text;

  const TemperatureText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: text,
            style: TextStyle(
              // fontFamily: 'Oswald',
              fontSize: 50.sp,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
          TextSpan(
            text: '°',
            style: TextStyle(
              // fontFamily: 'Oswald',
              fontSize: 50.sp,
              fontWeight: FontWeight.w900,
              color: Colors.white.withOpacity(0.7),
            ),
          )
        ],
      ),
    );
  }
}
