import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class CustomColumnMaker extends StatelessWidget {
  final String infoType;
  final num infoNumber;
  final String symbolText;
  final bool isSelected;

  const CustomColumnMaker({
    super.key,
    required this.infoType,
    required this.infoNumber,
    required this.symbolText,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          infoType,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.sp,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
          decoration: isSelected
              ? BoxDecoration(
                  color: aqiColor(aqiNum: infoNumber),
                  borderRadius: BorderRadius.circular(10.r),
                )
              : null,
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: infoNumber.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text: symbolText,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Color aqiColor({required num aqiNum}) {
    if (aqiNum >= 180) {
      return const Color(0xFFa87383);
    } else if (aqiNum >= 150 && 180 >= aqiNum) {
      return const Color(0xFFf65e5f);
    } else if (aqiNum >= 120 && 150 >= aqiNum) {
      return const Color(0xFFf99049);
    } else if (aqiNum >= 50 && 120 >= aqiNum) {
      return const Color(0xFFfdd64b);
    } else {
      return const Color(0xFF9cd84e);
    }
  }
}
