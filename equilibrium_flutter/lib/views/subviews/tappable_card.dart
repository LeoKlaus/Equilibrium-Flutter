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
    return GestureDetector(
      onTap: onTap,
      child: StyledCard(
        leadingTile: leadingTile,
        title: title,
        subTitle: subTitle,
        trailingTile: trailingTile,
      )
    );
  }
}

class StyledCard extends StatelessWidget {

  final Widget leadingTile;
  final String title;
  final String? subTitle;
  final Widget? trailingTile;

  const StyledCard({
    super.key,
    required this.leadingTile,
    required this.title,
    this.subTitle,
    this.trailingTile,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 1,
      child: Column(
        children: [
          if (subTitle != null)
            ListTile(
              leading: leadingTile,
              title: Text(title),
              subtitle: Text(
                subTitle!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 10,
                ),
              ),
              trailing: trailingTile,
            )
          else
            ListTile(
              leading: leadingTile,
              title: Text(title),
              trailing: trailingTile,
            ),
        ],
      ),
    );
  }


}
