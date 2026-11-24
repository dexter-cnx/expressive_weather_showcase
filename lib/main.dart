import 'package:material_ui/material_ui.dart';
import 'data/weather_repository.dart';
import 'models/weather.dart';
import 'theme/weather_theme.dart';
void main() { runApp(const App()); }
class App extends StatefulWidget { const App({super.key}); @override State<App> createState() => _AppState(); }
class _AppState extends State<App> {
  WeatherCondition condition = WeatherCondition.sunny;
  Brightness brightness = Brightness.light;
  int tab = 0;
  final WeatherRepository repo = MockWeatherRepository();
  Weather? weather;
  @override void initState() { super.initState(); _load(); }
  Future<void> _load() async { final w = await repo.getWeather(condition); if (mounted) setState(() => weather = w); }
  void _setCondition(WeatherCondition c) { setState(() => condition = c); _load(); }
  @override Widget build(BuildContext context) {
    final scheme = weatherTheme(condition, brightness).colorScheme;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: weatherTheme(condition, brightness),
      home: Scaffold(
        appBar: AppBar(title: const Text('Expressive Weather')),
        body: _body(scheme),
        bottomNavigationBar: NavigationBar(
          selectedIndex: tab,
          onDestinationSelected: (i) => setState(() => tab = i),
          destinations: const [NavigationDestination(icon: Icon(Icons.home), label: 'Today'), NavigationDestination(icon: Icon(Icons.radar), label: 'Radar'), NavigationDestination(icon: Icon(Icons.calendar_today), label: 'Forecast'), NavigationDestination(icon: Icon(Icons.style), label: 'Components')],
        ),
        floatingActionButton: FloatingActionButton(onPressed: () => setState(() => brightness = brightness == Brightness.light ? Brightness.dark : Brightness.light), child: const Icon(Icons.brightness_6)),
      ),
    );
  }
  Widget _body(ColorScheme scheme) {
    final w = weather;
    if (w == null) return const Center(child: CircularProgressIndicator());
    final pages = <Widget>[
      ListView(padding: const EdgeInsets.all(16), children: [
        Card(child: Padding(padding: const EdgeInsets.all(20), child: Column(children: [Text(w.condition.emoji, style: const TextStyle(fontSize: 64)), Text(w.condition.label, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)), Text('${w.tempC.toStringAsFixed(0)}°  feels ${w.feelsLikeC.toStringAsFixed(0)}°  humidity ${w.humidity}%')] ))),
        const SizedBox(height: 12),
        const Text('Hourly - Rain chance as expressive bars', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(height: 12),
        ...w.hourly.map((h) => Card(child: ListTile(leading: CircleAvatar(backgroundColor: scheme.primaryContainer, child: Text(h.hour)), title: Text('${h.temp.toStringAsFixed(0)}°'), subtitle: ClipRRect(borderRadius: BorderRadius.circular(99), child: LinearProgressIndicator(value: h.chance / 100, minHeight: 12)), trailing: Text('${h.chance}%')))),
      ]),
      Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Container(height: 280, decoration: BoxDecoration(color: scheme.surfaceContainerHighest, borderRadius: BorderRadius.circular(28)), child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.radar, size: 64, color: scheme.primary), const SizedBox(height: 12), const Text('Radar mock - animation / tiles go here'), Text('Condition: ${w.condition.label}', style: TextStyle(color: scheme.primary))]))),
          const SizedBox(height: 12),
          FilledButton.icon(onPressed: () {}, icon: const Icon(Icons.play_arrow), label: const Text('Play radar animation')),
        ]),
      ),
      ListView(padding: const EdgeInsets.all(16), children: [const Text('7-day forecast (mock)'), const SizedBox(height: 8), ...w.hourly.map((h) => ListTile(title: Text(h.hour), trailing: Text('${h.temp.toStringAsFixed(0)}°')))]),
      ListView(padding: const EdgeInsets.all(16), children: [
        SegmentedButton<WeatherCondition>(segments: const [ButtonSegment(value: WeatherCondition.sunny, label: Text('Sunny')), ButtonSegment(value: WeatherCondition.rainy, label: Text('Rainy'))], selected: {condition == WeatherCondition.rainy ? WeatherCondition.rainy : WeatherCondition.sunny}, onSelectionChanged: (s) => _setCondition(s.first)),
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
      ]),
    ];
    return pages[tab];
  }
}
