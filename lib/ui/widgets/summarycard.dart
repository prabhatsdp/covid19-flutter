import 'package:auto_size_text/auto_size_text.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SummaryCard extends StatelessWidget {
  final int value;
  final String name;
  Color mainTextColor = Colors.white;
  Alignment cardImageAlignment = Alignment.center;
  final NumberFormat numberFormatter = new NumberFormat("##,##,##,##,###");

  SummaryCard({@required this.value, @required this.name}) {
    switch (this.name) {
      case "Confirmed":
        {
          mainTextColor = Colors.blueAccent;
          cardImageAlignment = Alignment.centerLeft;
        }
        break;
      case "Active":
        {
          mainTextColor = Colors.amberAccent[700];
          cardImageAlignment = Alignment.center;
        }
        break;
      case "Recovered":
        {
          mainTextColor = Colors.greenAccent[700];
          cardImageAlignment = Alignment.bottomRight;
        }
        break;
      case "Deaths":
        {
          mainTextColor = Colors.redAccent;
          cardImageAlignment = Alignment.topRight;
        }
        break;
      default:
        {
          mainTextColor = Colors.black;
          cardImageAlignment = Alignment.centerRight;
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      padding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: mainTextColor,
        image: DecorationImage(
          image: AssetImage("images/corona_card_big.png"),
          fit: BoxFit.none,
          alignment: cardImageAlignment,
        ),
        borderRadius: BorderRadius.all(Radius.circular(16)),
        boxShadow: [
          BoxShadow(
            blurRadius: 24,
            spreadRadius: 0,
            color: mainTextColor.withAlpha(200),
            offset: Offset(4, 8),
          ),
        ],
      ),
      child: Stack(
        children: <Widget>[
          SizedBox(
              height: 32,
              width: 32,
              child: FlareActor(
                "assets/flare/loading_new.flr",
                alignment: Alignment.center,
                fit: BoxFit.contain,
                animation: "loading",
              )),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                AutoSizeText(
                  numberFormatter.format(value),
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                  maxLines: 1,
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white.withAlpha(200),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
