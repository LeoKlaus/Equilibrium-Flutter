import 'package:equilibrium_flutter/views/subviews/tappable_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

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
        ],
      ),
    );
  }
}
