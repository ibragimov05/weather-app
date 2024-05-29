import 'package:flutter/material.dart';
import 'package:weather_app/controllers/settings_controller.dart';

class SettingsNotifier extends InheritedNotifier<SettingsController> {
  final SettingsController settingsController;

  const SettingsNotifier({
    super.key,
    required this.settingsController,
    required super.child,
  }) : super(notifier: settingsController);

  static SettingsController of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<SettingsNotifier>()!
        .settingsController;
  }
}
