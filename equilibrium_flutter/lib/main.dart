import 'package:equilibrium_flutter/helpers/preference_handler.dart';
import 'package:equilibrium_flutter/stateful_shell_app.dart';
import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';

import 'helpers/hub_connection_handler.dart';

Future<void> main() async {
    // Required for async calls in `main`
    WidgetsFlutterBinding.ensureInitialized();

    // Initialize PreferenceUtils instance.
    await PreferenceHandler.init();

    // TODO: Is this good practice?
    GetIt locator = GetIt.instance;
    locator.registerSingleton<HubConnectionHandler>(HubConnectionHandler());

    runApp(StatefulShellApp());
}