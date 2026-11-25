# Architecture
## Baseline and target
Current starter has main.dart, weather model/repository and seed theme. PR1 is a behavior-preserving foundation; target layout is incremental, not a claim that every directory exists.
## Dependency direction
App shell → feature presentation → pure Dart domain contracts; data implements domain contracts. Design system is shared by presentation; domain must not import Flutter/material_ui, localization, colors or emoji. Composition root owns DI. No feature-to-feature implementation imports.
```text
lib/app/                 bootstrap, router, adaptive shell
lib/core/                di, network, storage, localization, errors
lib/features/weather/    domain, data, presentation/{cubit,today,forecast,widgets}
lib/features/radar/      domain, data, presentation
lib/features/locations/  domain, data, presentation
lib/features/settings/   preferences
lib/features/studio/     component, shape, color, motion, scenario labs
lib/design_system/      tokens, theme, shapes, motion, components, atmosphere
assets/mock/
test/
integration_test/
docs/
```
## State and routing
Target Cubit + get_it + go_router, subject to SDK compatibility verification in PR1. Immutable states, explicit loading/data/refreshing/error/stale/partial status, preserve last good data on refresh failure. Request generation or cancellation ensures latest request wins; guard disposal. App-level settings and scenario state separate from weather state. Keep navigation state per destination. Avoid global mutable state outside owned controllers.
## Domain
WeatherSnapshot(location, current, hourly, daily, fetchedAt, source, freshness); WeatherLocation(id, lat, lon, name, timezone); independent WeatherCondition and DayPhase; typed nullable metrics and explicit units. Time via injectable clock. Repository getWeather(location), searchLocations(query); optional separate radar and AQI contracts. Demo scenario selection belongs to scenario controller/fixture adapter, not live query. Map provider DTOs at boundary; unknown codes map safely to unknown.
## Data
Mock repository is deterministic, offline and default. Live adapter behind same domain interface. Candidate Dio client with bounded timeouts, cancellation, retry only transient idempotent requests, rate-limit handling. Cache keyed by provider/location, schema version and timestamps; explicit TTL per dataset, stale-on-error, no fabricated defaults. Storage choice (Drift/lightweight) after spike. Never store secrets in source or logs. No backend required. Provider attribution and legal review mandatory.
## Design system
Use locked material_ui baseline; inventory APIs before adding motor or BunPod code. Shared tokens and semantic widgets; extract package only after public contracts and tests stabilize. Atmosphere owns lifecycle and reduced-motion handling.
## Platforms and tests
Android/web scaffold exists; iOS/desktop require scaffolding and real validation before claiming support. Unit tests for parsing, state/races, unit conversion, time zones and cache; widget tests for interactions; golden tests with fixed clock/font/viewport; integration tests for mode switching and permissions; CI analyze/format/tests/build. Profile on physical device. 
## Decisions and risks
Lockfile currently records material_ui 1.11.1, Dart >=3.13 and Flutter >=3.47; align constraints, verify actual available SDK. Preserve existing Android Gradle/Kotlin configuration and APK output path. Do not guess package versions or claim build pass without evidence. Record deviations as ADRs with rationale and tests.
