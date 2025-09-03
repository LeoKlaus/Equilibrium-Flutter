import 'package:flutter/material.dart';
import 'package:equilibrium_flutter/helpers/preference_handler.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class ColorInverted extends StatefulWidget {
  final Widget child;

  const ColorInverted({super.key, required this.child});

  @override
  State<StatefulWidget> createState() => _ColorInvertedState();
}

class _ColorInvertedState extends State<ColorInverted> {
  Brightness brightness = Brightness.light;

  final EquilibriumSettings settings = GetIt.instance<EquilibriumSettings>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    brightness = MediaQuery.of(context).platformBrightness;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        PreferenceBuilder<bool>(
          preference: settings.invertImages,
          builder:
              (context, invertImages) => ColorFiltered(
                colorFilter:
                    // TODO: Make this configurable
                    brightness == Brightness.dark && invertImages
                        ? const ColorFilter.matrix(<double>[
                          -1.0, 0.0, 0.0, 0.0, 255.0, //
                          0.0, -1.0, 0.0, 0.0, 255.0, //
                          0.0, 0.0, -1.0, 0.0, 255.0, //
                          0.0, 0.0, 0.0, 1.0, 0.0, //
                        ])
                        : const ColorFilter.matrix(<double>[
                          1.0, 0.0, 0.0, 0.0, 0.0, //
                          0.0, 1.0, 0.0, 0.0, 0.0, //
                          0.0, 0.0, 1.0, 0.0, 0.0, //
                          0.0, 0.0, 0.0, 1.0, 0.0, //
                        ]),
                child: widget.child,
              ),
        ),
      ],
    );
  }
}
