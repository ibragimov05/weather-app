import 'package:flutter/material.dart';
import 'package:weather_app/controllers/settings_controller.dart';
import 'package:weather_app/notifiers/settings_notifier.dart';
import 'package:weather_app/utils/functions/isdark.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsController = SettingsNotifier.of(context);
    return Scaffold(
      backgroundColor: IsDark.check(context) ? Color(0xFF141218) : Colors.white,
      appBar: AppBar(
        backgroundColor: IsDark.check(context) ? Color(0xFF141218) : Colors.white,

        title: Text('Settings page'),
        centerTitle: true,
      ),
      body: ListenableBuilder(
        listenable: settingsController,
        builder: (context, child) {
          return ListView(
            children: [
              SwitchListTile(
                activeColor: Colors.black,
                // hoverColor: Colors.red,
                activeTrackColor: Colors.white,
                inactiveThumbColor: Colors.black,
                inactiveTrackColor: Colors.white,
                title: Text('Dark Mode'),
                value: settingsController.settingsModel.themeMode ==
                    ThemeMode.dark,
                onChanged: (value) {
                  settingsController.toggleThemeMode(isDark: value);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
