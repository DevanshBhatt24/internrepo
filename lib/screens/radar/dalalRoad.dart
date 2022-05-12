import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:horizontal_data_table/refresh/pull_to_refresh/pull_to_refresh.dart';
//import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:technical_ind/components/LoadingPage.dart';
import 'package:technical_ind/components/noDataAvailable.dart';
import 'package:technical_ind/screens/radar/business/dalalRoad.dart';
import 'package:technical_ind/screens/radar/business/radarServices.dart';
import 'package:technical_ind/styles.dart';
import 'package:technical_ind/widgets/appbar_with_back_and_search.dart';

import 'dalalDetails.dart';

class DalalRoadPage extends StatefulWidget {
  DalalRoadPage({Key key}) : super(key: key);

  @override
  _DalalRoadPageState createState() => _DalalRoadPageState();
}

class _DalalRoadPageState extends State<DalalRoadPage> {
  List<Datum> brokers = [];
  bool loading = true;
  _fetchApi() async {
    brokers = await RadarServices.dalalRoadList();
    _refreshController.refreshCompleted();
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchApi();
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  List<Color> colors = [blue, red, blue, yellow, red, blue, yellow];
  @override
  Widget build(BuildContext context) {
    print(brokers.isNotEmpty);
    return Scaffold(
      appBar: AppBarWithBack(
        text: "Advice",
      ),
      body: loading
          ? LoadingPage()
          : brokers.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 2,
                      ),
                      Expanded(
                        child: SmartRefresher(
                          controller: _refreshController,
                          enablePullDown: true,
                          enablePullUp: false,
                          header: ClassicHeader(
                            completeIcon:
                                Icon(Icons.done, color: Colors.white60),
                            refreshingIcon: SizedBox(
                              width: 25,
                              height: 25,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.0,
                                color: Colors.white60,
                              ),
                            ),
                          ),
                          onRefresh: () => _fetchApi(),
                          child: ListView.builder(
                            itemCount: brokers.length,
                            itemBuilder: (c, i) {
                              return InkWell(
                                onTap: () {
                                  pushNewScreen(context,
                                      screen: DalalDetails(
                                        code: brokers[i]?.brokerCode ?? "",
                                        name: brokers[i]?.broker ?? "",
                                      ),
                                      withNavBar: false);
                                },
                                child: _customTile(
                                    color: colors[brokers[i]?.reco?.index],
                                    action: recoValues
                                        ?.reverse[brokers[i]?.reco]
                                        .toUpperCase(),
                                    brokerName: brokers[i]?.broker ?? "",
                                    companyName: brokers[i]?.company ?? "",
                                    targetPrice: brokers[i]?.targetPrice ?? "",
                                    latestPrice: brokers[i]?.latestPrice ?? "",
                                    latestPricePercent:
                                        brokers[i]?.latestPricePercent ?? "",
                                    potentialPercent:
                                        brokers[i]?.potentialPercent ?? "",
                                    recoPrice: brokers[i]?.recoPrice ?? ""),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Container(
                  margin: EdgeInsets.only(bottom: 22),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Broker Recomendations will\n\t\t\t\t\t\t be updated soon!  ",
                        style: TextStyle(color: Colors.white54, fontSize: 16),
                      )),
                ),
    );
  }

  Widget _customTile({
    Color color,
    String action,
    String brokerName,
    String companyName,
    String targetPrice,
    String latestPrice,
    String latestPricePercent,
    String potentialPercent,
    String recoPrice,
  }) {
    return Container(
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
                  companyName ?? "",
                  style: bodyText1white,
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  brokerName ?? "",
                  style: captionWhite,
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  latestPrice ?? "",
                  style: bodyText1white,
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  latestPricePercent.contains("-")
                      ? "(" + latestPricePercent + ")"
                      : "(+" + latestPricePercent + ")",
                  style: TextStyle(
                      fontSize: 16,
                      color: latestPricePercent.contains("-") ? red2 : blue,
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
                          textAlign: TextAlign.center, style: bodyText2White60),
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
                          textAlign: TextAlign.center, style: bodyText2White60),
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
                          textAlign: TextAlign.center, style: bodyText2White60),
                      Text(
                          potentialPercent.contains("-")
                              ? potentialPercent
                              : "+" + potentialPercent,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14,
                              color:
                                  potentialPercent.contains("-") ? red2 : blue,
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
              child: Text(action,
                  textAlign: TextAlign.center, style: captionWhite),
            ),
          ),
        ],
      ),
    );
  }
}
