import 'package:equilibrium_flutter/helpers/preference_handler.dart';
import 'package:equilibrium_flutter/repositories/zeroconf_browser.dart';
import 'package:equilibrium_flutter/stateful_shell_app.dart';
import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

import 'helpers/hub_connection_handler.dart';

Future<void> main() async {
  // Required for async calls in `main`
  WidgetsFlutterBinding.ensureInitialized();

  final preferences = await StreamingSharedPreferences.instance;
  final storedHubUri = preferences.getString(
    PreferenceKeys.hubUrl,
    defaultValue: "",
  );

  // TODO: Is this good practice?
  GetIt locator = GetIt.instance;
  locator.registerSingleton<HubConnectionHandler>(
    HubConnectionHandler(storedHubUri.getValue()),
  );
  locator.registerSingleton<EquilibriumSettings>(
    EquilibriumSettings(preferences),
  );

  runApp(StatefulShellApp());
}