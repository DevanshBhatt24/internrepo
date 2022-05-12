import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:technical_ind/components/LoadingPage.dart';
import 'package:technical_ind/components/containPage.dart';
import 'package:technical_ind/providers/storageProviders.dart';
import 'package:technical_ind/screens/News/broadcastPage.dart';
import 'package:technical_ind/screens/chartScreen.dart';
import 'package:technical_ind/screens/News/business/model.dart';
import 'package:technical_ind/screens/News/business/newsServices.dart';
import 'package:technical_ind/screens/cryptocurrency/historyPage.dart';
import 'package:technical_ind/screens/forex/business/services.dart';
import 'package:technical_ind/screens/forex/indicatorpageforex.dart';
import 'package:technical_ind/styles.dart';
import 'package:technical_ind/widgets/appbar_with_bookmark_and_share.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'business/forexExplore.dart';
import 'forex_overview.dart';

class ForexExplorePage extends StatefulWidget {
  final List<String> menu;
  final String code;
  final Color color;
  final String title, value, subValue, filter;
  final Widget top, mid, end;
  final String expiryDate, currencychart;
  final double defaultheight;
  final change;
  final changePercentage;
  final price;
  final bool isSearch;

  ForexExplorePage(
      {Key key,
      this.change,
      this.isSearch = false,
      this.changePercentage,
      this.price,
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
      this.defaultheight = 80,
      this.menu,
      this.code,
      this.color})
      : super(key: key);

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ForexExplorePage> {
  List<Article> articles = [];

  String price = "";
  String chng = "";
  String chngPercentage = "";

  void getArticles(String title) async {
    articles = await NewsServices.getNewsFromQuery(title).whenComplete(() {
      setState(() {});
    });
  }

  Future<bool> checkIsSaved() async {
    print("checking saved...");
    var user = context.read(firestoreUserProvider);
    if (user.containsKey('ForexWatchlist')) {
      List<dynamic> stockwatchlist = user['ForexWatchlist'];

      return stockwatchlist.contains(widget.code);
    }
    return false;
  }

  ForexExplore forexModel;
  _fetchAPI() async {
    if (widget.isSearch == false) {
      // forexModel = await ForexServices.forexExplore(widget.code);
    } else {
      // forexModel = await ForexServices.forexExplore(widget.code);
      final response = await ForexServices.searchForex(widget.code);
      setState(() {
        price = response["price"];
        chng = response["change"];
        chngPercentage = "(" + response["change_percent"] + ")";
      });
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    menu = widget.menu;
    _fetchAPI();
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
                        color: white60,
                        borderRadius: BorderRadius.circular(30)),
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
                      _panelController
                          .close()
                          .whenComplete(() => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ContainPage(
                                          menu: menu,
                                          menuWidgets: [
                                            ForexOverviewPage(
                                              query: widget.code,
                                              price: widget.isSearch
                                                  ? price
                                                  : widget.price,
                                              chng: widget.isSearch
                                                  ? chng
                                                  : widget.change,
                                              chngPercentage: widget.isSearch
                                                  ? chngPercentage
                                                  : widget.changePercentage,
                                            ),
                                            ChartScreen(
                                              isForex: true,
                                              companyName: widget.title,
                                            ),
                                            IndicatorPageForex(
                                              query: widget.code,
                                            ),
                                            HistoryPage(
                                              isForex: true,
                                              isin: widget.code,
                                              // historicalData:
                                              //     forexModel.historicalData,
                                            ),
                                            NewsWidget(
                                              isForex: true,
                                              title: widget.title,
                                            ),
                                          ],
                                          title: widget.title,
                                          defaultWidget: menu[index],
                                        )),
                              ));
                    },
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
                  await db.updateForexWatchlist(widget.code);
                  BotToast.showText(
                      contentColor: almostWhite,
                      textStyle: TextStyle(color: black),
                      text: "Added to Watchlist");
                },
                delSaved: () async {
                  print("removing...");
                  var db = context.read(storageServicesProvider);
                  await db.removeForexWatchlist([widget.code]);
                  BotToast.showText(
                      contentColor: almostWhite,
                      textStyle: TextStyle(color: black),
                      text: "Removed from Watchlist");
                },
              ),
              body: widget.isSearch == true && price == ""
                  ? LoadingPage()
                  : Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              // SizedBox(
                              //   height: 165,
                              // ),
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
                              // forexModel == null
                              //     ? CircularProgressIndicator(
                              //         color: Colors.white,
                              //         strokeWidth: 2,
                              //       )
                              //     : Center(
                              //         child: Text(forexModel.overview.price,
                              //             style: headline5White)),
                              // if (forexModel != null)
                              if (widget.isSearch == false)
                                Center(
                                    child: Text(widget.price,
                                        style: headline5White)),
                              if (widget.isSearch == true)
                                Center(
                                    child: Text(price, style: headline5White)),
                              // forexModel == null
                              //     ? Container()
                              //     : Center(
                              //         child: Text(
                              //             "${forexModel.overview.change} (${forexModel.overview.changePercent})",
                              //             style: bodyText2.copyWith(
                              //                 color:
                              //                     forexModel.overview.change[0] != '-'
                              //                         ? blue
                              //                         : red))),
                              // if (forexModel != null)
                              if (widget.isSearch == false)
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("${widget.change}",
                                          style: bodyText2.copyWith(
                                              color: widget.change[0] != '-'
                                                  ? blue
                                                  : red)),
                                      Text("${widget.changePercentage}",
                                          style: bodyText2.copyWith(
                                              color: widget.change[0] != '-'
                                                  ? blue
                                                  : red)),
                                    ]),
                              if (widget.isSearch == true && chng != "")
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(chng,
                                          style: bodyText2.copyWith(
                                              color:
                                                  chng[0] != '-' ? blue : red)),
                                      Text(chngPercentage,
                                          style: bodyText2.copyWith(
                                              color: chngPercentage[1] != '-'
                                                  ? blue
                                                  : red)),
                                    ]),
                            ],
                          ),
                          SizedBox(
                            height: (widget.expiryDate != null ||
                                    widget.end != null)
                                ? 80
                                : 128,
                          ),
                          Center(
                            child: InkWell(
                              onTap: () {
                                _panelController.open();
                              },
                              child: Hero(
                                tag: "explore",
                                child: Material(
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
            )));
  }
}
