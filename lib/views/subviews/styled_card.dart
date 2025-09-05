import 'package:flutter/material.dart';

class StyledCard extends StatelessWidget {
  final Widget leadingTile;
  final String title;
  final String? subTitle;
  final Widget? subTitleWidget;
  final Widget? trailingTile;

  const StyledCard({
    super.key,
    required this.leadingTile,
    required this.title,
    this.subTitle,
    this.subTitleWidget,
    this.trailingTile,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      elevation: 2,
      child: Column(
        children: [
          if (subTitleWidget != null)
            ListTile(
              leading: leadingTile,
              title: Text(title),
              subtitle: subTitleWidget,
              trailing: trailingTile,
            )
          else if (subTitle != null)
            ListTile(
              leading: leadingTile,
              title: Text(title),
              subtitle: Text(
                subTitle!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 10,
                  color: Theme.of(context).disabledColor,
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
