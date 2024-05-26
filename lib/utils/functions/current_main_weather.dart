import 'package:weather_app/utils/assets/assets.dart';

String currentMainWeather(
    {required String mainWeather, required bool isNight}) {
  if (isNight) {
    if (mainWeather.toLowerCase() == 'rain') {
      return Assets.lottieMoonRain;
    } else if (mainWeather.toLowerCase() == 'snow') {
      return Assets.lottieSnow;
    } else {
      return Assets.lottieMoon;
    }
  } else {
    if (mainWeather.toLowerCase() == 'clouds') {
      return Assets.lottieCloud;
    } else if (mainWeather.toLowerCase() == 'rain') {
      return Assets.lottieRainSunny;
    } else if (mainWeather.toLowerCase() == 'snow') {
      return Assets.lottieSnow;
    } else if (mainWeather.toLowerCase() == 'thunderstorm' ||
        mainWeather.toLowerCase() == 'drizzle') {
      return Assets.lottieThunder;
    } else {
      return Assets.lottieSunny;
    }
  }
}