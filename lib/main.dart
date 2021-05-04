import 'package:flutter/cupertino.dart';
import 'package:gymkhana_app/app.dart';
import 'constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await getThemePreference();
  runApp(App());
}
