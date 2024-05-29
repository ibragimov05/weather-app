import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/controllers/settings_controller.dart';
import 'package:weather_app/notifiers/settings_notifier.dart';
import 'package:weather_app/views/screens/weather_page/weather_page.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: (context, child) => SettingsNotifier(
        settingsController: SettingsController(),
        child: Builder(
          builder: (context) {
            final settingsController = SettingsNotifier.of(context);
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData.light(),
              darkTheme: ThemeData.dark(),
              themeMode: settingsController.settingsModel.themeMode,
              home: const WeatherPage(),
            );
          },
        ),
      ),
    );
  }
}
