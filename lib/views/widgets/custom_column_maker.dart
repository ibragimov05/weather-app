import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/utils/extensions/sized_box_extension.dart';

class CustomColumnMaker extends StatelessWidget {
  final String infoType;
  final num infoNumber;
  final String symbolText;

  const CustomColumnMaker({
    super.key,
    required this.infoType,
    required this.infoNumber,
    required this.symbolText,
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
        10.height(),
        RichText(
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
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
