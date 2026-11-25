# Material 3 Expressive design direction
See [product specification](docs/PRODUCT_SPEC.md).
## Principles
Make temperature and condition the strongest hierarchy. Use asymmetric Bento grouping, generous whitespace, expressive typography, organic silhouettes and meaningful spring feedback. Avoid indiscriminate glass, excessive animation, emoji as final art, and decorative shapes that obscure data.
## Screen contracts
- Today: location header, large weather hero with organic illustration, hourly curve, grouped metrics, freshness/source label; pull to refresh.
- Forecast: hourly/daily segmented control, temperature and precipitation charts, connected daily rows, expandable details; preserve scroll and selection.
- Radar: edge-to-edge map, frame time, timeline, play/pause morph, layer sheet, legend; explicitly mark simulation.
- Studio: galleries for color, shape, motion, components, scenarios and layout; adjustable parameters, reset and usage snippets. Use real production components, not duplicate demo widgets.
## Tokens
Semantic Material color roles from weather seed or system/manual seed. Appearance (system/light/dark) independent of color source and day phase. Candidate seeds: sunny amber, cloud slate, rain blue, storm violet, snow cyan, fog sage, dusk coral, night indigo. Derive complete schemes; do not hardcode palette colors in feature widgets. Centralize type roles, spacing (4dp base), corners, elevation and motion; visual examples are proposals, not certified palettes.
## Shape and motion
Circle, pill, rounded rectangle, clover, flower, cookie, diamond and burst as candidates; use semantic silhouettes, compatible path morphs, spatial spring for movement and effects spring for feedback. Prefer existing supported material_ui APIs; assess BunPod packages before porting. Maintain license notices for copied code/assets.
Weather transitions animate color and illustration together; cards expand without layout jumps; loading/refresh morph; radar playback control morphs; no flashing storm effects. Stop ambient tickers when hidden/backgrounded. Reduced motion disables ambient movement, overshoot and nonessential morphing; immediate state changes remain usable.
## Layout
Compact <600dp: single pane and bottom navigation. Medium 600–839: rail, flexible content. Expanded >=840: rail and multi-pane; constrain reading width. Test 360, 600, 840, 1440dp, landscape, large text and EN/TH.
## Accessibility
WCAG AA target: normal text 4.5:1, large text 3:1, meaningful nontext controls 3:1. 48dp touch targets, focus order, descriptive chart summaries, no color-only status, keyboard operation, semantic labels. Avoid clipping at 200% text scale. Golden tests for representative conditions and themes; manual screen reader/device checks.
## Component inventory
P0: hero, shape/morph, expressive button/group/card, wavy progress, loader, refresh. P1: sheet, snackbar, slider, toolbar, navigation, carousel, split button. P2: FAB menu. Wrap only where project-specific behavior or portability warrants it; avoid duplicating upstream widgets.
## Sign-off
Design changes include screenshots in both themes and at least compact/expanded widths, interaction evidence, accessibility notes and token usage. No visual claim without evidence.
