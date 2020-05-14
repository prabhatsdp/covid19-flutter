import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:covid_19/ui/widgets/how_corona_spreads.dart';

import 'package:covid_19/data/models/info_card_model.dart';
import 'dart:math' as math;

import 'package:flutter/services.dart';

class CoronaInfoPage extends StatelessWidget {
  final List<InfoCardModel> spreadInfoList = [
    InfoCardModel(title: "Air by Cough or Sneeze", imageSrc: "images/air_by_cough_or_sneeze.png"),
    InfoCardModel(title: "Personal \nContact", imageSrc: "images/personal_contact.png"),
    InfoCardModel(title: "Contaminated \nObjects", imageSrc: "images/contaminated_objects.png"),
    InfoCardModel(title: "Crowd \nGathering", imageSrc: "images/crowd.png"),
  ];

  final List<InfoCardModel> symptomsInfoList = [
    InfoCardModel(title: "Air by Cough or Sneeze", imageSrc: "images/air_by_cough_or_sneeze.png"),
    InfoCardModel(title: "Personal \nContact", imageSrc: "images/personal_contact.png"),
    InfoCardModel(title: "Contaminated \nObjects", imageSrc: "images/contaminated_objects.png"),
    InfoCardModel(title: "Crowd \nGathering", imageSrc: "images/crowd.png"),
  ];

  final List<InfoCardModel> preventInfoList = [
    InfoCardModel(title: "Air by Cough or Sneeze", imageSrc: "images/air_by_cough_or_sneeze.png"),
    InfoCardModel(title: "Personal \nContact", imageSrc: "images/personal_contact.png"),
    InfoCardModel(title: "Contaminated \nObjects", imageSrc: "images/contaminated_objects.png"),
    InfoCardModel(title: "Crowd \nGathering", imageSrc: "images/crowd.png"),
  ];

  CoronaInfoPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Color(0xFF23395D),
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.light,
          ),
          child: Scaffold(
            backgroundColor: Color(0xFF23395D),
            body: SafeArea(
              child: NestedScrollView(
                headerSliverBuilder: (BuildContext context, bool innerBoxIsSelected) {
                  return <Widget>[
                    SliverAppBar(
                      primary: true,
                      leading: IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                      backgroundColor: Color(0xFF23395D),
                      expandedHeight: 240.0,
                      floating: false,
                      snap: false,
                      pinned: false,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Container(
                          decoration: BoxDecoration(
                            color: Color(0xFF23395D),
                            image: DecorationImage(
                              image: AssetImage("images/corona_card_big.png"),
                              fit: BoxFit.cover,
                              alignment: Alignment.center,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 8.0, left: 20.0, top: 8.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Material(
                                    type: MaterialType.transparency,
                                    child: Container(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: AutoSizeText(
                                              "Covid-19",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 48,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              maxLines: 1,
                                            ),
                                          ),
                                          SizedBox(height: 12.0),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: AutoSizeText(
                                              "Everything you need \nto know",
                                              style: TextStyle(
                                                color: Colors.white.withOpacity(0.9),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              maxLines: 2,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  flex: 4,
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Transform(
                                    alignment: Alignment.center,
                                    transform: Matrix4.rotationY(math.pi),
                                    child: Image.asset(
                                      "images/corona_person.png",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ];
                },
                body: SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24.0),
                        topRight: Radius.circular(24.0),
                      ),
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 32.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "COVID-19 (Coronavirus)",
                                style: TextStyle(
                                  fontSize: 28.0,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 0.4,
                                  color: Colors.black.withBlue(100),
                                ),
                              ),
                              SizedBox(height: 4),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Icon(
                                    Icons.phone,
                                    size: 20.0,
                                    color: Colors.black.withBlue(200).withOpacity(0.6),
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    "Helpline Number 011-23978046",
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black.withBlue(200).withOpacity(0.6),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20.0),
                              Text(
                                "Coronavirus disease (COVID-19) is an infectious disease caused by a newly discovered coronavirus.",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black.withBlue(100).withOpacity(0.75),
                                  height: 1.5,
                                ),
                              ),
                              SizedBox(height: 16.0),
                              Text(
                                "Most people who fall sick with COVID-19 will experience mild to moderate symptoms and recover without special treatment.",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black.withBlue(100).withOpacity(0.8),
                                  height: 1.5,
                                ),
                              ),
                              SizedBox(height: 24.0),
                              HowCoronaSpreads(
                                title: "How it Spreads?",
                                infoList: spreadInfoList,
                              ),
                              SizedBox(height: 24.0),
                              HowCoronaSpreads(
                                title: "Symptoms",
                                infoList: symptomsInfoList,
                              ),
                              SizedBox(height: 24.0),
                              HowCoronaSpreads(
                                title: "Prevention",
                                infoList: preventInfoList,
                              ),
                              // Text(
                              //   "How it Spreads?",
                              //   style: TextStyle(
                              //     fontSize: 28.0,
                              //     fontWeight: FontWeight.w900,
                              //     letterSpacing: 0.4,
                              //     color: Colors.black.withBlue(100),
                              //   ),
                              // ),
                              // SizedBox(
                              //   height: 20.0,
                              // ),
                              // Row(
                              //   children: <Widget>[
                              //     Expanded(
                              //       child: InfoCardWithImage(
                              //         imageSrc: "images/air_by_cough_or_sneeze.png",
                              //         title: "Air by Cough or Sneeze",
                              //       ),
                              //     ),
                              //     SizedBox(
                              //       width: 20.0,
                              //     ),
                              //     Expanded(
                              //       child: InfoCardWithImage(
                              //         imageSrc: "images/personal_contact.png",
                              //         title: "Personal \nContact",
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              // SizedBox(
                              //   height: 20.0,
                              // ),
                              // Row(
                              //   children: <Widget>[
                              //     Expanded(
                              //       child: InfoCardWithImage(
                              //         imageSrc: "images/contaminated_objects.png",
                              //         title: "Contaminted \nObjects",
                              //       ),
                              //     ),
                              //     SizedBox(
                              //       width: 20.0,
                              //     ),
                              //     Expanded(
                              //       child: InfoCardWithImage(
                              //         imageSrc: "images/crowd.png",
                              //         title: "Crowd \nGathering",
                              //       ),
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
