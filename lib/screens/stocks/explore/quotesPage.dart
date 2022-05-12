import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:technical_ind/components/LoadingPage.dart';
import 'package:technical_ind/components/noDataAvailable.dart';
import 'package:technical_ind/components/utils.dart';
import 'package:technical_ind/screens/stocks/business/models/StockDetailsModel.dart';
import 'package:technical_ind/screens/stocks/business/stockServices.dart';

import '../../../components/four_items_in_a_row.dart';
import '../../../styles.dart';
import '../../../widgets/customSlider.dart';

class ChartItem extends StatelessWidget {
  final String price, qty;

  const ChartItem({Key key, this.price, this.qty}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: new Text(
              price,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
                color: almostWhite,
              ),
            ),
          ),
          Expanded(
            child: new Text(
              qty,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
                color: almostWhite,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class NSEtab extends StatelessWidget {
  final Bse bse;
  final PreopeningSession preOpeningSession;
  NSEtab({Key key, this.bse, this.preOpeningSession}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print((double.parse(bse.price.replaceAll(',', '')) -
    //         double.parse(bse.daysRangeLow.replaceAll(',', ''))) /
    //     (double.parse(bse.daysRangeHigh.replaceAll(',', '')) -
    //         double.parse(bse.daysRangeLow.replaceAll(',', ''))));
    print(bse.change ?? "");
    print(bse.changePercent ?? "");
    return Column(
      children: [
        if (bse.price != "-") ...[
          SizedBox(height: 24),
          Center(child: Text(bse.price, style: headline4White)),
          SizedBox(height: 2),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(!bse.change.contains("-") ? "+${bse.change}" : "${bse.change}",
                style: subtitle1.copyWith(
                    color: !bse.change[0].contains("-") ? blue : red)),
            Text(
              !bse.changePercent.contains("-")
                  ? "(+${bse.changePercent.replaceAll("(", "")}"
                  : "${bse.changePercent}",
              style: subtitle1.copyWith(
                  color: !bse.changePercent[1].contains("-") ? blue : red),
            )
          ]),
          SizedBox(height: 40),
        ],
        bse.price != "-"
            ? CustomSlider(
                title: "Today L/H",
                minValue: bse.daysRangeLow,
                maxValue: bse.daysRangeHigh,
                value: (double.parse(bse.price.replaceAll(',', '')) -
                        double.parse(bse.daysRangeLow.replaceAll(',', ''))) /
                    (double.parse(bse.daysRangeHigh.replaceAll(',', '')) -
                        double.parse(bse.daysRangeLow.replaceAll(',', ''))),
              )
            : Container(),
        if (bse.price != "-") SizedBox(height: 32),
        bse.price != "-"
            ? CustomSlider(
                title: "52wk L/H",
                minValue: bse.weekRangeLow,
                maxValue: bse.weekRangeHigh,
                value: (double.parse(bse.price.replaceAll(',', '')) -
                        double.parse(bse.weekRangeLow.replaceAll(',', ''))) /
                    (double.parse(bse.weekRangeHigh.replaceAll(',', '')) -
                        double.parse(bse.weekRangeLow.replaceAll(',', ''))),
              )
            : Container(),
        if (bse.price != "-") SizedBox(height: 46),
        Text("Overview", style: subtitle1White),
        SizedBox(height: 30),
        CustomRow('Open', bse.open, 'Previous Close', bse.previousClose),
        CustomRow('UC Limit', bse.ucLimit, 'LC Limit', bse.lcLimit),
        CustomRow('Volume', bse.volume, 'VWAP', bse.vwap),
        CustomRow('Mkt Cap (₹ Cr.)', bse.marketCapture, '20D Avg Volume',
            bse.the20DAvgVolume),
        CustomRow('20D Avg Delivery', bse.the20DAvgDelivery, 'Beta', bse.beta),
        CustomRow('Face Value', bse.faceValue, 'TTM EPS', bse.ttmEps),
        CustomRow('TTM PE', bse.ttmPe, 'Sector PE', bse.sectorPe),
        CustomRow('BVPS', bse.bvps, 'P / B', bse.pB),
        CustomRow('Dividend Yield', bse.dividendYield, 'P / C', bse.pC),
        SizedBox(height: 50),
        new Text("Pre-Opening Session Prices",
            textAlign: TextAlign.center, style: subtitle1White),
        SizedBox(height: 4),
        new Text("09:00 am - 09:15 am", style: captionWhite60),
        SizedBox(height: 19),
        new Text(preOpeningSession.price, style: headline5White),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
              preOpeningSession.chg[0] == '-'
                  ? preOpeningSession.chg
                  : '+' + preOpeningSession.chg,
              style: preOpeningSession.chg[0] == '-'
                  ? caption.copyWith(color: red)
                  : caption.copyWith(color: blue)),
          Text(
              preOpeningSession.chgPercent[0] == '-'
                  ? '(' + preOpeningSession.chgPercent + '%)'
                  : '(+' + preOpeningSession.chgPercent + '%)',
              style: preOpeningSession.chgPercent[0] == '-'
                  ? caption.copyWith(color: red)
                  : caption.copyWith(color: blue))
        ]),
        SizedBox(height: 16),
        new Text(preOpeningSession.previousClose, style: subtitle1White),
        new Text("Previous Close", style: bodyText2White60),
      ],
    );
  }
}

