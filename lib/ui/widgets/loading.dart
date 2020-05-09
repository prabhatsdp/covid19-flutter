import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(
          child: SizedBox(
            width: 100,
            height: 100,
            child: FlareActor(
              "assets/flare/loading_new.flr",
              alignment: Alignment.center,
              fit: BoxFit.contain,
              animation: "loading",
              color: Colors.blueAccent,
              
            ),
          ),
        ),
      ],
    );
  }
}
