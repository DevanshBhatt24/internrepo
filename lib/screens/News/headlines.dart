import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:technical_ind/components/LoadingPage.dart';
import 'package:technical_ind/screens/News/NewsSearchPage.dart';
import 'package:technical_ind/screens/News/business/model.dart';
import 'package:technical_ind/screens/News/business/newsServices.dart';
import 'package:technical_ind/screens/News/pushnotification.dart';
import '../../styles.dart';

class NewsPulse extends StatefulWidget {
  const NewsPulse({Key key}) : super(key: key);

  @override
  _NewsPulseState createState() => _NewsPulseState();
}

class _NewsPulseState extends State<NewsPulse> {
  NewsServices _newsServices = NewsServices();
  Map pulseData;
  List<Widget> pulseWidgets = [];
  PushNotificationsManager pushNotifications = PushNotificationsManager();
  // getPulseData() async {
  //   List<NewsPulseModel> temp = await _newsServices.getNewsPulseData();
  //   setState(() {
  //     pulseData = temp;
  //   });
  // }

  @override
  void initState() {
    // getPulseData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    pushNotifications.init();
    FirebaseAnalytics.instance.setCurrentScreen(screenName: 'Headlines');
    return Scaffold(
        // appBar: PreferredSize(
        //   preferredSize: Size.fromHeight(100),
        //   child: Container(
        //     // backgroundColor: Colors.black,
        //     child: Text(
        //       "Headlines",
        //       style: GoogleFonts.ibmPlexSans(
        //           fontSize: 25,
        //           fontWeight: FontWeight.w400,
        //           color: Colors.white),
        //     ),
        //   ),
        // ),

        body: SingleChildScrollView(
      child: FutureBuilder(
          future: _newsServices.getNewsPulseData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              pulseData = groupBy(snapshot.data, (dynamic model) => model.date);
              // pulseData.forEach((key, value) {
              //   if (pulseWidgets.contains(key) == false) {
              //     pulseWidgets.add(PulseTile(
              //       date: key,
              //       pulseModelList: value,
              //     ));
              //   }
              // });
              final pulseDataKeys = pulseData.keys.toList();
              final pulseDataValues = pulseData.values.toList();
              // print('PulseData: ${pulseDataValues}');
              return Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: ListView.builder(
                        itemCount: pulseDataKeys.length,
                        itemBuilder: (context, index) {
                          return StickyHeader(
                              overlapHeaders: false,
                              header: Container(
                                color: Colors.black,
                                // margin: EdgeInsets.only(bottom: 0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.calendar_today_sharp),
                                        SizedBox(
                                          width: 7,
                                        ),
                                        Text(
                                          pulseDataKeys[index],
                                          style: TextStyle(fontSize: 19),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    )
                                  ],
                                ),
                              ),
                              content: PulseTile(
                                pulseModelList: pulseDataValues[index],
                              ));
                        }),
                  ),
                ],
              );
              // return Container(
              //   margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
              //   child: Column(
              //     children: pulseWidgets,
              //   ),
              // );
            } else {
              return Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.4),
                child: Center(
                    heightFactor: .5,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    )),
              );
              // return LoadingPage();
            }
          }),
    ));
  }
}

class PulseTile extends StatelessWidget {
  // String date;
  final List pulseModelList;
  PulseTile({Key key, this.pulseModelList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    pulseModelList.sort((a, b) => a.description.compareTo(b.description));
    // print(pulseModelList);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: pulseModelList
            .map((model) => Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Column(
                  children: [
                    Card(
                      color: Colors.black,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            child: ImageIcon(
                              AssetImage('assets/startIcons/bulletpoint.png'),
                              size: 16,
                              color: Color(0xFF007AFF),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 5),
                            width: MediaQuery.of(context).size.width * 0.84,
                            child: Text('${model.description}',
                                style: newsPulseStyle),
                          ),
                        ],
                      ),
                    ),
                    // Divider(
                    //   color: Colors.grey,
                    // ),
                  ],
                )))
            .toList(),
      ),
    );
  }
}
