import 'package:crypto_signals_july/internal/application.dart';
import 'package:crypto_signals_july/internal/services/helpers.dart';
import 'package:crypto_signals_july/internal/services/service_locator.dart';
import 'package:crypto_signals_july/internal/services/settings.dart';
import 'package:crypto_signals_july/internal/states/bottom_app_bar_state/bottom_app_bar_state.dart';
import 'package:crypto_signals_july/internal/states/generate_data_state/generate_data_state.dart';

import 'package:crypto_signals_july/internal/states/subscription_state/subscription_state.dart';
import 'package:crypto_signals_july/internal/utils/infrastructure.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Settings.
  final settings = Settings();
  await settings.initFirebase();
  await settings.initStorage();
  await rateMyApp.init();

  service.registerSingleton(settings);

  // States.
  service.registerLazySingleton<BottomAppBarState>(() => BottomAppBarState());
  service.registerLazySingleton<SubscriptionState>(() => SubscriptionState());
  service.registerLazySingleton<GenerateDataState>(() => GenerateDataState());

  runApp(const Application());
}
