import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/weather.dart';

abstract class WeatherRepository {
  Future<Weather> getWeather(WeatherCondition c);
}

class MockWeatherRepository implements WeatherRepository {
  @override
  Future<Weather> getWeather(WeatherCondition c) async {
    final name = switch (c) {
      WeatherCondition.sunny => 'weather_sunny',
      WeatherCondition.stormy => 'weather_storm',
      _ => 'weather_rain',
    };
    final raw = await rootBundle.loadString('assets/mock/$name.json');
    final j = jsonDecode(raw) as Map<String, dynamic>;
    return Weather(
      condition: WeatherCondition.fromApiCode(j['condition'] as String),
      tempC: (j['tempC'] as num).toDouble(),
      feelsLikeC: (j['feelsLikeC'] as num).toDouble(),
      humidity: j['humidity'] as int,
      hourly: (j['hourly'] as List)
          .map(
            (e) => HourlyForecast(
              hour: e['hour'] as String,
              temp: (e['temp'] as num).toDouble(),
              chance: e['chance'] as int,
            ),
          )
          .toList(),
    );
  }
}
