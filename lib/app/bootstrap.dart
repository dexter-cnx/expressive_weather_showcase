import 'package:get_it/get_it.dart';

import '../data/weather_repository.dart';

final dependencies = GetIt.instance;

void configureDependencies() {
  if (!dependencies.isRegistered<WeatherRepository>()) {
    dependencies.registerLazySingleton<WeatherRepository>(
      MockWeatherRepository.new,
    );
  }
}
