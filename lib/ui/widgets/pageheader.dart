import 'package:covid_19/animations/widget_enter_anim.dart';
import 'package:flutter/material.dart';

class PageHeader extends StatefulWidget {
  final String title;

  PageHeader({@required this.title});

  @override
  _PageHeaderState createState() => _PageHeaderState();
}

class _PageHeaderState extends State<PageHeader> with AutomaticKeepAliveClientMixin {
  String dropDownValue = 'India';
  String titleName;

  @override
  void initState() {
    super.initState();
    this.titleName = widget.title;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 32,
          left: 16,
          right: 16,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            titleName == "India"
                ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 2,
                        ),
                        child: Text(
                          "Current Outbreak",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black.withBlue(50)),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(4),
                        splashColor: Colors.blueAccent.withOpacity(0.3),
                        highlightColor: Colors.blueAccent.withOpacity(0.15),
                        child: Icon(
                          Icons.healing,
                          color: Colors.black.withBlue(50),
                        ),
                      ),
                    ],
                  )
                : InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    borderRadius: BorderRadius.circular(4),
                    splashColor: Colors.blueAccent.withOpacity(0.3),
                    highlightColor: Colors.blueAccent.withOpacity(0.15),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black.withBlue(50),
                    ),
                  ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                titleName,
                style: TextStyle(
                  fontSize: 48,
                  color: Colors.black.withBlue(100),
                  fontWeight: FontWeight.w600,
                  fontFamily: "Niramit",
                ),
              ),
            ),
            //todo: implement global data and uncomment this code to handle page switching based on dropdown selection.
            // Theme(
            //   data: Theme.of(context).copyWith(
            //     canvasColor: Colors.greenAccent,
            //   ),
            //   child: DropdownButtonHideUnderline(
            //     child: DropdownButton<String>(
            //       value: dropDownValue,
            //       icon: Icon(
            //         Icons.arrow_drop_down,
            //         size: 42,
            //         color: Colors.black26.withBlue(100),
            //       ),
            //       style: TextStyle(fontSize: 48, color: Colors.black.withBlue(100), fontWeight: FontWeight.w600, fontFamily: "Niramit"),
            //       itemHeight: 64,
            //       items: <String>[
            //         "India",
            //         "Global"
            //       ].map((String value) {
            //         return DropdownMenuItem<String>(
            //           child: Container(
            //             padding: EdgeInsets.only(
            //               bottom: 10,
            //               right: 10,
            //             ),
            //             child: Text(
            //               value,
            //               style: TextStyle(fontWeight: FontWeight.w600),
            //             ),
            //           ),
            //           value: value,
            //         );
            //       }).toList(),
            //       onChanged: (String newValue) {
            //         setState(() {
            //           dropDownValue = newValue;
            //         });
            //       },
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
