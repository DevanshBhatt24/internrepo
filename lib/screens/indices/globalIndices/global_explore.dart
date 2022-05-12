import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
//import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:technical_ind/components/LoadingPage.dart';

import 'package:technical_ind/components/containPage.dart';
import 'package:technical_ind/providers/storageProviders.dart';
import 'package:technical_ind/screens/News/broadcastPage.dart';
import 'package:technical_ind/screens/News/business/model.dart';
import 'package:technical_ind/screens/News/business/newsServices.dart';
import 'package:technical_ind/screens/commodity/historycommo.dart';
import 'package:technical_ind/screens/cryptocurrency/indicatorsPage.dart';
import 'package:technical_ind/screens/indices/globalIndices/globalIndices.dart';
import 'package:technical_ind/styles.dart';
import 'package:technical_ind/widgets/appbar_with_bookmark_and_share.dart';
import '../../chartScreen.dart';
import '../business/global_overview_model.dart';
import 'globalIndicesComponents.dart';
import '../business/indices_services.dart';
import 'globalOverview.dart';

class ExplorePageGlobal extends StatefulWidget {
  final List<String> menu;
  final String title, value, subValue;
  final Widget top, mid, end;
  final String expiryDate;
  final double defaultheight;
  final bool isSearch;

  ExplorePageGlobal(
      {Key key,
      this.isSearch = false,
      this.menu,
      this.title,
      this.value,
      this.subValue,
      this.expiryDate,
      this.top,
      this.mid,
      this.end,
      this.defaultheight = 80})
      : super(key: key);

  @override
  _ExplorePageGlobalState createState() => _ExplorePageGlobalState();
}

class _ExplorePageGlobalState extends State<ExplorePageGlobal> {
  PanelController _panelController = new PanelController();
  List<String> menu;
  GobalOverview gobalOverview;
  // bool loading = true;

  var jsonText;

  List<GlobalIcon> globalIcons;
  String code = "";
  String countryName = "";
  String price = "";
  String chng = "";
  String chngPercentage = "";
  String query;
  _loadData() async {
    jsonText =
        await rootBundle.loadString('assets/instrument/globalIndices.json');
    globalIcons = globalIconFromJson(jsonText);

    for (var ele in globalIcons) {
      if (ele.globalIndicesName == widget.title.replaceAll('derived', '')) {
        setState(() {
          code = ele.countryCode;
          countryName = ele.countryName;
        });
      }
    }

    final response = await IndicesServices.getSearchGlobal(widget.title);
    setState(() {
      price = response["price"];
      chng = response["price_change"];
      chngPercentage = response["price_change_percentage"];
    });
  }

  _fetchApidata() async {
    // gobalOverview = await IndicesServices.getGlobalOverview(
    //     widget.title.replaceAll('&', 'and'));
    if (widget.isSearch == true) {
      _loadData();
    }
  }

  Future<bool> checkIsSaved() async {
    print("checking saved...");
    var user = context.read(firestoreUserProvider);
    if (user.containsKey('GlobalIndicesWatchlist')) {
      List<dynamic> globalwatchlist = user['GlobalIndicesWatchlist'];

      return globalwatchlist.contains(query);
    }
    return false;
  }

  List<Article> articles = [];

  void getArticles(String title) async {
    articles = await NewsServices.getNewsFromQuery(title).whenComplete(() {
      setState(() {});
    });
  }

