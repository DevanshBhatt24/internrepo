import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:technical_ind/providers/storageProviders.dart';
import 'package:technical_ind/screens/News/broadcastPage.dart';
import 'package:technical_ind/screens/News/business/model.dart';
import 'package:technical_ind/screens/cryptocurrency/business/crypto_overview_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:technical_ind/widgets/appbar_with_bookmark_and_share.dart';
import '../../styles.dart';
import '../chartScreen.dart';
import 'historyPage.dart';
import 'indicatorsPage.dart';
import 'overviewPAge.dart';

class ContainPageCrypto extends StatefulWidget {
  final String query;
  // final List<String> menu;
  // final List<Widget> menuWidgets;
  final String title, defaultWidget, currencyChart, value, subValue;
  final double defaultheight;
  final List<Article> articles;
  final bool isList;

  ContainPageCrypto(
      {Key key,
      this.value,
      this.subValue,
      this.isList = false,
      this.currencyChart,
      this.query,
      this.title,
      this.defaultWidget,
      this.articles,
      this.defaultheight = 80})
      : super(key: key);

  @override
  _ContainPageState createState() => _ContainPageState();
}

class _ContainPageState extends State<ContainPageCrypto> {
  int _selected;

  PanelController _panelController = new PanelController();
  List<String> menu = [
    "Overview",
    "Charts",
    "Technical Indicators",
    // "Historical Data",
    "News",
  ];

  Future<bool> checkIsSaved() async {
    print("checking saved...");
    var user = context.read(firestoreUserProvider);
    if (user.containsKey('CryptoWatchlist')) {
      List<dynamic> cryptowatchlist = user['CryptoWatchlist'];

      return cryptowatchlist.contains(widget.query);
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [
      OverviewPage2(
        // value: widget.value,
        // subvalue: widget.subValue,
        query: widget.query + "-INR",
      ),
      ChartScreen(
        isCrypto: true,
        companyName: widget.title,
        isUsingWeb: true,
      ),
      IndicatorPage(
        isCrypto: true,
        query: widget.query,
        showBotToast: false,
      ),
      // HistoryPage(
      //   isCrypto: true,
      //   isin: widget.query,
      //   // historicalData: widget.cryptoOverviewModel.historicalData,
      // ),
      NewsWidget(
        isCrypto: true,
        title: widget.title,
      ),
    ];
    print(widget.title);
    return Material(
      child: SlidingUpPanel(
        controller: _panelController,
        color: const Color(0xff1c1c1e),
        defaultPanelState: PanelState.CLOSED,
        backdropEnabled: true,
        minHeight: 0,
        maxHeight: widget.defaultheight + menu.length * 48,
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
            // Center(
            //   child: Text("Explore", style: subtitle2White),
            // ),
            ...List.generate(
                menu.length,
                (index) => InkWell(
                      onTap: () {
                        _panelController.close().whenComplete(() {
                          if (widgetList[index] != null)
                            setState(() {
                              _selected = index;
                            });
                        });
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        child: Row(
                          children: [
                            Container(
                                width: 24,
                                child: Icon(
                                  Icons.check,
                                  color: _selected == index
                                      ? almostWhite
                                      : Colors.transparent,
                                )),
                            SizedBox(
                              width: 16,
                            ),
                            Text(
                              menu[index],
                              style: subtitle1.copyWith(
                                color:
                                    _selected == index ? almostWhite : white38,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
          ],
        ),
        body: Scaffold(
          //backgroundColor: kindaWhite,

          appBar: PreferredSize(
            preferredSize: _selected == menu.indexOf("Charts")
                ? Size.fromHeight(56)
                : Size.fromHeight(112),
            child: Column(
              children: [
                !widget.isList
                    ? AppBar(
                        backgroundColor: Colors.black,
                        elevation: 0,
                        leading: IconButton(
                          icon: Icon(CupertinoIcons.back),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        title: Text(
                          widget.title,
                          style: headline6.copyWith(fontSize: 18),
                        ),
                      )
                    : Container(),
                widget.isList && widget.query != null
                    ? AppbarWithShare(
                        showShare: false,
                        showTitle: true,
                        title: widget.title,
                        isSaved: checkIsSaved,
                        onSaved: () async {
                          var db = context.read(storageServicesProvider);
                          await db.updateCryptoWatchlist(widget.query);
                          BotToast.showText(
                              contentColor: almostWhite,
                              textStyle: TextStyle(color: black),
                              text: "Added to Watchlist");
                        },
                        delSaved: () async {
                          print("removing...");
                          var db = context.read(storageServicesProvider);
                          await db.removeCryptoWatchlist([widget.query]);
                          BotToast.showText(
                              contentColor: almostWhite,
                              textStyle: TextStyle(color: black),
                              text: "Removed from Watchlist");
                        },
                      )
                    : Container(),
                _selected == menu.indexOf("Charts")
                    ? Container()
                    : InkWell(
                        onTap: () {
                          _panelController.open();
                        },
                        child: 
                        // Hero(
                        //   tag: "explore",
                        //   child: 
                          Material(
                            color: Colors.transparent,
                            child: Container(
                              margin:
                                  EdgeInsets.only(left: 16, right: 16, top: 6),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              //height: 40.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: const Color(0xff1c1c1e),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(menu[_selected], style: buttonWhite),
                                  Icon(
                                    Icons.expand_more,
                                    color: almostWhite,
                                  )
                                ],
                              ),
                            ),
                          ),
                        // ),
                      ),
              ],
            ),
          ),
          body: widgetList[_selected],
        ),
      ),
    );
  }

  @override
  void initState() {
    _selected = menu.indexOf(widget.defaultWidget);

    super.initState();
  }
}
