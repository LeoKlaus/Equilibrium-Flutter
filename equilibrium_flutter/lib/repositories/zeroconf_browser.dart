/*
Failed to resolve discovered services on the android device I tested with, maybe try again later or with another device.

import 'package:bonsoir/bonsoir.dart';

class ZeroconfBrowser {
  BonsoirDiscovery? discovery;

  Future<void> startDiscovery() async {
    stopDiscovery();

    discovery = BonsoirDiscovery(type: "_equilibrium._tcp");

    await discovery?.initialize();

    discovery?.eventStream?.listen((event) {
      switch (event) {
        case BonsoirDiscoveryServiceFoundEvent():
          print('Service found : ${event.service.toJson()}');
          event.service.resolve(
            discovery!.serviceResolver,
          ); // Should be called when the user wants to connect to this service.
          break;
        case BonsoirDiscoveryServiceResolvedEvent():
          print('Service resolved : ${event.service.toJson()}');
          break;
        case BonsoirDiscoveryServiceUpdatedEvent():
          print('Service updated : ${event.service.toJson()}');
          break;
        case BonsoirDiscoveryServiceLostEvent():
          print('Service lost : ${event.service.toJson()}');
          break;
        default:
          print('Another event occurred : $event.');
          break;
      }
    });

    await discovery?.start();
  }

  Future<void> stopDiscovery() async {
    await discovery?.stop();
  }
}
*/