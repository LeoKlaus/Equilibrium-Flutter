import 'package:equilibrium_flutter/helpers/preference_handler.dart';
import 'package:equilibrium_flutter/views/subviews/tappable_card.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

import '../subviews/styled_card.dart';


class MoreScreen extends StatelessWidget {
  MoreScreen({super.key});

  final EquilibriumSettings settings = GetIt.instance<EquilibriumSettings>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('More')),
      body: ListView(
        children: [
          TappableCard(
            onTap: () {
              GoRouter.of(context).go("/more/images/");
            },
            leadingTile: Icon(Icons.image, size: 32),
            title: "Icons",
          ),
          TappableCard(
            onTap: () {
              GoRouter.of(context).go("/more/bluetooth_devices/");
            },
            leadingTile: Icon(Icons.bluetooth, size: 32),
            title: "Bluetooth Devices",
          ),
          TappableCard(
            onTap: () {
              GoRouter.of(context).go("/more/commands/");
            },
            leadingTile: Icon(Icons.code, size: 32),
            title: "Commands",
          ),
          TappableCard(
            onTap: () {
              GoRouter.of(context).go("/more/macros/");
            },
            leadingTile: Icon(Icons.keyboard_command_key, size: 32),
            title: "Macros",
          ),
          StyledCard(
            leadingTile: Icon(Icons.invert_colors),
            title: "Invert Images in Dark Mode",
            trailingTile: PreferenceBuilder<bool>(
              preference: settings.invertImages,
              builder:
                  (context, invertImages) => Switch(
                    value: invertImages,
                    onChanged:
                        (newValue) =>
                            settings.invertImages.setValue(!invertImages),
                  ),
            ),
          ),
          Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 30),
            child: Text(
              "Inverts all images for scenes and devices while in dark mode (works especially well for simple icons).",
              style: TextStyle(color: Theme.of(context).disabledColor),
            ),
          ),
        ],
      ),
    );
  }
}
