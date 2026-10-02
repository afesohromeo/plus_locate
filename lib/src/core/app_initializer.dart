import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:plus_locate/firebase_options.dart';
import 'package:plus_locate/src/domain/models/saved_code.dart';

class AppInitializer {
  /// Whether Crashlytics is set up. When Firebase fails to start, the app
  /// still runs and errors only go to the console.
  bool _crashReportingReady = false;

  /// Initialize services, plugins, etc. before the app runs.
  Future<void> preAppRun() async {
    await _initCrashReporting();

    // Initialize Hive for local storage
    await Hive.initFlutter();

    // Register Hive type adapters
    Hive.registerAdapter(SavedCodeAdapter());
  }

  /// Initialize services, plugins, etc. after the app runs.
  Future<void> postAppRun() async {
    // Hide RSOD in release mode.
    if (kReleaseMode) {
      ErrorWidget.builder = (FlutterErrorDetails details) => const SizedBox();
    }
  }

  /// Reports an uncaught error from the app's error zone.
  void recordError(Object error, StackTrace stack) {
    if (_crashReportingReady) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    } else {
      debugPrintStack(label: error.toString(), stackTrace: stack);
    }
  }

  Future<void> _initCrashReporting() async {
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      // Debug runs (including the developer's own testing) aren't reported.
      await FirebaseCrashlytics.instance
          .setCrashlyticsCollectionEnabled(!kDebugMode);

      FlutterError.onError =
          FirebaseCrashlytics.instance.recordFlutterFatalError;
      PlatformDispatcher.instance.onError = (error, stack) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        return true;
      };
      _crashReportingReady = true;
    } catch (e) {
      log('Crash reporting unavailable: $e');
    }
  }
}
