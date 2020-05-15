import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:covid_19/ui/pages/credits_page.dart';
import 'package:auto_size_text/auto_size_text.dart';

class CreditsPageHeader extends StatelessWidget {
  final String titleName;
  const CreditsPageHeader({Key key, @required this.titleName}) : super(key: key);

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
            InkWell(
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
            SizedBox(
              height: 16.0,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: AutoSizeText(
                titleName,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 32,
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
}
