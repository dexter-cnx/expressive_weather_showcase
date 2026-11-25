# Product specification — v1.0
Status: accepted planning baseline; implementation tracked in [ROADMAP](ROADMAP.md).
## Purpose
A Flutter reference application for Material 3 Expressive, inspired by Expressive Weather (product experience) and BunPod (engineering). Not a clone. Showcase is a first-class product, not a debug menu.
## Requirements
| ID | Requirement | Acceptance |
|---|---|---|
| P01 | First launch in deterministic demo mode | No network, account, key or permission needed; demo label always visible |
| P02 | Today | Current temperature, feels-like, condition, high/low, hourly curve, precipitation chance, humidity, wind, UV, sunrise/sunset, AQI/PM2.5; unavailable values explicitly marked |
| P03 | Forecast | Distinct hourly and daily models, 24h and 7 days, expandable details and temperature range bars on a shared scale |
| P04 | Radar | Mock animation with play/pause, seek, layer sheet, legend, frame timestamp and demo label; no implication of real radar |
| P05 | Studio | Interactive color, shape, motion, component, scenario and adaptive-layout labs; reset, code examples and accessibility guidance |
| P06 | Live mode | Opt-in provider, search city, optional foreground location, saved cities, refresh and offline cache; no key required for demo |
| P07 | Settings | Persist mode, city, locale EN/TH, temperature/wind units, appearance and theme preference |
| P08 | Resilience | Loading, slow, empty, partial, stale, offline, permission denied and error states; retry; latest selection wins |
| P09 | Accessibility | Screen-reader labels, keyboard focus, contrast, 48dp touch targets, text scaling and reduced motion |
| P10 | Adaptive | Compact, medium and expanded layouts; Android/iOS target, web demo; desktop best effort until verified |
| P11 | Privacy | No login, analytics or backend; location optional, no background tracking; explicit deletion of saved locations/cache |
| P12 | Release | Fresh-clone instructions, demo screenshots, CI, reproducible web demo and Android APK |
## Navigation
Today / Forecast / Radar / Studio; location and settings via app bar. Preserve shared presentation between demo and live. Studio may switch to demo only with explicit user action. Never display simulated observations as live.
## Scenarios
Sunny, partly cloudy, overcast, drizzle, heavy rain, storm, snow, fog, clear night, cloudy night, sunset, haze. Condition and day phase independent; fixed clock, seeded fixtures, known locale/time zone. Include all P08 system states.
## Data semantics
Use timestamps with offsets/zone, Celsius internally, explicit units and nullable unsupported metrics. AQI must identify its index standard and source; PM2.5 in µg/m³. Display observation/forecast timestamp, source and stale status; avoid fabricated values. Forecast is not observation.
## Scope
V1: P01–P12, mock radar only. V1.1 candidates: live radar, rain countdown, widgets, notifications, optional sensor effects. V2 candidates: regional radar, official alerts and typhoon tracks. Provider terms, attribution, coverage and quotas must be reviewed before enabling live services. Open-Meteo is a candidate, not approved. No emergency guidance or official-alert claim in v1.
## References
- https://github.com/nemy-new/Expressive-Weather
- https://github.com/kamranbekirovyz/bunpod
- https://m3.material.io/
