import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class NoData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.network_locked,
          size: 148,
          color: Colors.redAccent.withAlpha(150),
        ),
        SizedBox(height: 32),
        Text(
          "Data Couldn't be loaded.",
          style: TextStyle(
            fontSize: 20,
            color: Colors.redAccent.withAlpha(150),
            fontWeight: FontWeight.w600,
          ),
        )
      ],
    );
  }
}
