// import 'dart:async';
import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:horizontal_data_table/refresh/pull_to_refresh/pull_to_refresh.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:technical_ind/components/LoadingPage.dart';
import 'package:technical_ind/components/noDataAvailable.dart';
import 'package:technical_ind/screens/landingPage.dart';
import 'package:technical_ind/screens/search/business/model.dart';
import '../../animated_search_bar.dart';
import 'business/bonds_model.dart';
import 'business/bonds_services.dart';
import 'package:http/http.dart' as http;

import '../../styles.dart';

class BondPage extends StatefulWidget {
  @override
  _BondPageState createState() => _BondPageState();
}

class _BondPageState extends State<BondPage> {
  List<BondsModel> bondsList;
  bool _isloading = true;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  var jsonText;
  List<StockSearch> stocks;
  List<IndicesSearch> indices;
  List<FundEtfSearch> fundsEtf;
  List<EtfSearch> etf;
  List<ForexSearch> forex;
  List<CryptoSearch> crypto;
  List<CommoditySearch> commodity;
  TextEditingController textController = TextEditingController();

  void getBondsResults() async {
    bondsList = await BondsServices.getSectorSenseList().whenComplete(() {});
    // if (gstocks == null) {
    //   jsonText = (await http.get(Uri.parse(
    //           "https://api.bottomstreet.com/api/data?page=stocks_isin_list")))
    //       .body;
    //   // await rootBundle.loadString('assets/instrument/stocks_list.json');
    //   print("done");
    //   gstocks = stockSearchFromJson(jsonText);
    //   jsonText = await rootBundle.loadString('assets/instrument/indices.json');
    //   print("done");
    //   gindices = indicesSearchFromJson(jsonText);
    //   jsonText = await rootBundle.loadString('assets/instrument/fundsEtf.json');
    //   print("done");
    //   gfundsEtf = fundEtfSearchFromJson(jsonText);
    //   jsonText = await rootBundle
    //       .loadString('assets/instrument/investing_etf_list.json');
    //   print("done");
    //   getf = etfSearchFromJson(jsonText);
    //   jsonText = await rootBundle.loadString('assets/instrument/forex.json');
    //   print("done");
    //   gforex = forexSearchFromJson(jsonText);
    //   jsonText = await rootBundle.loadString('assets/instrument/crypto.json');
    //   print("done");
    //   gcrypto = cryptoSearchFromJson(jsonText);
    // }

    _refreshController.refreshCompleted();
    setState(() {
      _isloading = false;
    });
  }

  List<double> per = [1.85, -1.85, 2.25];

