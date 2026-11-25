import 'package:expressive_weather_showcase/app/app.dart';
import 'package:expressive_weather_showcase/data/weather_repository.dart';
import 'package:expressive_weather_showcase/models/weather.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

class _FixtureRepository implements WeatherRepository {
  @override
  Future<Weather> getWeather(WeatherCondition c) async => Weather(
    condition: c,
    tempC: 30,
    feelsLikeC: 32,
    humidity: 60,
    hourly: const [],
  );
}

void main() {
  testWidgets('navigation, demo switching and appearance', (tester) async {
    await tester.pumpWidget(App(repository: _FixtureRepository()));
    await tester.pumpAndSettle();
    expect(find.text('Sunny'), findsOneWidget);
    await tester.tap(find.text('Radar'));
    await tester.pumpAndSettle();
    expect(find.text('Play radar animation'), findsOneWidget);
    await tester.tap(find.text('Forecast'));
    await tester.pumpAndSettle();
    expect(find.text('7-day forecast (mock)'), findsOneWidget);
    await tester.tap(find.text('Components'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Rainy'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Today'));
    await tester.pumpAndSettle();
    expect(find.text('Rainy'), findsOneWidget);
    await tester.tap(find.byIcon(Icons.brightness_6));
    await tester.pumpAndSettle();
    final context = tester.element(find.text('Rainy'));
    expect(Theme.of(context).brightness, Brightness.dark);
  });
}
