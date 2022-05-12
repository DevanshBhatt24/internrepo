import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:technical_ind/components/containPage.dart';
import 'package:technical_ind/screens/chartScreen.dart';
import 'package:technical_ind/screens/News/business/model.dart';
import 'package:technical_ind/screens/News/business/newsServices.dart';
import 'commodityindicator.dart';
import 'package:technical_ind/screens/cryptocurrency/newsPage.dart';
import 'historycommo.dart';
import 'package:technical_ind/styles.dart';
import 'package:technical_ind/widgets/appbar_with_bookmark_and_share.dart';
import 'business/commodity_services.dart';
import 'business/commodity_overview_model.dart';
import 'overviewComodity.dart';

class ExplorePageCommodity extends StatefulWidget {
  final List<String> menu;
  final String title, value, subValue, commodityname;
  final Widget top, mid, end;
  final String expiryDate;
  final double defaultheight;
  final bool isMcx;

  ExplorePageCommodity(
      {Key key,
      this.commodityname,
      this.menu,
      this.title,
      this.value,
      this.subValue,
      this.expiryDate,
      this.top,
      this.mid,
      this.end,
      this.defaultheight = 80,
      this.isMcx})
      : super(key: key);

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePageCommodity> {
  PanelController _panelController = new PanelController();
  List<String> menu;

  CommodityOverviewModel commodityOverviewModel;
  bool loading = true;

  _fetchApiData() async {
    commodityOverviewModel =
        await CommodityServices.getCommodityOverviewList(widget.commodityname);
    setState(() {
      loading = false;
    });
  }

  List<Article> articles = [];

  void getArticles(String title) async {
    articles = await NewsServices.getNewsFromQuery(title).whenComplete(() {
      setState(() {});
    });
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
                child: Text(widget.title,
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
                                OverviewCommodity(
                                  overview: commodityOverviewModel.overview,
                                ),
                                ChartScreen(
                                  isCommodity: true,
                                  companyName: widget.title,
                                  isUsingWeb: true,
                                  presentInSymbols: false,
                                  showToastMsg:
                                      "Prices are shown in USD as INR prices are not available currently.",
                                ),
                                IndicatorPageCommodity(
                                  indicator:
                                      commodityOverviewModel.technicalIndicator,
                                ),
                                HistoryPageCommodity(
                                    // historicalData:
                                    //     commodityOverviewModel.historicalData,
                                    ),
                                NewsPage(
                                  articles: articles,
                                ),
                              ],
                              title: widget.title,
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
            )
          ],
        ),
        body: Scaffold(
          // backgroundColor: kindaWhite,
          appBar: AppbarWithShare(
            showShare: false,
          ),
          body: Container(
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
                                textAlign: TextAlign.center, style: headline6)),
                    widget.mid != null ? widget.mid : Container(),
                    SizedBox(height: (widget.expiryDate != null) ? 15 : 0),
                    (widget.expiryDate != null)
                        ? Center(
                            child: Text(
                              widget.expiryDate,
                              style: TextStyle(
                                fontSize: 16,
                                color: almostWhite,
                                fontWeight: FontWeight.w600,
                              ),
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
                            child: Text(widget.value, style: headline5White)),
                    widget.end != null
                        ? Container()
                        : Center(
                            child: Text(
                              widget.subValue,
                              style: bodyText2.copyWith(
                                  color:
                                      widget.subValue[0] == '-' ? red : blue),
                            ),
                          ),
                  ],
                ),
                SizedBox(
                  height: (widget.expiryDate != null || widget.end != null)
                      ? 80
                      : 128,
                ),
                Center(
                  child: InkWell(
                    onTap: () {
                      if (loading == false) _panelController.open();
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
                              loading
                                  ? Container(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : Icon(
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

  @override
  void initState() {
    super.initState();
    menu = widget.menu;
    _fetchApiData();
    getArticles(widget.isMcx ? 'MCX ' + widget.title : 'NCDEX ' + widget.title);
  }
}
