import 'dart:async';
import 'dart:developer';
import 'package:flutter/widgets.dart';
import 'package:firebase_core/firebase_core.dart';

/// Bootstrap is responsible for any common setup and calls
/// [runApp] with the widget returned by [builder] in an error zone.
Future<void> bootstrap({
  required FutureOr<Widget> Function() builder,
}) async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      // Prevents app from closing splash screen, app layout will be build but not displayed.

      await Firebase.initializeApp();

      // The following lines are the same as previously explained in "Handling uncaught errors"
      //  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

      runApp(await builder());
    },
    (error, stack) => log(error.toString(), stackTrace: stack),
  );
}
