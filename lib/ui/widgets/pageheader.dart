import 'package:covid_19/animations/widget_enter_anim.dart';
import 'package:flutter/material.dart';

class PageHeader extends StatefulWidget {
  @override
  _PageHeaderState createState() => _PageHeaderState();
}

class _PageHeaderState extends State<PageHeader> {
  String dropDownValue = 'India';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 32,
          left: 16,
          right: 16,
        ),
        child: WidgetEnterAnimation(
          delay: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
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
                  Icon(
                    Icons.notifications,
                    size: 32,
                    color: Colors.black26.withBlue(100),
                  ),
                ],
              ),
              Theme(
                data: Theme.of(context).copyWith(
                  canvasColor: Colors.greenAccent,
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: dropDownValue,
                    icon: Icon(
                      Icons.arrow_drop_down,
                      size: 42,
                      color: Colors.black26.withBlue(100),
                    ),
                    style: TextStyle(fontSize: 48, color: Colors.black.withBlue(100), fontWeight: FontWeight.w600, fontFamily: "Niramit"),
                    itemHeight: 64,
                    items: <String>["India", "Global"].map((String value) {
                      return DropdownMenuItem<String>(
                        child: Container(
                          padding: EdgeInsets.only(
                            bottom: 10,
                            right: 10,
                          ),
                          child: Text(
                            value,
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                        value: value,
                      );
                    }).toList(),
                    onChanged: (String newValue) {
                      setState(() {
                        dropDownValue = newValue;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