  @override
  void initState() {
    query = widget.title.replaceAll('&', 'and');
    super.initState();
    menu = widget.menu;
    _fetchApidata();
    // getArticles(widget.title.replaceAll('derived', ''));
  }

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
                child: Text(widget.title.replaceAll('derived', ''),
                    textAlign: TextAlign.center, style: subtitle2White),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ...List.generate(
              widget.menu.length,
              (index) => InkWell(
                onTap: () {
                  _panelController.close().whenComplete(
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ContainPage(
                              menu: menu,
                              menuWidgets: [
                                GlobalOverview(
                                  query: query,
                                   price: widget.isSearch
                                            ? price
                                            : widget.value,
                                        chng: widget.isSearch
                                            ? chng+chngPercentage
                                            : widget.subValue,
                                  // overview: gobalOverview.overview,
                                ),
                                ChartScreen(
                                  isIndice: true,
                                  companyName: widget.title,
                                  isUsingWeb: true,
                                  presentInSymbols: true,
                                ),
                                GlobalIndicesCompoments(
                                  query: query,
                                  // component: gobalOverview.components,
                                ),
                                IndicatorPage(
                                  query: query,
                                  isGlobalIndices: true,
                                  // indicator: gobalOverview.technicalIndicator,
                                ),
                                HistoryPageCommodity(
                                  query: query,
                                  isGlobalIndices: true,
                                  // historicalData: gobalOverview.historicalData,
                                ),
                                NewsWidget(
                                  isGlobal: true,
                                  title: widget.title,
                                ),
                              ],
                              title: widget.title.replaceAll('derived', ''),
                              defaultWidget: menu[index],
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
            ),
          ],
        ),
        body: Scaffold(
          // backgroundColor: kindaWhite,
          appBar: query != null
              ? AppbarWithShare(
                  showShare: false,
                  isSaved: checkIsSaved,
                  onSaved: () async {
                    var db = context.read(storageServicesProvider);
                    await db.updateGlobalIndicesWatchlist(query);
                    BotToast.showText(
                        contentColor: almostWhite,
                        textStyle: TextStyle(color: black),
                        text: "Added to Watchlist");
                  },
                  delSaved: () async {
                    print("removing...");
                    var db = context.read(storageServicesProvider);
                    await db.removeGlobalIndicesWatchlist([query]);
                    BotToast.showText(
                        contentColor: almostWhite,
                        textStyle: TextStyle(color: black),
                        text: "Removed from Watchlist");
                  },
                )
              : null,
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
                                  child: Text(
                                      widget.title.replaceAll('derived', ''),
                                      textAlign: TextAlign.center,
                                      style: headline6)),
                          widget.mid != null ? widget.mid : Container(),
                          widget.isSearch == true
                              ? Column(
                                  children: [
                                    SizedBox(height: 12),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 11,
                                          width: 20,
                                          child: Image.asset(
                                              'icons/flags/png/${code.toLowerCase()}.png',
                                              package: 'country_icons'),
                                        ),
                                        Container(
                                          child: Text('  ' + countryName,
                                              style: bodyText2White),
                                        )
                                      ],
                                    )
                                  ],
                                )
                              : Container(),
                          SizedBox(
                              height: (widget.expiryDate != null) ? 15 : 0),
                          (widget.expiryDate != null)
                              ? Center(
                                  child: Text(
                                    widget.expiryDate,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: almostWhite,
                                        fontWeight: FontWeight.w600),
                                  ),
                                )
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
                          widget.end != null
                              ? widget.end
                              : Center(
                                  child: Text(
                                      widget.isSearch == false
                                          ? widget.value
                                          : price,
                                      style: headline5White)),
                          if (widget.isSearch == true)
                            if (chng != "")
                              Center(
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                    Text(chng,
                                        style: bodyText2.copyWith(
                                          color: chng[0] == '-' ? red : blue,
                                        )),
                                    Text('(' + chngPercentage + ')',
                                        style: bodyText2.copyWith(
                                          color: chngPercentage[0] == '-'
                                              ? red
                                              : blue,
                                        ))
                                  ])),
                          if (widget.isSearch == false)
                            Center(
                                child: Text(
                              widget.subValue,
                              style: bodyText2.copyWith(
                                color: widget.subValue[0] == '-' ? red : blue,
                              ),
                            )),
                        ],
                      ),
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
                        ),
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
