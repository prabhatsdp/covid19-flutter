import 'package:covid_19/bloc/update_info_bloc.dart';
import 'package:covid_19/data/models/update_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdatePrompt extends StatefulWidget {
  UpdatePrompt({Key key}) : super(key: key);

  @override
  _UpdatePromptState createState() => _UpdatePromptState();
}

class _UpdatePromptState extends State<UpdatePrompt> {
  double containerHeight;
  @override
  void initState() {
    super.initState();
    containerHeight = 0;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      height: containerHeight,
      child: BlocBuilder<UpdateInfoBloc, UpdateInfoState>(
        builder: (context, state) {
          if (state is UpdateInfoInitial) {
            return showEmptyContainer();
          }

          if (state is UpdateInfoLoading) {
            return showEmptyContainer();
          }

          if (state is UpdateInfoLoaded) {
            return state.updateInfo.updateAvailable ? showUpdatePromptContainer(state.updateInfo) : showEmptyContainer();
          }

          if(state is UpdateInfoNoUpdate) {
            return showEmptyContainer();
          }

          if (state is UpdateInfoError) {
            Fluttertoast.showToast(msg: state.error);
            return showEmptyContainer();
          }
          return showEmptyContainer();
        },
      ),
    );
  }

  Widget showEmptyContainer() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        containerHeight = 0;
      });
    });
    return Container();
  }

  Widget showUpdatePromptContainer(UpdateInfo updateInfo) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        containerHeight = 84;
      });
    });
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.0),
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      decoration: BoxDecoration(
        color: Colors.blueAccent.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Text(
              "Update the app to see latest features.",
              style: TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.w600,
                fontSize: 16.0,
              ),
            ),
          ),
          SizedBox(
            width: 8.0,
          ),
          Expanded(
            flex: 1,
            child: RaisedButton(
              padding: EdgeInsets.only(
                bottom: 4.0,
              ),
              onPressed: () => _launchURL(updateInfo.downloadLink),
              color: Colors.blueAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(24.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Update",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
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
