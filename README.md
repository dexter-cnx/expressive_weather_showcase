# Expressive Weather Showcase
Material 3 Expressive showcase, mock data, swappable repository.

```bash
rm -rf expressive_weather_showcase  # delete old folder first - do NOT unzip over it
unzip expressive_weather_showcase_fixed.zip
cd expressive_weather_showcase
flutter clean && rm -rf build android/build android/app/build android/.gradle
flutter pub get
flutter build apk --debug
ls -lh android/app/build/outputs/flutter-apk/app-debug.apk
```
