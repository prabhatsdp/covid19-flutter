import 'package:flutter/material.dart';

class InfoCardWithImage extends StatelessWidget {
  final String imageSrc;
  final String title;
  final Color cardColor;
  const InfoCardWithImage({Key key, @required this.imageSrc, @required this.title, this.cardColor = Colors.blueAccent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 24,
            color: Colors.blueAccent.withOpacity(0.15),
            offset: Offset(4, 8),
          )
        ],
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        children: <Widget>[
          Container(
            height: 150,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.asset(
                imageSrc,
              ),
            ),
            decoration: BoxDecoration(
              color: cardColor.withOpacity(0.25),
              borderRadius: BorderRadius.circular(16.0),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.black.withBlue(100),
                  fontWeight: FontWeight.w800,
                  fontSize: 20.0,
                ),
              ),
            ),
            decoration: BoxDecoration(),
          ),
        ],
      ),
    );
  }
}
