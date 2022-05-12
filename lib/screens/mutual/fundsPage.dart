import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:rating_bar/rating_bar.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:technical_ind/components/LoadingPage.dart';
import 'package:technical_ind/screens/mutual/business/fundsservices.dart';
import 'package:technical_ind/screens/mutual/business/mutualfunds.dart';
import 'package:technical_ind/screens/mutual/summary.dart';

import '../../components/flatTile.dart';
import '../../providers/navBarProvider.dart';
import '../../styles.dart';
import '../../widgets/appbar_with_back_and_search.dart';
import 'mutualExplore.dart';

class FundsPage extends StatefulWidget {
  final String title, code;

  FundsPage({Key key, this.title, this.code}) : super(key: key);

  @override
  _FundsPageState createState() => _FundsPageState();
}

class _FundsPageState extends State<FundsPage> {
  int _selected;

  PanelController _panelController = new PanelController();
  List<String> menu = [
    "1 Month",
    "3 Month",
    "6 Month",
    "1 Year",
    "3 Years",
    "5 Years",
  ];
  List<String> titleRow = [
    "Returns (%)",
    "Fund Size (cr)",
    "Expense Ratios (%)",
    // "Risk Rating",
  ];

  ScrollController _scrollController = ScrollController();
  int page = 1;
  // MutualFund mutualFundDetails;

  List<String> valueRow = ["14.84 %", "58.30 %", "58.30 %"];
  List<Fund> dataList = [];
  _fetchApi() async {
    dataList = await FundsService.funds(widget.code, '$page');

    setState(() {});
  }

  _getMoreData() async {
    if (page <= 30) {
      setState(() {
        page++;
      });
      List<Fund> tempdataList = await FundsService.funds(widget.code, '$page');
      dataList.addAll(tempdataList);
      setState(() {});
    }
  }

  @override
  void initState() {
    _selected = menu.indexOf("1 Year");
    _fetchApi();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMoreData();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: dataList.isNotEmpty
            ? SlidingUpPanel(
                controller: _panelController,
                color: const Color(0xff1c1c1e),
                defaultPanelState: PanelState.CLOSED,
                backdropEnabled: true,
                minHeight: 0,
                maxHeight: 80.0 + menu.length * 48,
                onPanelClosed: () {
                  context.read(navBarVisibleProvider).setNavbarVisible(false);
                },
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18),
                    topRight: Radius.circular(18)),
                panel: Column(
                  children: [
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(top: 8),
                        width: 38,
                        height: 4,
                        decoration: BoxDecoration(
                            color: white60,
                            borderRadius: BorderRadius.circular(30)),
                      ),
                    ),
                    // Center(
                    //   child: Text("Return",
                    //       style: subtitle2.copyWith(color: almostWhite)),
                    // ),
                    SizedBox(
                      height: 28,
                    ),
                    ...List.generate(
                      menu.length,
                      (index) => InkWell(
                        onTap: () {
                          _panelController.close().whenComplete(() {
                            setState(() {
                              _selected = index;
                            });
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14),
                          child: Row(
                            children: [
                              Container(
                                  width: 40,
                                  child: Icon(
                                    Icons.check,
                                    color: _selected == index
                                        ? almostWhite
                                        : Colors.transparent,
                                  )),
                              Text(
                                menu[index],
                                style: _selected == index
                                    ? subtitle1.copyWith(color: almostWhite)
                                    : subtitle1.copyWith(color: white38),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                body: Scaffold(
                    appBar: PreferredSize(
                      preferredSize: Size.fromHeight(110),
                      child: Column(
                        children: [
                          AppBarWithBack(text: widget.title
                              //height: 40,
                              ),
                          InkWell(
                            onTap: () {
                              context
                                  .read(navBarVisibleProvider)
                                  .setNavbarVisible(true);
                              _panelController.open();
                            },
                            child: Hero(
                              tag: "explore1",
                              child: Material(
                                color: Colors.transparent,
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 4),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 11),
                                  //height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: const Color(0xff1c1c1e),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Return - " + menu[_selected],
                                          style: button.copyWith(
                                              color: almostWhite)),
                                      Icon(
                                        Icons.expand_more,
                                        color: almostWhite,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    body: Column(
                      children: [
                        SizedBox(
                          height: 24,
                        ),
                        Expanded(
                          child: ListView.builder(
                            controller: _scrollController,
                            // itemExtent: 4000,
                            itemCount: dataList.length + 1,
                            itemBuilder: (BuildContext context, int index) {
                              if (index == dataList.length) {
                                return Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                );
                              }

                              dynamic returns = _selected == 0
                                  ? dataList[index].return1Month
                                  : _selected == 1
                                      ? dataList[index].return3Month
                                      : _selected == 2
                                          ? dataList[index].return6Month
                                          : _selected == 3
                                              ? dataList[index].return1Year
                                              : _selected == 4
                                                  ? dataList[index].return3Year
                                                  : _selected == 5
                                                      ? dataList[index]
                                                          .return5Year
                                                      : '-';
                              return InkWell(
                                onTap: () {
                                  pushNewScreen(context,
                                      // screen: MutualExplore(
                                      //   code: int.parse(dataList[index].id),
                                      //   title: dataList[index].name,
                                      //   rating: dataList[index].rating,
                                      //   latestnav: dataList[index].latestNav,
                                      // ),
                                      screen: Summary(
                                        title: dataList[index].name,
                                        latestNav: dataList[index]
                                            .latestNav
                                            .toString(),
                                        code: int.parse(dataList[index].id),
                                      ),
                                      withNavBar: false);
                                },
                                child: FlatTile(
                                  isMf: true,
                                  valueRow: [
                                    returns.toString(),
                                    dataList[index].size,
                                    dataList[index].expenseRatio.toString(),
                                    dataList[index].riskRating,
                                    dataList[index].latestNav.toString()
                                  ],
                                  titleRow: titleRow,
                                  midWidget: dataList[index].rating != "unrated"
                                      ? RatingBar.readOnly(
                                          initialRating: double.parse(
                                              dataList[index].rating),
                                          isHalfAllowed: true,
                                          halfFilledIcon: Icons.star_half,
                                          filledIcon: Icons.star,
                                          emptyIcon: Icons.star_border,
                                          filledColor: almostWhite,
                                          emptyColor: almostWhite,
                                          size: 20,
                                        )
                                      : Container(),
                                  title: dataList[index].name,
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: kBottomNavigationBarHeight,
                        ),
                      ],
                    )),
              )
            : LoadingPage(),
      ),
    );
  }
}
