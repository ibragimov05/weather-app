import 'package:flutter/material.dart';
import 'package:weather_app/models/settings_model.dart';

class SettingsController with ChangeNotifier {
  final SettingsModel settingsModel = SettingsModel(themeMode: ThemeMode.light);

  void toggleThemeMode({required bool isDark}) {
    settingsModel.themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

