import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LocationText extends StatelessWidget {
  final String currentLocation;
  final bool isNight;

  const LocationText({
    super.key,
    required this.currentLocation,
    required this.isNight,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          isNight ? 'Night' : 'Day',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        // SizedBox(),
        Column(
          children: [
            Text(
              'My location',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 8.sp),
            ),
            Text(
              currentLocation == '' ? 'Loading city...' : currentLocation,
              style: TextStyle(
                color: Colors.white,
                fontSize: 22.sp,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        SizedBox(
          width: 20.w,
        ),
      ],
    );
  }
}
