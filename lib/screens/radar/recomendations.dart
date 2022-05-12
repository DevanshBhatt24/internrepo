import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:technical_ind/components/LoadingPage.dart';
import 'package:technical_ind/components/codeSearch.dart';
import 'package:technical_ind/components/noDataAvailable.dart';
import 'package:technical_ind/components/utils.dart';
import 'package:technical_ind/screens/radar/business/dalalRoad.dart';
import 'package:technical_ind/screens/radar/business/radarServices.dart';
import 'package:technical_ind/screens/radar/dalalDetails.dart';
import 'package:technical_ind/screens/stocks/explore/home.dart';
import 'package:http/http.dart' as http;

import '../../styles.dart';
import '../../widgets/appbar_with_back_and_search.dart';

class RecommendPage extends StatefulWidget {
  final String code, name;
  RecommendPage({Key key, this.code, this.name}) : super(key: key);

  @override
  _RecommendPageState createState() => _RecommendPageState();
}

class _RecommendPageState extends State<RecommendPage> {
  List<BrokerRecomendation> recomendations;
  bool loading = true;
  List<Color> colors = [blue, red, blue, yellow, red];
  CodeSearch codeSearch;
  _fetchApi() async {
    recomendations = await RadarServices.brokerRecomendation(widget.code);

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
      appBar: AppBarWithBack(
        text: widget.name,
      ),
      body: loading
          ? LoadingPage()
          : recomendations != null
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        child: Text('Latest Recommendations',
                            textAlign: TextAlign.center, style: bodyText1white),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: recomendations?.length ?? 0,
                          itemBuilder: (context, i) {
                            return _customTile(
                                action: recoValues2
                                        .reverse[recomendations[i]?.reco]
                                        ?.toUpperCase() ??
                                    "-",
                                color:
                                    colors[recomendations[i]?.reco?.index ?? 0],
                                companyName: recomendations[i]?.company ?? "",
                                latestPrice:
                                    recomendations[i]?.latestPrice ?? "",
                                latestPricePercent:
                                    recomendations[i]?.latestPricePrecent ?? "",
                                potentialPercent:
                                    recomendations[i]?.potentialPercent ?? "",
                                recoPrice: recomendations[i]?.recoPrice ?? "",
                                targetPrice:
                                    recomendations[i]?.targetPrice ?? "",
                                marketMojoId: recomendations[i].marketsmojoId);

                            // buildTile(
                            //     title: recomendations[i].company,
                            //     action: recoValues2.reverse[recomendations[i].reco]
                            //         .toUpperCase(),
                            //     tPrice: recomendations[i].targetPrice,
                            //     color: colors[recomendations[i].reco.index],
                            //     code: recomendations[i].marketsmojoId);
                          },
                        ),
                      ),
                    ],
                  ),
                )
              : NoDataAvailablePage(),
    );
  }

  Widget _customTile({
    Color color,
    String action,
    String companyName,
    String targetPrice,
    String latestPrice,
    String latestPricePercent,
    String potentialPercent,
    String recoPrice,
    String marketMojoId,
  }) {
    return InkWell(
      onTap: () {
        print('hell9');
        pushNewScreen(context,
            screen: Homepage(
              // isin: isin,
              name: companyName,
              stockCode: marketMojoId,
              isRecom: true,
            ));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: darkGrey,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 22,
                  ),
                  Text(
                    companyName,
                    style: bodyText1white,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    latestPrice,
                    style: bodyText1white,
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  latestPricePercent == null
                      ? SizedBox()
                      : Text(
                          latestPricePercent.contains("-")
                              ? "(" + latestPricePercent + ")"
                              : "(+" + latestPricePercent + ")",
                          style: TextStyle(
                              fontSize: 16,
                              color: latestPricePercent.contains("-")
                                  ? red2
                                  : blue,
                              letterSpacing: 0.4),
                        ),
                  SizedBox(
                    height: 12,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Target Price",
                            textAlign: TextAlign.center,
                            style: bodyText2White60),
                        Text(targetPrice ?? "",
                            textAlign: TextAlign.center, style: bodyText2White),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Recomended@",
                            textAlign: TextAlign.center,
                            style: bodyText2White60),
                        Text(recoPrice ?? "",
                            textAlign: TextAlign.center, style: bodyText2White),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Potential",
                            textAlign: TextAlign.center,
                            style: bodyText2White60),
                        potentialPercent == null
                            ? SizedBox()
                            : Text(
                                potentialPercent.contains("-")
                                    ? potentialPercent
                                    : "+" + potentialPercent,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: potentialPercent.contains("-")
                                        ? red2
                                        : blue,
                                    letterSpacing: 0.4)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 11, vertical: 4),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(action ?? "",
                    textAlign: TextAlign.center, style: captionWhite),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
