# Delivery roadmap — PR 1–12
Each PR branches from reviewed main (or explicitly documented dependency). No automatic merge. Every PR links product requirement IDs, includes tests, screenshots for UI changes, risks and evidence. Gates are requirements, not current pass claims.
| PR / branch | Scope | Acceptance criteria |
|---|---|---|
| 1 refactor/project-foundation | P12; canonical docs, SDK/dependency baseline, split entry/shell, CI, baseline tests, assess Cubit/DI/router | Docs agree; existing four tabs, mock loading and theme toggle preserved; format/analyze/test/build pass; dependency choices verified or explicitly outstanding |
| 2 feature/weather-domain-scenarios | P01 P08; pure domain, typed forecast/location, condition/day phase, fixtures and race guard | 12 visual + 8 system scenarios deterministic; all mappings correct; daily distinct; latest request wins; unit tests |
| 3 feature/expressive-theme-system | P09; semantic color, typography, spacing, shape/motion tokens, system/manual/weather themes | All scenarios and light/dark; contrast tested; no feature-level hardcoded palette; persistence test |
| 4 feature/expressive-shapes-motion | P09; shape primitives, morph, spring, atmosphere lifecycle | Compatible paths; no jumps/leaks; hidden and reduced-motion states tested |
| 5 feature/expressive-components | P05 P09; reusable buttons, group, card, loader, refresh, wavy progress, sheet, snackbar | Interactive states, semantics, tests and examples; upstream license review |
| 6 feature/today-dashboard | P02; hero, curve, Bento metrics, atmosphere | 12 scenarios; missing data marked; compact/expanded no overflow; refresh and freshness correct |
| 7 feature/forecast-experience | P03; hourly/daily, charts, expandable rows | 24h/7d distinct; shared range scale; unit/time zone correctness; chart semantics |
| 8 feature/radar-playground | P04; mock map/frames, timeline, play/pause, toolbar and layers | Play/pause/seek and lifecycle tested; visible demo label, timestamp and legend |
| 9 feature/live-weather-provider | P06 P07 P08 P11; provider, geocoding, location, cache, settings | Provider terms approved; opt-in location; offline/stale/retry/race tests; demo unchanged; no key needed for demo |
| 10 feature/adaptive-accessibility | P07 P09 P10; rail, multi-pane, localization, keyboard and semantics | 360/600/840/1440dp, 200% text, EN/TH; manual Android/iOS checks before support claim |
| 11 feature/expressive-studio | P05; gallery/labs, interactive params, snippets | All six labs use production primitives; controls/reset work; deterministic previews |
| 12 release/v1-showcase | P12; polish, docs, profiling, CI artifacts, web/APK | Fresh clone, CI green, no-key web demo, APK smoke test, screenshots, attribution, documented limitations |
## Milestones
A after PR5: design system. B after PR8: mock product. C after PR10: live/adaptive product. D after PR12: v1 release. Live radar/alerts/widgets are explicitly outside v1.
## Definition of done
Run dart format, flutter analyze, flutter test, relevant build. Record exact commands, SDK, device and results; do not mark skipped checks passed. Target >=90% domain coverage, 60fps on named physical baseline, WCAG AA, no overflow. Reproducible golden tests and failure-state coverage. Any gate exception requires owner approval. PR1 incomplete gates remain open before PR2.
