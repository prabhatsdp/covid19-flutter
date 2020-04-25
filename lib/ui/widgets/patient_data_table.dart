import 'package:covid_19/animations/widget_enter_anim.dart';
import 'package:covid_19/data/models/my_state_data.dart';
import 'package:covid_19/misc/helper.dart';
import 'package:flutter/material.dart';

class PatientDataTable extends StatefulWidget {
  final List<MyStateData> stateWiseData;
  final double _rowAnimDelay = 1.5;

  PatientDataTable({Key key, @required this.stateWiseData}) : super(key: key);

  @override
  _PatientDataTableState createState() => _PatientDataTableState();
}

class _PatientDataTableState extends State<PatientDataTable> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 32,
      ),
      child: Column(
        children: <Widget>[
          WidgetEnterAnimation(
            delay: widget._rowAnimDelay,
            child: Column(
              children: <Widget>[buildTableHeaderRow()],
            ),
          ),
          WidgetEnterAnimation(
            delay: widget._rowAnimDelay + 0.5,
            child: Column(
              children: buildTable(),
            ),
          ),
          Column(
            children: <Widget>[
              WidgetEnterAnimation(
                delay: widget._rowAnimDelay + 0.75,
                child: buildTableRow(0, widget.stateWiseData.firstWhere((item) => item.state == "Total")),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// This function takes no arguments and returns a list of widget containing
  /// the rows for our table of stateWise data

  List<Widget> buildTable() {
    return List<Widget>.generate(widget.stateWiseData.length, (index) {
      if (widget.stateWiseData[index].state == "Total") {
        return SizedBox(
          width: 0,
          height: 0,
        );
      }
      return buildTableRow(index, widget.stateWiseData[index]);
    });
  }

  ///This function takes no arguments
  ///and returns the header row
  ///for our statewise table

  Widget buildTableHeaderRow() {
    return IntrinsicHeight(
      child: Padding(
        padding: const EdgeInsets.all(1.5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // State Name Cell
            Expanded(
              flex: 16,
              child: Tooltip(
                message: "State Name",
                child: Container(
                  margin: EdgeInsets.only(
                    right: 3,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.black.withAlpha(5),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "State/UT",
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                        color: Colors.black.withBlue(100),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Confirmed Count Cell
            Expanded(
              flex: 10,
              child: Container(
                margin: EdgeInsets.only(
                  right: 3,
                ),
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.blueAccent.withAlpha(10),
                ),
                child: Center(
                  child: Text(
                    "C",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: Colors.blueAccent,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            // Active Count Cell
            Expanded(
              flex: 10,
              child: Container(
                margin: EdgeInsets.only(
                  right: 3,
                ),
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.amberAccent[700].withAlpha(10),
                ),
                child: Center(
                  child: Text(
                    "A",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: Colors.amberAccent[700],
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            // Recovered Count Cell
            Expanded(
              flex: 10,
              child: Container(
                margin: EdgeInsets.only(
                  right: 3,
                ),
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.greenAccent[700].withAlpha(10),
                ),
                child: Center(
                  child: Text(
                    "R",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: Colors.greenAccent[700],
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            // Deaths Count Cell
            Expanded(
              flex: 8,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.redAccent.withAlpha(10),
                ),
                child: Center(
                  child: Text(
                    "D",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: Colors.redAccent,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///This function takes two arguments i.e.
  /// @param index
  /// &
  /// @param stateData and
  ///returns a single table row for our stateData

  Widget buildTableRow(int index, MyStateData stateData) {
    return IntrinsicHeight(
      child: Padding(
        padding: const EdgeInsets.all(1.5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // State Name Cell
            Expanded(
              flex: 16,
              child: Container(
                margin: EdgeInsets.only(
                  right: 3,
                ),
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.black.withAlpha(5),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    stateData.state,
                    style: TextStyle(
                      fontWeight: stateData.state != "Total" ? FontWeight.w600 : FontWeight.w900,
                      fontSize: stateData.state != "Total" ? 14 : 16,
                      color: Colors.black.withBlue(100),
                    ),
                  ),
                ),
              ),
            ),
            // Confirmed Count Cell
            Expanded(
              flex: 10,
              child: Container(
                margin: EdgeInsets.only(
                  right: 3,
                ),
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.blueAccent.withAlpha(10),
                ),
                child: Center(
                  child: Text(
                    stateData.confirmed == 0 ? "-" : Helper.formatNumber(stateData.confirmed),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: stateData.state != "Total" ? Colors.black.withAlpha(170) : Colors.blueAccent,
                    ),
                  ),
                ),
              ),
            ),
            // Active Count Cell
            Expanded(
              flex: 10,
              child: Container(
                margin: EdgeInsets.only(
                  right: 3,
                ),
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.amberAccent[700].withAlpha(10),
                ),
                child: Center(
                  child: Text(
                    stateData.active == 0 ? "-" : Helper.formatNumber(stateData.active),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: stateData.state != "Total" ? Colors.black.withAlpha(170) : Colors.amberAccent[700],
                    ),
                  ),
                ),
              ),
            ),
            // Recovered Count Cell
            Expanded(
              flex: 10,
              child: Container(
                margin: EdgeInsets.only(
                  right: 3,
                ),
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.greenAccent[700].withAlpha(10),
                ),
                child: Center(
                  child: Text(
                    stateData.recovered == 0 ? "-" : Helper.formatNumber(stateData.recovered),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: stateData.state != "Total" ? Colors.black.withAlpha(170) : Colors.greenAccent[700],
                    ),
                  ),
                ),
              ),
            ),
            // Deaths Count Cell
            Expanded(
              flex: 8,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.redAccent.withAlpha(10),
                ),
                child: Center(
                  child: Text(
                    stateData.deaths == 0 ? "_" : Helper.formatNumber(stateData.deaths),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: stateData.state != "Total" ? Colors.black.withAlpha(170) : Colors.redAccent,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// This function takes no arguments and
  /// returns a DataTable widget for the stateWiseData

  Widget buildDataTable() {
    return DataTable(
      columnSpacing: 10,
      horizontalMargin: 10,
      dataRowHeight: 30,
      headingRowHeight: 40,
      columns: [
        DataColumn(
          label: Text(
            "State",
            style: TextStyle(fontSize: 16),
          ),
          numeric: false,
          onSort: (i, b) {},
          tooltip: "State Name",
        ),
        DataColumn(
          label: Text("Confirmed"),
          numeric: false,
          onSort: (i, b) {},
          tooltip: "Confirmed",
        ),
        DataColumn(
          label: Text("A"),
          numeric: false,
          onSort: (i, b) {},
          tooltip: "Active",
        ),
        DataColumn(
          label: Text("R"),
          numeric: false,
          onSort: (i, b) {},
          tooltip: "Recovered",
        ),
        DataColumn(
          label: Text("D"),
          numeric: false,
          onSort: (i, b) {},
          tooltip: "Deaths",
        ),
      ],
      rows: [
        DataRow(cells: [
          DataCell(Text("5000")),
          DataCell(Text("5000")),
          DataCell(Text("5000")),
          DataCell(Text("5000")),
          DataCell(Text("5000")),
        ])
      ],
    );
  }
}
