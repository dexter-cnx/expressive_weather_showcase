import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import '../data/weather_repository.dart';
import '../models/weather.dart';

class WeatherState {
  const WeatherState({
    this.condition = WeatherCondition.sunny,
    this.brightness = Brightness.light,
    this.weather,
    this.failed = false,
  });

  final WeatherCondition condition;
  final Brightness brightness;
  final Weather? weather;
  final bool failed;
}

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit(this.repository) : super(const WeatherState());

  final WeatherRepository repository;
  int _generation = 0;

  Future<void> load(WeatherCondition condition) async {
    final generation = ++_generation;
    emit(WeatherState(condition: condition, brightness: state.brightness));
    try {
      final weather = await repository.getWeather(condition);
      if (isClosed || generation != _generation) return;
      emit(WeatherState(
        condition: condition,
        brightness: state.brightness,
        weather: weather,
      ));
    } catch (_) {
      if (isClosed || generation != _generation) return;
      emit(WeatherState(
        condition: condition,
        brightness: state.brightness,
        failed: true,
      ));
    }
  }

  void toggleBrightness() {
    emit(WeatherState(
      condition: state.condition,
      brightness: state.brightness == Brightness.light
          ? Brightness.dark
          : Brightness.light,
      weather: state.weather,
      failed: state.failed,
    ));
  }
}
