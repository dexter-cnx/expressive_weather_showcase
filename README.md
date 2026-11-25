# Expressive Weather Showcase
A Flutter Material 3 Expressive reference application and weather showcase. The current baseline uses local mock data; live weather, expressive components and Studio are planned, not yet implemented.

## Canonical specifications
- [Product specification](docs/PRODUCT_SPEC.md)
- [Design direction](DESIGN.md)
- [Architecture](docs/ARCHITECTURE.md)
- [PR 1–12 roadmap](docs/ROADMAP.md)
- [Agent instructions](AGENTS.md)

## Development
The committed baseline resolves material_ui 1.11.1 with Dart >=3.13 and Flutter >=3.47. Verify installed SDK compatibility before building.

```sh
flutter pub get
flutter analyze
flutter test
flutter build web
flutter build apk --debug
```

Expected APK location per existing project guidance: android/app/build/outputs/flutter-apk/app-debug.apk. Do not redirect Gradle build output. See CI for actual verification results.

## Inspiration
[Expressive Weather](https://github.com/nemy-new/Expressive-Weather) and [BunPod](https://github.com/kamranbekirovyz/bunpod). No upstream code is introduced by this foundation change.
