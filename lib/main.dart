import 'package:flutter/widgets.dart';

import 'app/app.dart';
import 'app/bootstrap.dart';

void main() {
  configureDependencies();
  runApp(App(repository: dependencies()));
}
