import 'package:flutter/material.dart';

class AnimatedBottomBar extends StatefulWidget {
  final List<NavBarItem> navBarItems;

  AnimatedBottomBar({this.navBarItems});

  @override
  _AnimatedBottomBarState createState() => _AnimatedBottomBarState();
}

class _AnimatedBottomBarState extends State<AnimatedBottomBar>
    with TickerProviderStateMixin {
  int selectedNavBar = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            spreadRadius: 0,
            color: Colors.black.withAlpha(50)
          )
        ]
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 8,
          bottom: 12,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _buildNavBarItems(),
        ),
      ),
    );
  }

  List<Widget> _buildNavBarItems() {
    List<Widget> _navBarItems = List();

    for (int i = 0; i < widget.navBarItems.length; i++) {
      NavBarItem item = widget.navBarItems[i];
      bool isSelected = selectedNavBar == i;
      _navBarItems.add(InkWell(
        splashColor: Colors.transparent,
        onTap: () {
          setState(() {
            selectedNavBar = i;
          });
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 150),
          padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(32)),
            color: isSelected ? item.color.withAlpha(50) : Colors.transparent,
          ),
          child: Row(
            children: <Widget>[
              Icon(
                item.iconData,
                size: 24,
                color: isSelected ? item.color : Colors.black,
              ),
              SizedBox(
                width: 8,
              ),
              AnimatedSize(
                duration: Duration(milliseconds: 150),
                vsync: this,
                child: Text(
                  isSelected ? item.title : "",
                  style: TextStyle(
                    fontSize: 18,
                    color: item.color,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              )
            ],
          ),
        ),
      ));
    }

    return _navBarItems;
  }
}

class NavBarItem {
  String title;
  IconData iconData;
  Color color;

  NavBarItem({this.title, this.iconData, this.color = Colors.black});
}
