import 'package:auto_size_text/auto_size_text.dart';
import 'package:covid_19/data/models/my_state_data.dart';
import 'package:covid_19/misc/helper.dart';
import 'package:flutter/material.dart';

class StateSummaryCard extends StatelessWidget {
  final Color cardColor;
  final int totalValue;
  final int todayChange;
  final String name;
  final String lastUpdatedTime;
  const StateSummaryCard({
    Key key,
    @required this.cardColor,
    @required this.totalValue,
    @required this.todayChange,
    @required this.name,
    @required this.lastUpdatedTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        height: 120,
        margin: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 24,
              color: cardColor.withOpacity(0.1),
              offset: Offset(4, 8),
            ),
          ],
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                todayChange.isNegative ? Helper.formatNumber(todayChange) : "+" + Helper.formatNumber(todayChange),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: cardColor.withOpacity(0.75),
                ),
              ),
              AutoSizeText(
                Helper.formatNumber(totalValue),
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800, color: cardColor),
                maxLines: 1,
              ),
              SizedBox(
                height: 4.0,
              ),
              Text(
                name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: cardColor.withOpacity(0.5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
