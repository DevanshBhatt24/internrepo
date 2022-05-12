import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:technical_ind/components/LoadingPage.dart';
import 'package:technical_ind/providers/storageProviders.dart';
import 'package:technical_ind/screens/etf/business/models/etf_explore_model.dart';
import 'package:technical_ind/screens/mutual/business/fundsservices.dart';
import 'package:technical_ind/screens/mutual/business/mutualfunds.dart';
import 'package:technical_ind/screens/search/business/model.dart';
import 'package:technical_ind/widgets/appbar_with_bookmark_and_share.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/riskometer.dart';
import '../../styles.dart';
// import '../etf/business/models/etf_summary_model.dart';

class ChartData {
  final String x;
  final double y;
  final Color color;
  ChartData(this.x, this.y, [this.color]);
}

class Summary extends StatefulWidget {
  final String latestNav;
  final String title;
  final String mfcode;
  final Widget end;
  final int code;
  final bool isWatchlist, isSearch;

  Summary({
    this.title,
    this.isWatchlist = false,
    this.isSearch = false,
    this.end,
    this.latestNav,
    this.mfcode,
    this.code,
  });
  @override
  _SummaryState createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {
  MSummary summary;
  MutualFund mutualFundDetails;
  MutualPriceDetails mutualFundPriceDetails;
  About about;
  bool loading = true;
  List<ChartData> chartData;

  List<String> titleSplitted = [];
  List<String> keysvalue;
  List<FundEtfSearch> fundsEtf;

  _loadData() async {
    var jsonText =
        await rootBundle.loadString('assets/instrument/fundsEtf.json');
    print("done");
    setState(() {
      fundsEtf = fundEtfSearchFromJson(jsonText);
      loading = true;
    });
  }

  MutualWatchlistModel mf;
  double price;

  fetchApi() async {
    mf = MutualWatchlistModel.fromJson(
        {"title": widget.title, "id": widget.code.toString()});

    await _loadData();

    String mfcode;
    for (var i in fundsEtf) {
      if (i.field3 == widget.code) {
        mfcode = i.fundName;
      }
    }
    mutualFundDetails = await FundsService.fundDetails(mfcode);
    mutualFundPriceDetails = await FundsService.fundPriceDetails(mfcode);
    print(mutualFundDetails);
    print(mutualFundPriceDetails);

    if (mutualFundPriceDetails != null) {
      price = double.parse(mutualFundPriceDetails.price);
    }
    setState(() {
      summary = mutualFundDetails.summary;
      about = mutualFundDetails.about;
      loading = false;
      chartData = summary.assetAllocation.cash != '-'
          ? [
              ChartData(
                  'Equity',
                  summary.assetAllocation.equity != '-'
                      ? double.parse(summary.assetAllocation.equity)
                      : 0.0,
                  Colors.greenAccent),
              ChartData(
                  'Debt',
                  summary.assetAllocation.debt != '-'
                      ? double.parse(summary.assetAllocation.debt)
                      : 0.0,
                  Colors.yellowAccent),
              ChartData(
                  'Cash',
                  summary.assetAllocation.cash != '-'
                      ? double.parse(summary.assetAllocation.cash)
                      : 0.0,
                  Colors.purpleAccent),
            ]
          : [
              ChartData(
                  'Equity',
                  summary.assetAllocation.equity != '-'
                      ? double.parse(summary.assetAllocation.equity)
                      : 0.0,
                  Colors.greenAccent),
              ChartData(
                  'Debt',
                  summary.assetAllocation.debt != '-'
                      ? double.parse(summary.assetAllocation.debt)
                      : 0.0,
                  Colors.yellowAccent),
              ChartData(
                  'Other',
                  summary.assetAllocation.other != '-'
                      ? double.parse(summary.assetAllocation.other)
                      : 0.0,
                  Colors.purpleAccent),
            ];

      if (widget.title.contains('-')) titleSplitted = widget.title.split('-');
      keysvalue = [
        about.fundManager[0].numberOfFundManager,
        about.fundManager[0].longestTenure,
        about.fundManager[0].averageTenure,
        about.fundManager[0].amc,
      ];
    });
  }

  @override
  void initState() {
    fetchApi();
    super.initState();
  }

  List<dynamic> mutualwatchlist;
  Future<bool> checkIsSaved() async {
    print("checking saved...");
    var user = context.read(firestoreUserProvider);
    if (user.containsKey('MutualWatchlist')) {
      mutualwatchlist = user['MutualWatchlist'];
      for (int i = 0; i < mutualwatchlist.length; i++) {
        if (mutualwatchlist[i]["id"] == widget.code.toString()) {
          return true;
        }
      }
    }
    return false;
  }

  List<bool> press = [true, false, false, false, false, false];
  @override
  Widget build(BuildContext context) {
    final List<String> keys = [
      "Number of Fund Managers",
      "Longest Tenure(in Yrs)",
      "Average Tenure(in Yrs)",
      "AMC"
    ];

    return loading
        ? LoadingPage()
        : Scaffold(
            appBar: AppbarWithShare(
              showShare: false,
              isSaved: checkIsSaved,
              onSaved: () async {
                var db = context.read(storageServicesProvider);
                await db.updateMutualWatchlist(mf);
                BotToast.showText(
                    contentColor: almostWhite,
                    textStyle: TextStyle(color: black),
                    text: "Added to Watchlist");
              },
              delSaved: () async {
                print("removing...");
                var db = context.read(storageServicesProvider);
                mutualwatchlist
                    .removeWhere((element) => element["id"] == mf.id);
                //since the id is used to remove the watchlist from firebase
                await db.removeMutualWatchlistOtherway(mutualwatchlist);
                BotToast.showText(
                    contentColor: almostWhite,
                    textStyle: TextStyle(color: black),
                    text: "Removed from Watchlist");
              },
            ),
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: SingleChildScrollView(
                child: StickyHeader(
                  header: Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: 6),
                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 20),
                    decoration: BoxDecoration(
                      color: black,
                      // borderRadius: BorderRadius.circular(6),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (!widget.isSearch)
                          titleSplitted.length == 0
                              ? Text(widget.title,
                                  textAlign: TextAlign.center,
                                  style: subtitle2White)
                              : Text(
                                  titleSplitted[0] +
                                          "\n -" +
                                          titleSplitted[1] ??
                                      "",
                                  textAlign: TextAlign.center,
                                  style: subtitle2White),
                        if (widget.isSearch)
                          Text(widget.title,
                              textAlign: TextAlign.center,
                              style: subtitle2White),
                        SizedBox(
                          height: 8,
                        ),
                        if (widget.latestNav != null) ...[
                          SizedBox(
                            height: 5,
                          ),
                          Text('${widget.latestNav}', style: bodyText1white),
                        ],
                        if (widget.isWatchlist || widget.isSearch) ...[
                          SizedBox(
                            height: 5,
                          ),
                          Text('${price.toStringAsFixed(2)}',
                              style: bodyText1white),
                        ],
                        if (widget.end != null) widget.end,
                        SizedBox(
                          height: 5,
                        ),
                        if (mutualFundPriceDetails != null)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                mutualFundPriceDetails.chng.contains('-')
                                    ? '${mutualFundPriceDetails.chng} '
                                    : '+${mutualFundPriceDetails.chng} ',
                                style: TextStyle(
                                    color: mutualFundPriceDetails.chng
                                            .contains('-')
                                        ? red
                                        : blue),
                              ),
                              Text(
                                mutualFundPriceDetails.chngPercentage
                                        .contains('-')
                                    ? '(${mutualFundPriceDetails.chngPercentage}%)'
                                    : '(+${mutualFundPriceDetails.chngPercentage}%)',
                                style: TextStyle(
                                    color: mutualFundPriceDetails.chngPercentage
                                            .contains('-')
                                        ? red
                                        : blue),
                              )
                            ],
                          )
                      ],
                    ),
                  ),
                  content: Column(
                    children: [
                      SizedBox(height: 10),
                      _headertext("Overview"),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: ListView(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          children: List.generate(
                            summary.overView.length,
                            (i) {
                              return summary.overView[i].title == "Benchmark"
                                  ? SizedBox()
                                  : Container(
                                      padding: EdgeInsets.only(bottom: 12),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        // crossAxisAlignment: i % 2 == 0
                                        //     ? CrossAxisAlignment.start
                                        //     : CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                              summary.overView[i].title ==
                                                      "Asset Under Management"
                                                  ? "AUM"
                                                  : summary.overView[i].title,
                                              style: bodyText2White60),
                                          Text(
                                            summary.overView[i].value,
                                            style: bodyText1white.copyWith(
                                                fontSize: 14),
                                            textAlign: i % 2 != 0
                                                ? TextAlign.right
                                                : TextAlign.left,
                                          ),
                                        ],
                                      ),
                                    );
                            },
                          ),
                        ),
                      ),

                      if (mutualFundPriceDetails != null)
                        Container(
                          child: Column(
                            children: [
                              SizedBox(height: 10),
                              _headertext("Riskometer"),
                              SizedBox(height: 10),
                              Container(
                                  width: 350,
                                  height: 250,
                                  // color: Colors.blue,
                                  child: DistanceTrackerExample(
                                      meter: summary.riskometer.meter,
                                      riskometer: summary.riskometer)),
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                          child: Text(
                                        summary
                                            .riskometer.annualizedReturn.text,
                                        style: subtitle1profile,
                                      )),
                                      Flexible(
                                        child: Text(
                                          summary.riskometer.annualizedReturn
                                              .value,
                                          style: subtitle1profile,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          summary.riskometer.suggestedInvestment
                                              .text,
                                          style: subtitle1White,
                                        ),
                                      ),
                                      Flexible(
                                        child: Text(
                                          summary.riskometer.suggestedInvestment
                                              .value,
                                          style: subtitle1White,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          summary.riskometer.averageTimeTaken[0]
                                              .text,
                                          style: subtitle1White,
                                        ),
                                      ),
                                      Flexible(
                                        child: Text(
                                          summary.riskometer.averageTimeTaken[0]
                                              .value,
                                          style: subtitle1White,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      SizedBox(height: 20),
                      _headertext("Asset Allocation"),
                      SizedBox(height: 38),
                      Container(
                          width: 140,
                          height: 140,
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: SfCircularChart(series: <CircularSeries>[
                              // Renders doughnut chart
                              DoughnutSeries<ChartData, String>(
                                  dataSource: chartData,
                                  radius: '130%',
                                  innerRadius: '60%',
                                  //strokeWidth:10,
                                  pointColorMapper: (ChartData data, _) =>
                                      data.color,
                                  xValueMapper: (ChartData data, _) => data.x,
                                  yValueMapper: (ChartData data, _) => data.y)
                            ]),
                          )),
                      SizedBox(height: 38),
                      Row(
                        children: [
                          row(chartData[0]),
                          row(chartData[1]),
                          row(chartData[2]),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      ),
                      SizedBox(height: 10),
                      // _headertext("Top 5 Peer Comparison"),
                      // SizedBox(height: 20),
                      // ...List.generate(
                      //     mfsummary.top5Peers.length,
                      //     (index) => Container(
                      //             child: Column(
                      //           mainAxisAlignment: MainAxisAlignment.center,
                      //           children: [
                      //             Container(
                      //                 width: MediaQuery.of(context).size.width * 0.4,
                      //                 child: Text(
                      //                   mfsummary.top5Peers[index].fundName,
                      //                   textAlign: TextAlign.center,
                      //                   style: subtitle1White,
                      //                 )),
                      //             Row(
                      //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //               children: [
                      //                 Text(
                      //                   'One year return',
                      //                   style: subtitle2White60,
                      //                 ),
                      //                 Text(
                      //                   mfsummary.top5Peers[index].oneYearReturn,
                      //                   style: TextStyle(
                      //                       color: mfsummary
                      //                               .top5Peers[index].oneYearReturn
                      //                               .contains('-')
                      //                           ? red2
                      //                           : blue),
                      //                 )
                      //               ],
                      //             ),
                      //             Row(
                      //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //               children: [
                      //                 Text(
                      //                   'Three year return',
                      //                   style: subtitle2White60,
                      //                 ),
                      //                 Text(
                      //                   mfsummary.top5Peers[index].threeYearReturn,
                      //                   style: TextStyle(
                      //                       color: mfsummary
                      //                               .top5Peers[index].threeYearReturn
                      //                               .contains('-')
                      //                           ? red2
                      //                           : blue),
                      //                 )
                      //               ],
                      //             )
                      //           ],
                      //         )))

                      _headertext("Fund Manager"),

                      ...List.generate(
                          4,
                          (index) => Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                        child: Text(
                                      keys[index],
                                      style: subtitle1White60,
                                    )),
                                    Flexible(
                                        child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.3,
                                            child: Text(
                                              keysvalue[index],
                                              textAlign: TextAlign.right,
                                              style: subtitle1White,
                                            )))
                                  ],
                                ),
                              )),
                      SizedBox(height: 10),
                      ...List.generate(
                          about.fundManager[0].managers.length,
                          (index) => Container(
                                margin: EdgeInsets.only(top: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                        child: Row(children: [
                                      Icon(Icons.person_outline),
                                      SizedBox(
                                        width: 6,
                                      ),
                                      Text(
                                        about.fundManager[0].managers[index]
                                            .name,
                                        style: subtitle1White,
                                      ),
                                    ])),
                                    Expanded(
                                        child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.3,
                                            child: Text(
                                              about.fundManager[0]
                                                  .managers[index].duration,
                                              textAlign: TextAlign.right,
                                              style: subtitle1White60,
                                            )))
                                  ],
                                ),
                              )),
                      SizedBox(height: 20),

                      _headertext("Basic Attributes"),

                      SizedBox(height: 15),
                      ...List.generate(
                        about.basicAttribute.length,
                        (index) => column(about.basicAttribute[index].text,
                            about.basicAttribute[index].value),
                      ),

                      SizedBox(height: 20),
                      _headertext("Concentration Analysis"),

                      SizedBox(height: 15),
                      ...List.generate(
                        about.concentrationAnalysis.length,
                        (index) => column(
                            about.concentrationAnalysis[index].title,
                            about.concentrationAnalysis[index].value),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  Widget _headertext(String text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        // color: darkGrey,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(text, style: subtitle1White, textAlign: TextAlign.center)
        ],
      ),
    );
  }

  Widget row(ChartData c) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            SizedBox(height: 7),
            CircleAvatar(backgroundColor: c.color, radius: 5),
          ],
        ),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  c.y.toString() + ' %',
                  style: subtitle1profile,
                ),
              ],
            ),
            Text(c.x, style: subtitle1profile),
            SizedBox(height: 30)
          ],
        )
      ],
    );
  }

  Widget _button(String txt, int index) {
    return FlatButton(
      onPressed: () {
        setState(() {
          for (int i = 0; i < press.length; i++) press[i] = false;
          press[index] = true;
        });
      },
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
          side: BorderSide(
            color: press[index] ? almostWhite : white38,
            width: 1,
          )),
      // color: press[index] ? almostWhite : grey,
      height: 36,
      minWidth: 48,
      child: Text(
        txt,
        style: button.copyWith(
          color: press[index] ? almostWhite : white38,
        ),
      ),
    );
  }

  Widget column(String a, String b) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              width: MediaQuery.of(context).size.width * 0.4,
              child: Text(a, style: bodyText2White60)),
          Container(
              width: MediaQuery.of(context).size.width * 0.4,
              child: Text(
                b,
                style: bodyText2White,
                textAlign: TextAlign.right,
              )),
        ],
      ),
    );
  }
}
