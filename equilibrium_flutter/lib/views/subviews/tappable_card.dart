import 'dart:ui';

import 'package:equilibrium_flutter/views/subviews/styled_card.dart';
import 'package:flutter/material.dart';

class TappableCard extends StatelessWidget {
  final VoidCallback onTap;

  final Widget leadingTile;
  final String title;
  final String? subTitle;
  final Widget? trailingTile;

  const TappableCard({
    super.key,
    required this.onTap,
    required this.leadingTile,
    required this.title,
    this.subTitle,
    this.trailingTile,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: StyledCard(
          leadingTile: leadingTile,
          title: title,
          subTitle: subTitle,
          trailingTile: trailingTile,
        ),
      ),
    );
  }
}
