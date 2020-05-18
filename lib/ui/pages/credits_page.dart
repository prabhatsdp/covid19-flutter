import 'package:auto_size_text/auto_size_text.dart';
import 'package:covid_19/animations/widget_enter_anim.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/services.dart';
import 'package:covid_19/ui/widgets/credits_page_header.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CreditsPage extends StatelessWidget {
  const CreditsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Color(0xFF23395D),
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.light,
          ),
          child: Scaffold(
            body: SafeArea(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF23395D),
                          image: DecorationImage(
                            image: AssetImage("images/corona_card_big.png"),
                            fit: BoxFit.cover,
                            alignment: Alignment.center,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0, left: 20.0, top: 24.0),
                          child: Stack(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Material(
                                      type: MaterialType.transparency,
                                      child: Container(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Hero(
                                              tag: "title_name",
                                              child: Material(
                                                type: MaterialType.transparency,
                                                child: AutoSizeText(
                                                  "Made with",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 36,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  maxLines: 1,
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 12.0),
                                            Hero(
                                              tag: "love",
                                              child: FaIcon(
                                                FontAwesomeIcons.solidHeart,
                                                color: Colors.pinkAccent,
                                                size: 48,
                                              ),
                                            ),
                                            // SizedBox(height: 12.0),
                                            WidgetEnterAnimation(
                                              delay: 0,
                                              child: AutoSizeText(
                                                "by Prabhat",
                                                style: TextStyle(
                                                  color: Colors.white.withOpacity(0.9),
                                                  fontSize: 28,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                maxLines: 2,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    flex: 3,
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Transform(
                                      alignment: Alignment.center,
                                      transform: Matrix4.rotationY(math.pi),
                                      child: Image.asset(
                                        "images/dev.png",
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Positioned(
                                top: 0.0,
                                left: 0.0,
                                child: GestureDetector(
                                  onTap: () => Navigator.of(context).pop(),
                                  child: Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 20.0),
                        child: Column(
                          children: <Widget>[
                            WidgetEnterAnimation(
                              delay: 0.25,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(50.0),
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 24,
                                          color: Colors.blueAccent.withOpacity(0.25),
                                          offset: Offset(4, 8),
                                          spreadRadius: 0,
                                        )
                                      ],
                                    ),
                                    child: Material(
                                      type: MaterialType.transparency,
                                      child: InkWell(
                                        onTap: () => _launchURL("https://facebook.com/iPrabhat404"),
                                        borderRadius: BorderRadius.circular(50.0),
                                        highlightColor: Color(0xFF3B5998).withOpacity(0.1),
                                        splashColor: Color(0xFF3B5998).withOpacity(0.25),
                                        child: Center(
                                          child: FaIcon(
                                            FontAwesomeIcons.facebookF,
                                            color: Color(0xFF3B5998),
                                            size: 48,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(50.0),
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 24,
                                          color: Colors.blueAccent.withOpacity(0.25),
                                          offset: Offset(4, 8),
                                          spreadRadius: 0,
                                        )
                                      ],
                                    ),
                                    child: Material(
                                      type: MaterialType.transparency,
                                      child: InkWell(
                                        onTap: () => _launchURL("https://twitter.com/crazybytes_in"),
                                        borderRadius: BorderRadius.circular(50.0),
                                        highlightColor: Color(0xFF00ACEE).withOpacity(0.1),
                                        splashColor: Color(0xFF00ACEE).withOpacity(0.25),
                                        child: Center(
                                          child: FaIcon(
                                            FontAwesomeIcons.twitter,
                                            color: Color(0xFF00ACEE),
                                            size: 48,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(50.0),
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 24,
                                          color: Colors.blueAccent.withOpacity(0.25),
                                          offset: Offset(4, 8),
                                          spreadRadius: 0,
                                        )
                                      ],
                                    ),
                                    child: Material(
                                      type: MaterialType.transparency,
                                      child: InkWell(
                                        onTap: () => _launchURL("https://github.com/iPrabhat404"),
                                        borderRadius: BorderRadius.circular(50.0),
                                        highlightColor: Color(0xFF211F1F).withOpacity(0.1),
                                        splashColor: Color(0xFF211F1F).withOpacity(0.25),
                                        child: Center(
                                          child: FaIcon(
                                            FontAwesomeIcons.github,
                                            color: Color(0xFF211F1F),
                                            size: 48,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 32.0),
                            WidgetEnterAnimation(
                              delay: 0.5,
                              child: Text(
                                "With Special Thanks to",
                                style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black.withBlue(100),
                                ),
                              ),
                            ),
                            SizedBox(height: 24.0),
                            WidgetEnterAnimation(
                              delay: 0.6,
                              child: Container(
                                width: MediaQuery.of(context).size.width / 1.4,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50.0),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 24,
                                      color: Colors.blueAccent.withOpacity(0.25),
                                      offset: Offset(4, 8),
                                      spreadRadius: 0,
                                    )
                                  ],
                                ),
                                child: Material(
                                  type: MaterialType.transparency,
                                  child: InkWell(
                                    onTap: () => _launchURL("https://api.covid19india.org/"),
                                    splashColor: Colors.blueAccent.withOpacity(0.25),
                                    highlightColor: Colors.blueAccent.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(50.0),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                                      child: IntrinsicWidth(
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            FaIcon(
                                              FontAwesomeIcons.handPointRight,
                                              color: Colors.blueAccent,
                                            ),
                                            SizedBox(width: 8.0),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                              child: AutoSizeText(
                                                "Covid-19 India API",
                                                style: TextStyle(
                                                  color: Colors.blueAccent,
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                maxLines: 1,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Spacer(),
                            WidgetEnterAnimation(
                              delay: 0.7,
                              child: Container(
                                width: MediaQuery.of(context).size.width / 1.4,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50.0),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 24,
                                      color: Colors.blueAccent.withOpacity(0.25),
                                      offset: Offset(4, 8),
                                      spreadRadius: 0,
                                    )
                                  ],
                                ),
                                child: Material(
                                  type: MaterialType.transparency,
                                  child: InkWell(
                                    onTap: () => _launchURL("https://www.freepik.com/free-photos-vectors/health"),
                                    splashColor: Colors.blueAccent.withOpacity(0.25),
                                    highlightColor: Colors.blueAccent.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(50.0),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                                      child: IntrinsicWidth(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            FaIcon(
                                              FontAwesomeIcons.handPointRight,
                                              color: Colors.blueAccent,
                                            ),
                                            SizedBox(width: 8.0),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                              child: AutoSizeText(
                                                "FreePik Resource 1",
                                                style: TextStyle(
                                                  color: Colors.blueAccent,
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                maxLines: 1,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Spacer(),
                            WidgetEnterAnimation(
                              delay: 0.8,
                              child: Container(
                                width: MediaQuery.of(context).size.width / 1.4,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50.0),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 24,
                                      color: Colors.blueAccent.withOpacity(0.25),
                                      offset: Offset(4, 8),
                                      spreadRadius: 0,
                                    )
                                  ],
                                ),
                                child: Material(
                                  type: MaterialType.transparency,
                                  child: InkWell(
                                    onTap: () => _launchURL("https://www.freepik.com/free-photos-vectors/people"),
                                    splashColor: Colors.blueAccent.withOpacity(0.25),
                                    highlightColor: Colors.blueAccent.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(50.0),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                                      child: IntrinsicWidth(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            FaIcon(
                                              FontAwesomeIcons.handPointRight,
                                              color: Colors.blueAccent,
                                            ),
                                            SizedBox(width: 8.0),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                              child: AutoSizeText(
                                                "FreePik Resource 2",
                                                style: TextStyle(
                                                  color: Colors.blueAccent,
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                maxLines: 1,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
