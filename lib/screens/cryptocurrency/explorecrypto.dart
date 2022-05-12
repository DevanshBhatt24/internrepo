import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:technical_ind/components/LoadingPage.dart';
import 'package:technical_ind/providers/storageProviders.dart';
import 'package:technical_ind/screens/News/business/model.dart';
import 'package:technical_ind/screens/News/business/newsServices.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:technical_ind/styles.dart';
import 'package:technical_ind/widgets/appbar_with_bookmark_and_share.dart';
import 'containerpagecrypto.dart';
import 'business/crypto_overview_model.dart';
import 'business/crypto_services.dart';

class ExplorePageCrypto extends StatefulWidget {
  // final List<String> menu;
  // final List<Widget> menuWidgets;
  final String title, value, subValue, filter;
  final Widget top, mid, end;
  final String expiryDate, currencychart;
  final double defaultheight;
  final bool isSearch;

  ExplorePageCrypto(
      {Key key,
      this.isSearch = false,
      this.currencychart,
      this.filter,
      // this.menu,
      this.title,
      this.value,
      this.subValue,
      // this.menuWidgets,
      this.expiryDate,
      this.top,
      this.mid,
      this.end,
      this.defaultheight = 80})
      : super(key: key);

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePageCrypto> {
  CryptoOverviewModel arr;
  bool _loading = true;

  List<Article> articles = [];

  void getArticles(String title) async {
    articles = await NewsServices.getNewsFromQuery(title).whenComplete(() {
      setState(() {});
    });
  }

  Future<bool> checkIsSaved() async {
    print("checking saved...");
    var user = context.read(firestoreUserProvider);
    if (user.containsKey('CryptoWatchlist')) {
      List<dynamic> cryptowatchlist = user['CryptoWatchlist'];

      return cryptowatchlist.contains(widget.filter);
    }
    return false;
  }

  String price;
  String chng;
  String query;
  getCryptoOverview() async {
    final response = await CryptoServices.getSearchDetails(widget.filter);
    // arr = await CryptoServices.getCryptoOverview(widget.filter);
    setState(() {
      price = '₹ ${response["quoteResponse"]["result"][0]["regularMarketPrice"]["fmt"]}';
      chng = response["quoteResponse"]["result"][0]
                  ["regularMarketChangePercent"]["fmt"]
              .toString();
      _loading = false;
    });
  }

  @override
  void initState() {
    query = widget.filter;
    super.initState();
    // menu = widget.menu;
    getCryptoOverview();
  }

  PanelController _panelController = new PanelController();
  List<String> menu = [
    "Overview",
    "Charts",
    "Technical Indicators",
    "Historical Data",
    "News",
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SlidingUpPanel(
        controller: _panelController,
        color: const Color(0xff1c1c1e),
        defaultPanelState: PanelState.CLOSED,
        backdropEnabled: true,
        minHeight: 0,
        maxHeight: widget.defaultheight + menu.length * 48 + 2,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18), topRight: Radius.circular(18)),
        panel: Column(
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 8, bottom: 24),
                width: 38,
                height: 4,
                decoration: BoxDecoration(
                    color: white60, borderRadius: BorderRadius.circular(30)),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(widget.title,
                    textAlign: TextAlign.center, style: subtitle2White),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ...List.generate(
              menu.length,
              (index) => InkWell(
                onTap: () {
                  _panelController.close().whenComplete(
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ContainPageCrypto(
                              value:
                                  widget.value == null ? price : widget.value,
                              subValue: widget.subValue == null
                                  ? chng
                                  : widget.subValue,
                              currencyChart: widget.currencychart,
                              title: widget.title,
                              
                              defaultWidget: menu[index],
                              query: query,
                              articles: articles,
                            ),
                          ),
                        ),
                      );
                },
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  child: new Text(menu[index], style: subtitle1White),
                ),
              ),
            )
          ],
        ),
        body: Scaffold(
          // backgroundColor: kindaWhite,
          appBar: AppbarWithShare(
            showShare: false,
            isSaved: checkIsSaved,
            onSaved: () async {
              var db = context.read(storageServicesProvider);
              await db.updateCryptoWatchlist(widget.filter);
              BotToast.showText(
                  contentColor: almostWhite,
                  textStyle: TextStyle(color: black),
                  text: "Added to Watchlist");
            },
            delSaved: () async {
              print("removing...");
              var db = context.read(storageServicesProvider);
              await db.removeCryptoWatchlist([widget.filter]);
              BotToast.showText(
                  contentColor: almostWhite,
                  textStyle: TextStyle(color: black),
                  text: "Removed from Watchlist");
            },
          ),
          body: widget.isSearch == true && price == null
              ? LoadingPage()
              : Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            widget.top != null
                                ? widget.top
                                : Center(
                                    child: Text(widget.title,
                                        textAlign: TextAlign.center,
                                        style: headline6)),
                            widget.mid != null ? widget.mid : Container(),
                            SizedBox(
                                height: (widget.expiryDate != null) ? 15 : 0),
                            (widget.expiryDate != null)
                                ? Center(
                                    child: Text(widget.expiryDate,
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: almostWhite,
                                            fontWeight: FontWeight.w600)))
                                : SizedBox(),
                            (widget.expiryDate != null)
                                ? Center(
                                    child: Text(
                                      'Expiry date',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: white60,
                                      ),
                                    ),
                                  )
                                : SizedBox(),
                            SizedBox(
                              height: 100,
                            ),
                            if (widget.isSearch == false)
                              widget.end != null
                                  ? widget.end
                                  : Center(
                                      child: Text(widget.value,
                                          style: headline5White)),
                            if (widget.isSearch == true)
                              Center(
                                  child: Text(
                                price ?? '',
                                style: headline5White,
                              )),
                            if (widget.isSearch == false)
                              widget.end != null
                                  ? Container()
                                  : Center(
                                      child: Text(
                                        widget.subValue,
                                        style: bodyText2.copyWith(
                                            color: widget.subValue[0] == '-'
                                                ? red
                                                : blue),
                                      ),
                                    ),
                            if (widget.isSearch == true && chng != null)
                              Center(
                                child: Text(
                                  chng ?? '',
                                  style: bodyText2.copyWith(
                                      color: chng.contains('-') ? red : blue),
                                ),
                              ),
                          ],
                        ),
                        // if (widget.isSearch == false)
                        SizedBox(
                          height:
                              (widget.expiryDate != null || widget.end != null)
                                  ? 80
                                  : 128,
                        ),
                        Center(
                          child: InkWell(
                            onTap: () {
                              _panelController.open();
                            },
                            child: 
                            // Hero(
                            //   tag: "explore",
                            //   child: 
                              Material(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(12),
                                child: Container(
                                  padding: EdgeInsets.all(12),
                                  width: 240,
                                  height: 48,
                                  decoration: BoxDecoration(
                                      color: Colors.white12,
                                      borderRadius: BorderRadius.circular(6)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/icons/explore.svg',
                                        color: almostWhite,
                                      ),
                                      Text("   Explore", style: buttonWhite),
                                      Flexible(
                                        child: Container(),
                                      ),
                                      Icon(
                                        CupertinoIcons.forward,
                                        color: almostWhite,
                                        //size: 30,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          // ),
                        )
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
