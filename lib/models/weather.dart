import 'package:material_ui/material_ui.dart';

enum WeatherCondition {
  sunny,
  cloudy,
  rainy,
  snowy,
  stormy,
  night;

  static WeatherCondition fromApiCode(String code) {
    switch (code.toLowerCase()) {
      case 'sunny':
      case 'clear':
        return WeatherCondition.sunny;
      case 'rain':
      case 'rainy':
        return WeatherCondition.rainy;
      case 'snow':
      case 'snowy':
        return WeatherCondition.snowy;
      case 'storm':
      case 'stormy':
        return WeatherCondition.stormy;
      case 'night':
        return WeatherCondition.night;
      default:
        return WeatherCondition.cloudy;
    }
  }
}

extension WeatherConditionX on WeatherCondition {
  String get label {
    switch (this) {
      case WeatherCondition.sunny:
        return 'Sunny';
      case WeatherCondition.cloudy:
        return 'Cloudy';
      case WeatherCondition.rainy:
        return 'Rainy';
      case WeatherCondition.snowy:
        return 'Snowy';
      case WeatherCondition.stormy:
        return 'Stormy';
      case WeatherCondition.night:
        return 'Night';
    }
  }

  Color get seed {
    switch (this) {
      case WeatherCondition.sunny:
        return const Color(0xFFFFB300);
      case WeatherCondition.cloudy:
        return const Color(0xFF78909C);
      case WeatherCondition.rainy:
        return const Color(0xFF1565C0);
      case WeatherCondition.snowy:
        return const Color(0xFF4FC3F7);
      case WeatherCondition.stormy:
        return const Color(0xFF6A1B9A);
      case WeatherCondition.night:
        return const Color(0xFF283593);
    }
  }

  String get emoji {
    switch (this) {
      case WeatherCondition.sunny:
        return '☀️';
      case WeatherCondition.cloudy:
        return '☁️';
      case WeatherCondition.rainy:
        return '🌧️';
      case WeatherCondition.snowy:
        return '❄️';
      case WeatherCondition.stormy:
        return '⛈️';
      case WeatherCondition.night:
        return '🌙';
    }
  }
}

class HourlyForecast {
  final String hour;
  final double temp;
  final int chance;
  const HourlyForecast({
    required this.hour,
    required this.temp,
    required this.chance,
  });
}

class Weather {
  final WeatherCondition condition;
  final double tempC;
  final double feelsLikeC;
  final int humidity;
  final List<HourlyForecast> hourly;
  const Weather({
    required this.condition,
    required this.tempC,
    required this.feelsLikeC,
    required this.humidity,
    required this.hourly,
  });
}
