import 'package:flutter/material.dart';

class ColorInverted extends StatefulWidget {
  final Widget child;

  const ColorInverted({super.key, required this.child});

  @override
  State<StatefulWidget> createState() =>_ColorInvertedState();
}

class _ColorInvertedState extends State<ColorInverted> {
  Brightness brightness = Brightness.light;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    brightness = MediaQuery.of(context).platformBrightness;
  }

  @override
  Widget build(BuildContext context) {
    return Row (
      mainAxisSize: MainAxisSize.min,
      children: [
      ColorFiltered(
        colorFilter:
            // TODO: Make this configurable
         brightness == Brightness.dark
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
        child: widget.child
    )],
    );
  }
}