  Widget bond(
      bool nseOrbse,
      String company,
      String id,
      String price,
      String percent,
      String open,
      String high,
      String low,
      String vol,
      String facevalue) {
    return InkWell(
      onTap: () {
        BotToast.showText(
          text: 'Coming soon!',
          contentColor: almostWhite,
          textStyle: TextStyle(color: black),
        );
      },
      child: Container(
        height: 265,
        color: Colors.black,
        child: Card(
          color: darkGrey,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                SizedBox(height: 4),
                Text(
                  company ?? "",
                  style: subtitle1White,
                  softWrap: false,
                  overflow: TextOverflow.fade,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(nseOrbse ? 'BSE Id:' : 'Series ',
                          style: captionWhite60),
                      Text(nseOrbse ? ' ' + id : ' N1', style: captionWhite),
                    ],
                  ),
                ),
                Text(price ?? "", style: bodyText2White),
                SizedBox(height: 2),
                Text(
                    percent.contains("0.00")
                        ? "0%"
                        : !percent.contains('-')
                            ? '+' + percent ?? ""
                            : percent ?? "",
                    style: bodyText2AnyColour.copyWith(
                        color: percent.contains('-')
                            ? Colors.red
                            : Colors.blue[700])
                    // TextStyle(
                    //   fontSize: 14,
                    //   color: (percent < 0) ? Colors.red : Colors.blue[700],
                    // ),
                    ),
                SizedBox(
                  height: 14,
                ),
                rows('Open', open ?? ""),
                rows('High', high ?? ""),
                rows('Low', low ?? ""),
                rows('Volume', vol ?? ""),
                rows('Face Value', facevalue ?? ""),
              ],
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
          ),
        ),
      ),
    );
  }

  //keeping this until nse list isn't empty! -> bond2

  Widget bond2(double percent, bool nseOrbse) {
    return Container(
      height: 265,
      color: Colors.black,
      child: Card(
        color: darkGrey,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(height: 4),
              Text('D S Kulkarni Developers', style: subtitle1White),
              Padding(
                padding: const EdgeInsets.only(top: 2, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(nseOrbse ? 'BSE Id:' : 'Series ',
                        style: captionWhite60),
                    Text(nseOrbse ? ' 961722' : ' N1', style: captionWhite),
                  ],
                ),
              ),
              Text('1325.30', style: bodyText2White),
              SizedBox(height: 2),
              Text(percent?.toString() ?? "" + "%",
                  style: bodyText2AnyColour.copyWith(
                      color: (percent < 0) ? Colors.red : Colors.blue[700])
                  // TextStyle(
                  //   fontSize: 14,
                  //   color: (percent < 0) ? Colors.red : Colors.blue[700],
                  // ),
                  ),
              SizedBox(
                height: 14,
              ),
              rows('Open', '1325.35'),
              rows('High', '1325.89'),
              rows('Low', '1325.03'),
              rows('Volume', '3250'),
              rows('Face Value', '1000'),
            ],
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getBondsResults();

    // Timer.periodic(Duration(milliseconds: autoRefreshDuration), (t) {
    //   if (mounted)
    //     getBondsResults();
    //   else {
    //     print("Timer Ticking is stopping.");
    //     t.cancel();
    //   }
    // });
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics.instance.setCurrentScreen(screenName: 'Bonds');
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(110),
          child:
              // Stack(
              //   children: [
              Column(
            children: [
              AppBar(
                backgroundColor: Colors.black,
                elevation: 0,
                leading: IconButton(
                  icon: Icon(CupertinoIcons.back),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                title: Text(
                  "Bonds",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              // SizedBox(height: 10),
              TabBar(
                labelStyle: buttonWhite,
                unselectedLabelColor: Colors.white38,
                //indicatorSize: TabBarIndicatorSize.label,
                indicator: MaterialIndicator(
                  horizontalPadding: 24,
                  bottomLeftRadius: 8,
                  bottomRightRadius: 8,
                  color: almostWhite,
                  paintingStyle: PaintingStyle.fill,
                ),
                tabs: [
                  Tab(
                    text: "BSE",
                  ),
                  Tab(
                    text: "NSE",
                    //child: NSEtab(),
                  ),
                  Tab(
                    text: "Global",
                  ),
                ],
              ),
            ],
          ),
          // Container(
          //   margin: EdgeInsets.fromLTRB(0, 10, 20, 0),
          //   child: AnimatedSearchBar(
          //     stocks: gstocks,
          //     indices: gindices,
          //     fundsEtf: gfundsEtf,
          //     etf: getf,
          //     forex: gforex,
          //     crypto: gcrypto,
          //     commodity: gcommodity,
          //     color: Colors.black,
          //     onSubmit: (value) {
          //       print('submitted search : $value');
          //     },
          //     style: TextStyle(
          //       color: Colors.white,
          //     ),
          //     closeSearchOnSuffixTap: true,
          //     suffixIcon: Icon(
          //       Icons.close,
          //       color: Colors.white,
          //     ),
          //     prefixIcon: Image.asset(
          //       'images/loupe.png',
          //       color: Colors.white,
          //       height: 24,
          //     ),
          //     rtl: true,
          //     width: MediaQuery.of(context).size.width,
          //     textController: textController,
          //     onSuffixTap: () {
          //       setState(() {
          //         textController.clear();
          //       });
          //     },
          //   ),
          // ),
          //   ],
          // ),
        ),
        body: _isloading
            ? LoadingPage()
            : bondsList == null
                ? NoDataAvailablePage()
                : Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    child: TabBarView(
                      children: [
                        SmartRefresher(
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
                          onRefresh: () => getBondsResults(),
                          child: ListView.builder(
                              itemCount: bondsList[0].data.bse.length,
                              itemBuilder: (ctx, index) {
                                return bond(
                                  true,
                                  bondsList[0]?.data?.bse[index].companyName ??
                                      "",
                                  bondsList[0]?.data?.bse[index].bseId ?? "",
                                  bondsList[0]?.data?.bse[index].price ?? "",
                                  bondsList[0]?.data?.bse[index].chgPercent ??
                                      "",
                                  bondsList[0]?.data?.bse[index].open ?? "",
                                  bondsList[0]?.data?.bse[index].high ?? "",
                                  bondsList[0]?.data?.bse[index].low ?? "",
                                  bondsList[0]?.data?.bse[index].volume ?? "",
                                  bondsList[0]?.data?.bse[index].faceValue ??
                                      "",
                                );
                              }),
                        ),
                        SmartRefresher(
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
                          onRefresh: () => getBondsResults(),
                          child: ListView.builder(
                              itemCount: bondsList[0].data.nse.length,
                              itemBuilder: (ctx, index) {
                                return bond(
                                  false,
                                  bondsList[0].data.nse[index].companyName,
                                  bondsList[0].data.nse[index].series,
                                  bondsList[0].data.nse[index].price,
                                  bondsList[0].data.nse[index].chgPercent + '%',
                                  bondsList[0].data.nse[index].open,
                                  bondsList[0].data.nse[index].high,
                                  bondsList[0].data.nse[index].low,
                                  bondsList[0].data.nse[index].volume,
                                  bondsList[0].data.nse[index].faceValue,
                                );
                              }),
                        ),
                        SmartRefresher(
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
                          onRefresh: () => getBondsResults(),
                          child: ListView.builder(
                              itemCount: bondsList[0].data.global.length,
                              itemBuilder: (ctx, index) {
                                return global(
                                  bondsList[0].data.global[index].shortName,
                                  bondsList[0].data.global[index].imgUrl,
                                  bondsList[0].data.global[index].fullName,
                                  bondsList[0].data.global[index].globalYield,
                                  bondsList[0].data.global[index].chg,
                                  bondsList[0].data.global[index].chgPercent,
                                  bondsList[0].data.global[index].coupon,
                                  bondsList[0].data.global[index].maturityDate,
                                  bondsList[0].data.global[index].high,
                                  bondsList[0].data.global[index].low,
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }

  Widget global(
      String shortname,
      String url,
      String fullname,
      String yieldval,
      String chg,
      String chgpercent,
      String coupon,
      String maturity,
      String high,
      String low) {
    String dateString;
    maturity != ""
        ? dateString = maturity.substring(6, maturity.length) +
            '/' +
            maturity.substring(4, 6) +
            '/' +
            maturity.substring(0, 4)
        : dateString = maturity;
    return InkWell(
      onTap: () => BotToast.showText(
        text: 'Coming soon!',
        contentColor: almostWhite,
        textStyle: TextStyle(color: black),
      ),
      child: Container(
        height: 240,
        color: Colors.black,
        child: Card(
          color: darkGrey,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                SizedBox(height: 4),
                Text(shortname, style: subtitle1White),
                Padding(
                  padding: const EdgeInsets.only(top: 2, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 12,
                        width: 22,
                        child: SvgPicture.network(
                          url,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Text(' ' + fullname, style: captionWhite),
                    ],
                  ),
                ),
                Text(yieldval, style: bodyText2),
                SizedBox(height: 2),
                Text(
                    chg[0] != '-'
                        ? '+' + chg + '(+' + chgpercent + ')'
                        : chg + '(' + chgpercent + ')',
                    style: bodyText2AnyColour.copyWith(
                      color: chgpercent[0] != '-' ? blue : red,
                    )),
                SizedBox(
                  height: 13,
                ),
                rows('Coupon', coupon),
                rows('Maturity Date', dateString),
                rows('High', high),
                rows('Low', low),
              ],
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
          ),
        ),
      ),
    );
  }

  Widget rows(String s, String d) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(s, textAlign: TextAlign.left, style: bodyText2White60),
          Text(d, textAlign: TextAlign.right, style: bodyText2White)
        ],
      ),
    );
  }
}
