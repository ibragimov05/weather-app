import 'package:flutter/material.dart';
import 'package:weather_app/notifiers/settings_notifier.dart';

class IsDark {
  static bool check(BuildContext context) {
    return SettingsNotifier.of(context).settingsModel.themeMode ==
            ThemeMode.dark
        ? true
        : false;
  }
}
