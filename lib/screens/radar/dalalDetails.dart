import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:technical_ind/components/CircularSFindicator.dart';
import 'package:technical_ind/components/LoadingPage.dart';
import 'package:technical_ind/components/noDataAvailable.dart';
import 'package:technical_ind/screens/radar/business/dalalRoad.dart';
import 'package:technical_ind/screens/radar/business/radarServices.dart';
import 'package:technical_ind/styles.dart';
import 'package:technical_ind/widgets/appbar_with_back_and_search.dart';

import 'recomendations.dart';

class DalalDetails extends StatefulWidget {
  final String code, name;
  DalalDetails({Key key, this.code, this.name}) : super(key: key);

  @override
  _DalalDetailsState createState() => _DalalDetailsState();
}

class _DalalDetailsState extends State<DalalDetails> {
  BrokerInitial details;
  bool loading = true;
  _fetchApi() async {
    details = await RadarServices.brokerInitial(widget.code);
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithBack(text: ""),
      body: loading
          ? LoadingPage()
          : details != null
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        right: 0,
                        top: 127,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(widget.name,
                                  textAlign: TextAlign.center,
                                  style: headline6),
                              SizedBox(height: 48),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Column(
                                    children: <Widget>[
                                      Text(details.averageReturn ?? "",
                                          textAlign: TextAlign.center,
                                          style: headline5.copyWith(
                                              color: double.parse(details
                                                          .averageReturn
                                                          ?.replaceAll(
                                                              "%", "")) >=
                                                      0
                                                  ? blue
                                                  : red)),
                                      SizedBox(height: 20),
                                      Text('Average Return',
                                          textAlign: TextAlign.center,
                                          style: captionWhite60)
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      CircularSFindicator(
                                        value: double.parse(
                                            details?.successRate ?? ""),
                                        radius: 60,
                                        thickness: 6,
                                        backgroundColor: white38,

                                        //arcBackgroundColor: white38,
                                        color: blue,
                                        center: Text(
                                          details?.successRate ?? "" + '%',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: blue,
                                          ),
                                        ),
                                      ),
                                      Text('Success Rate',
                                          textAlign: TextAlign.center,
                                          style: captionWhite60)
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(height: 41),
                              buildColumn(details?.numberOfCalls ?? "",
                                  "Number Of Calls",
                                  valueFontSize: 18),
                              SizedBox(height: 27),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      buildColumn(details?.activeCalls ?? "",
                                          "Active Calls"),
                                      SizedBox(height: 18),
                                      buildColumn(details.expiredClosed,
                                          "Expired/Closed"),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      buildColumn(details?.targetHits ?? "",
                                          "Target Hit"),
                                      SizedBox(height: 18),
                                      buildColumn(details?.holdNeutral ?? "",
                                          "Hold/Neutral"),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 16),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 45,
                        left: 0,
                        right: 0,
                        child: InkWell(
                          onTap: () {
                            pushNewScreen(context,
                                screen: RecommendPage(
                                    name: widget.name, code: widget.code));
                          },
                          child: Container(
                            margin: EdgeInsets.all(16),
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                color: darkGrey,
                                borderRadius: BorderRadius.circular(6)),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("Latest Recommendations",
                                    style: buttonWhite),
                                Icon(
                                  CupertinoIcons.forward,
                                  color: almostWhite,
                                  //size: 30,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              : NoDataAvailablePage(),
    );
  }

  Column buildColumn(String value, String title, {double valueFontSize}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(value,
            textAlign: TextAlign.center,
            style: valueFontSize != null ? subtitle18 : subtitle2White),
        Text(title, textAlign: TextAlign.center, style: captionWhite60)
      ],
    );
  }
}
