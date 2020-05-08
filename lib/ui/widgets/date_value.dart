import 'package:covid_19/misc/helper.dart';
import 'package:flutter/material.dart';

class DateValue extends StatelessWidget {
  final String selectedDate;
  final int selectedCount;
  final Color chartColor;
  const DateValue({Key key, @required this.selectedDate, @required this.selectedCount, @required this.chartColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 28,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            Helper.parseAndFormatDateDDMMM(selectedDate),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: chartColor.withOpacity(0.75),
            ),
          ),
          SizedBox(width: 8),
          Text(
            Helper.formatNumber(selectedCount),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: chartColor.withOpacity(0.75),
            ),
          ),
        ],
      ),
    );
  }
}
