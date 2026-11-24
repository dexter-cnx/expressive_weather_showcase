import 'package:expressive_weather_showcase/data/weather_repository.dart';
import 'package:expressive_weather_showcase/models/weather.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  for (final condition in [
    WeatherCondition.sunny,
    WeatherCondition.rainy,
    WeatherCondition.stormy,
  ]) {
    test('loads fixture for ${condition.name}', () async {
      final weather = await MockWeatherRepository().getWeather(condition);
      expect(weather.condition, condition);
      expect(weather.hourly, isNotEmpty);
      expect(weather.humidity, inInclusiveRange(0, 100));
    });
  }
}
