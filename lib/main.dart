import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:gymkhana_app/app.dart';
import 'constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await getThemePreference();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new App());
  });
}