class PopDialog extends StatelessWidget {
  const PopDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      backgroundColor: grey,
      child: Container(
        width: 0.9.sw,
        //height: 0.5.sh,
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: blue, borderRadius: BorderRadius.circular(8)),
                    child: new Text(
                      "Buy",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                        color: almostWhite,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: red, borderRadius: BorderRadius.circular(8)),
                    child: new Text(
                      "Sell",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                        color: almostWhite,
                      ),
                    ),
                  ),
                )
              ],
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 12.h),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: [
                            Expanded(
                              child: new Text(
                                "PRICE",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.white60,
                                ),
                              ),
                            ),
                            Expanded(
                              child: new Text(
                                "QTY",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.white60,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      ChartItem(
                        price: "50.54",
                        qty: "50",
                      ),
                      ChartItem(
                        price: "50.54",
                        qty: "504",
                      ),
                      ChartItem(
                        price: "50.54",
                        qty: "4",
                      ),
                      ChartItem(
                        price: "50.54",
                        qty: "54",
                      ),
                      ChartItem(
                        price: "50.54",
                        qty: "50",
                      ),
                      ChartItem(
                        price: "50.54",
                        qty: "4",
                      ),
                      ChartItem(
                        price: "50.54",
                        qty: "54",
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: [
                            Expanded(
                              child: new Text(
                                "TOTAL",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.white60,
                                ),
                              ),
                            ),
                            Expanded(
                              child: new Text(
                                "500",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: almostWhite,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 12.h),
                    ],
                  ),
                ),
                Container(
                  height: 230.h,
                  //margin: EdgeInsets.only(top: 40),
                  width: 2,
                  color: darkGrey.withOpacity(0.05),
                ),
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(height: 12.h),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: [
                            Expanded(
                              child: new Text(
                                "PRICE",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.white60,
                                ),
                              ),
                            ),
                            Expanded(
                              child: new Text(
                                "QTY",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.white60,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      ChartItem(
                        price: "50.54",
                        qty: "50",
                      ),
                      ChartItem(
                        price: "50.54",
                        qty: "504",
                      ),
                      ChartItem(
                        price: "50.54",
                        qty: "4",
                      ),
                      ChartItem(
                        price: "50.54",
                        qty: "54",
                      ),
                      ChartItem(
                        price: "50.54",
                        qty: "50",
                      ),
                      ChartItem(
                        price: "50.54",
                        qty: "4",
                      ),
                      ChartItem(
                        price: "50.54",
                        qty: "54",
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: [
                            Expanded(
                              child: new Text(
                                "TOTAL",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.white60,
                                ),
                              ),
                            ),
                            Expanded(
                              child: new Text(
                                "500",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: almostWhite,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 12.h),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class QuotesPage extends StatefulWidget {
  final String isin;
  QuotesPage({Key key, this.isin}) : super(key: key);

  @override
  _QuotesPageState createState() => _QuotesPageState();
}

class _QuotesPageState extends State<QuotesPage> {
  Quotes quotes;
  bool loading = true;

  _fetchApi() async {
    quotes = await StockServices.stockQuotesDetails(widget.isin);
    setState(() {
      loading = false;
    });
    _refreshController.refreshCompleted();
  }

  Timer _timer;

  @override
  void initState() {
    super.initState();
    _fetchApi();
    _timer = Timer.periodic(Duration(milliseconds: autoRefreshDuration), (t) {
      if (mounted)
        _fetchApi();
      else {
        print("Timer Ticking will stop.");
        t.cancel();
      }
    });
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void dispose() {
    // TODO: implement dispose

    _refreshController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: kindaWhite,
      body: loading
          ? LoadingPage()
          : quotes != null
              ? SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: false,
                  controller: _refreshController,
                  onRefresh: _fetchApi,
                  header: ClassicHeader(
                    completeIcon: Icon(Icons.done, color: Colors.white60),
                    refreshingIcon: SizedBox(
                      width: 25,
                      height: 25,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.0,
                        color: Colors.white60,
                      ),
                    ),
                  ),
                  child: SingleChildScrollView(
                      child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        if (quotes.analysis.performanceToday != null) ...[
                          SizedBox(height: 38),
                          Text('Analysis', style: subtitle1White),
                          SizedBox(height: 16),
                          if (quotes.analysis.performanceToday != null)
                            _analysis(
                                quotes.analysis.performanceToday.dir == '-1'
                                    ? Colors.pink
                                    : quotes.analysis.performanceToday.dir ==
                                            '0'
                                        ? Colors.yellow
                                        : quotes.analysis.performanceToday
                                                    .dir ==
                                                '1'
                                            ? blue
                                            : red,
                                quotes.analysis.performanceToday.header ?? '',
                                quotes.analysis.performanceToday.msg ?? ''),
                          if (quotes.analysis.dayConsecutive != null)
                            _analysis(
                                quotes.analysis.dayConsecutive.dir == '-1'
                                    ? Colors.pink
                                    : quotes.analysis.dayConsecutive.dir == '0'
                                        ? Colors.yellow
                                        : quotes.analysis.dayConsecutive.dir ==
                                                '1'
                                            ? blue
                                            : red,
                                quotes.analysis.dayConsecutive.header ?? '',
                                quotes.analysis.dayConsecutive.msg ?? ''),
                          if (quotes.analysis.movingAvg != null)
                            _analysis(
                                quotes.analysis.movingAvg.dir == '-1'
                                    ? Colors.pink
                                    : quotes.analysis.movingAvg.dir == '0'
                                        ? Colors.yellow
                                        : quotes.analysis.movingAvg.dir == '1'
                                            ? blue
                                            : red,
                                quotes.analysis.movingAvg.header ?? '',
                                quotes.analysis.movingAvg.msg ?? ''),
                          if (quotes.analysis.actionInMcap != null)
                            _analysis(
                                quotes.analysis.actionInMcap.dir == '-1'
                                    ? Colors.pink
                                    : quotes.analysis.actionInMcap.dir == '0'
                                        ? Colors.yellow
                                        : quotes.analysis.actionInMcap.dir ==
                                                '1'
                                            ? blue
                                            : red,
                                quotes.analysis.actionInMcap.header ?? '',
                                quotes.analysis.actionInMcap.msg ?? ''),
                          if (quotes.analysis.liquidity != null)
                            _analysis(
                                quotes.analysis.liquidity.dir == '-1'
                                    ? Colors.pink
                                    : quotes.analysis.liquidity.dir == '0'
                                        ? Colors.yellow
                                        : quotes.analysis.liquidity.dir == '1'
                                            ? blue
                                            : red,
                                quotes.analysis.liquidity.header ?? '',
                                quotes.analysis.liquidity.msg ?? ''),
                          SizedBox(height: 36),
                        ],
                        DefaultTabController(
                          length: 2,
                          initialIndex: 0,
                          child: Column(
                            children: [
                              StickyHeader(
                                header: Material(
                                  color: Colors.black,
                                  child: Column(children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: TabBar(
                                        labelStyle: buttonWhite,
                                        unselectedLabelColor: white38,
                                        indicator: MaterialIndicator(
                                          horizontalPadding: 30,
                                          bottomLeftRadius: 8,
                                          bottomRightRadius: 8,
                                          color: Colors.white.withOpacity(0.87),
                                          paintingStyle: PaintingStyle.fill,
                                        ),
                                        tabs: [
                                          Tab(
                                            text: "BSE",
                                          ),
                                          Tab(
                                            text: "NSE",
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]),
                                ),
                                content: SizedBox(
                                  height: 1185,
                                  child: TabBarView(children: [
                                    NSEtab(
                                        bse: quotes.bse,
                                        preOpeningSession:
                                            quotes.preopeningSession),
                                    NSEtab(
                                        bse: quotes.nse,
                                        preOpeningSession:
                                            quotes.preopeningSession)
                                  ]),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
                )
              : NoDataAvailablePage(),
    );
  }

  Widget _analysis(Color color, String a, String b) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(backgroundColor: color, radius: 3),
              SizedBox(width: 8),
              Text(
                a,
                style: subtitle2White,
              ),
            ],
          ),
          SizedBox(width: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 14),
              Expanded(child: SizedBox(child: Text(b, style: bodyText2White60)))
            ],
          )
        ],
      ),
    );
  }
}
