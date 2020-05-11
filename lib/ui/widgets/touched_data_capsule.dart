import 'package:auto_size_text/auto_size_text.dart';
import 'package:covid_19/misc/helper.dart';
import 'package:flutter/material.dart';

class TouchedDataCapsule extends StatelessWidget {
  final String title;
  final int value;
  final Color color;
  const TouchedDataCapsule({Key key, @required this.title, @required this.value, this.color = Colors.blueAccent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: <Widget>[
            AutoSizeText(
              Helper.formatNumber(value),
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w800,
                fontSize: 18.0,
              ),
              maxLines: 1,
            ),
            AutoSizeText(
              title,
              style: TextStyle(
                color: color.withOpacity(0.75),
                fontWeight: FontWeight.w600,
              ),
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}
