import 'package:flutter/material.dart';

Color checkDayTime() {
  return DateTime.now().hour >= 6 && DateTime.now().hour < 18
      ? Color(0xFFbad0f5)
      : Colors.black.withOpacity(0.1);
}
