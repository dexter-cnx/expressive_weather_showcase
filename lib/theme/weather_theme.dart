import 'package:material_ui/material_ui.dart';

import '../models/weather.dart';

ThemeData weatherTheme(WeatherCondition c, Brightness b) {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: c.seed, brightness: b),
    useMaterial3: true,
  );
}
