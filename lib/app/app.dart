import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../data/weather_repository.dart';
import '../models/weather.dart';
import '../theme/weather_theme.dart';
import 'weather_cubit.dart';

const _paths = ['/today', '/radar', '/forecast', '/components'];

class App extends StatefulWidget {
  const App({required this.repository, super.key});

  final WeatherRepository repository;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final WeatherCubit _cubit;
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _cubit = WeatherCubit(widget.repository)..load(WeatherCondition.sunny);
    _router = GoRouter(
      initialLocation: '/today',
      routes: [
        ShellRoute(
          builder: (context, state, child) => _Shell(
            tab: _paths.indexOf(state.uri.path),
            child: child,
          ),
          routes: [
            for (var index = 0; index < _paths.length; index++)
              GoRoute(
                path: _paths[index],
                builder: (context, state) => _WeatherPage(tab: index),
              ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    _router.dispose();
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: BlocBuilder<WeatherCubit, WeatherState>(
        builder: (context, state) => MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: weatherTheme(state.condition, state.brightness),
          routerConfig: _router,
        ),
      ),
    );
  }
}

class _Shell extends StatelessWidget {
  const _Shell({required this.tab, required this.child});

  final int tab;
  final Widget child;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Expressive Weather')),
    body: child,
    bottomNavigationBar: NavigationBar(
      selectedIndex: tab < 0 ? 0 : tab,
      onDestinationSelected: (index) => context.go(_paths[index]),
      destinations: const [
        NavigationDestination(icon: Icon(Icons.home), label: 'Today'),
        NavigationDestination(icon: Icon(Icons.radar), label: 'Radar'),
        NavigationDestination(
          icon: Icon(Icons.calendar_today),
          label: 'Forecast',
        ),
        NavigationDestination(icon: Icon(Icons.style), label: 'Components'),
      ],
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: context.read<WeatherCubit>().toggleBrightness,
      child: const Icon(Icons.brightness_6),
    ),
  );
}

class _WeatherPage extends StatelessWidget {
  const _WeatherPage({required this.tab});

  final int tab;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<WeatherCubit>().state;
    final scheme = Theme.of(context).colorScheme;
    final w = state.weather;
    if (state.failed) {
      return Center(
        child: FilledButton(
          onPressed: () => context.read<WeatherCubit>().load(state.condition),
          child: const Text('Retry'),
        ),
      );
    }
    if (w == null) return const Center(child: CircularProgressIndicator());
    switch (tab) {
      case 0:
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(w.condition.emoji, style: const TextStyle(fontSize: 64)),
                    Text(w.condition.label, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                    Text('${w.tempC.toStringAsFixed(0)}°  feels ${w.feelsLikeC.toStringAsFixed(0)}°  humidity ${w.humidity}%'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Text('Hourly - Rain chance as expressive bars', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 12),
            ...w.hourly.map((h) => Card(
              child: ListTile(
                leading: CircleAvatar(backgroundColor: scheme.primaryContainer, child: Text(h.hour)),
                title: Text('${h.temp.toStringAsFixed(0)}°'),
                subtitle: ClipRRect(borderRadius: BorderRadius.circular(99), child: LinearProgressIndicator(value: h.chance / 100, minHeight: 12)),
                trailing: Text('${h.chance}%'),
              ),
            )),
          ],
        );
      case 1:
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 280,
                decoration: BoxDecoration(color: scheme.surfaceContainerHighest, borderRadius: BorderRadius.circular(28)),
                child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Icon(Icons.radar, size: 64, color: scheme.primary),
                  const SizedBox(height: 12),
                  const Text('Radar mock - animation / tiles go here'),
                  Text('Condition: ${w.condition.label}', style: TextStyle(color: scheme.primary)),
                ])),
              ),
              const SizedBox(height: 12),
              FilledButton.icon(onPressed: () {}, icon: const Icon(Icons.play_arrow), label: const Text('Play radar animation')),
            ],
          ),
        );
      case 2:
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text('7-day forecast (mock)'),
            ...w.hourly.map((h) => ListTile(title: Text(h.hour), trailing: Text('${h.temp.toStringAsFixed(0)}°'))),
          ],
        );
      default:
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            SegmentedButton<WeatherCondition>(
              segments: const [
                ButtonSegment(value: WeatherCondition.sunny, label: Text('Sunny')),
                ButtonSegment(value: WeatherCondition.rainy, label: Text('Rainy')),
              ],
              selected: {state.condition == WeatherCondition.rainy ? WeatherCondition.rainy : WeatherCondition.sunny},
              onSelectionChanged: (s) => context.read<WeatherCubit>().load(s.first),
            ),
            const SizedBox(height: 16),
            FilledButton(onPressed: () {}, child: const Text('Filled Button')),
            const SizedBox(height: 8),
            OutlinedButton(onPressed: () {}, child: const Text('Outlined Button')),
            const SizedBox(height: 8),
            const Card(child: ListTile(title: Text('Expressive Card'), subtitle: Text('Shape, color and typography come from ThemeData'))),
            const SizedBox(height: 8),
            const LinearProgressIndicator(value: 0.6),
            const SizedBox(height: 16),
            const Text('All colors come from Theme.of(context).colorScheme - no hardcoded Colors.xxx in UI.'),
          ],
        );
    }
  }
}
