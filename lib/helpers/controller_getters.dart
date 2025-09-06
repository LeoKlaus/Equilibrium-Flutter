import 'package:collection/collection.dart';
import 'package:equilibrium_flutter/models/classes/device.dart';
import 'package:equilibrium_flutter/models/enums/device_type.dart';

extension ControllerGetters on List<Device> {
  Device? get inputController {
    return firstWhereOrNull((device) => device.type == DeviceType.display) ??
        firstWhereOrNull((device) => device.type == DeviceType.other);
  }

  Device? get audioController {
    return firstWhereOrNull((device) => device.type == DeviceType.amplifier) ??
        firstWhereOrNull((device) => device.type == DeviceType.player) ??
        firstWhereOrNull((device) => device.type == DeviceType.display) ??
        firstWhereOrNull((device) => device.type == DeviceType.other);
  }

  Device? get navigationController {
    return firstWhereOrNull((device) => device.type == DeviceType.player) ??
        firstWhereOrNull((device) => device.type == DeviceType.display) ??
        firstWhereOrNull((device) => device.type == DeviceType.other);
  }

  Device? get channelController {
    return firstWhereOrNull((device) => device.type == DeviceType.player) ??
        firstWhereOrNull((device) => device.type == DeviceType.display) ??
        firstWhereOrNull((device) => device.type == DeviceType.other);
  }
}
