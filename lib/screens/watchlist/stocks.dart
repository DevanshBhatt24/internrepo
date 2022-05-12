import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:horizontal_data_table/refresh/pull_to_refresh/pull_to_refresh.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:technical_ind/components/LoadingPage.dart';
import 'package:technical_ind/providers/navBarProvider.dart';
import 'package:technical_ind/providers/storageProviders.dart';
import 'package:technical_ind/screens/stocks/business/models/allStockResponse.dart';
import 'package:technical_ind/screens/stocks/business/stockServices.dart';
import 'package:technical_ind/screens/stocks/explore/home.dart';
import '../../styles.dart';
import 'emptyWatchlist.dart';

class StocksW extends StatefulWidget {
  final String title;

  StocksW({Key key, this.title}) : super(key: key);

  @override
  _StocksWState createState() => _StocksWState();
}

class _StocksWState extends State<StocksW> {
  List<int> _selectedList = [];
  List<dynamic> isinList = [];

  var crossAxisCount;

  _fetchApi() async {
    Map<String, dynamic> user = context.read(firestoreUserProvider);

    if (user.containsKey('StocksWatchlist')) {
      isinList = user['StocksWatchlist'];
    }

    List<Stock> tempList = [];
    // isinList.forEach((element) async {
    //   final response = await StockServices.watchStockDetail(element);
    //   print(response);
    // });

    for (var i in isinList) {
      final response = await StockServices.watchStockDetail(i);
      tempList.add(response);
    }

    print(tempList);

    setState(() {
      stocks = tempList;
    });
    _refreshController.refreshCompleted();
  }

  List<Stock> stocks = null;
  @override
  void initState() {
    super.initState();
    _fetchApi();
  }

  Widget comp(
      String chg, String chgpercent, String name, String price, String isin) {
    return name != null
        ? InkWell(
            onTap: () {
              pushNewScreen(context,
                  withNavBar: false,
                  screen: Homepage(
                    name: name,
                    isin: isin,
                  ));
            },
            child: Container(
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.symmetric(vertical: 4),
              color: darkGrey,
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(child: Text(name ?? '', style: bodyText1white)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(price ?? '',
                          style: bodyText2White, textAlign: TextAlign.right),
                      if (chg != null && chg != "")
                        Row(children: [
                          Text(
                            chg,
                            style: bodyText2AnyColour.copyWith(
                                color: chg.contains('-') ? red : blue),
                            textAlign: TextAlign.right,
                          ),
                          Text(
                            chgpercent,
                            style: bodyText2AnyColour.copyWith(
                              color: chgpercent.contains("-") ? red : blue,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ])
                    ],
                  )
                ],
              ),
            ),
          )
        : SizedBox();
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _selectedList.isNotEmpty
          ? Container(
              margin: EdgeInsets.only(bottom: 70),
              height: 56,
              child: ListTile(
                leading: IconButton(
                  icon: SvgPicture.asset("assets/icons/delete.svg"),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => deleteDialog(context));
                  },
                ),
                title: Text(
                  _selectedList.length.toString() + ' Selected',
                  style: buttonWhite,
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.close,
                    color: red,
                  ),
                  onPressed: () {
                    setState(() {
                      _selectedList.clear();
                    });
                  },
                ),
              ),
            )
          : SizedBox(
              height: 0,
            ),
      body: stocks == null
          ? LoadingPage()
          : stocks.isEmpty
              ? SmartRefresher(
                  controller: _refreshController,
                  enablePullDown: true,
                  enablePullUp: false,
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
                  onRefresh: () => _fetchApi(),
                  child: EmptyWatchlist(
                    title: widget.title,
                  ),
                )
              : Container(
                  child: SmartRefresher(
                    onRefresh: () => _fetchApi(),
                    controller: _refreshController,
                    enablePullDown: true,
                    enablePullUp: false,
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
                    child: ListView.builder(
                      itemCount: isinList.length,
                      itemBuilder: (BuildContext context, int index) =>
                          Container(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        height: 80,
                        child: Stack(
                          children: [
                            InkWell(
                              onTap: _selectedList.isNotEmpty
                                  ? () {
                                      setState(() {
                                        _selectedList.contains(index)
                                            ? _selectedList.remove(index)
                                            : _selectedList.add(index);
                                      });
                                    }
                                  : null,
                              onLongPress: () {
                                setState(() {
                                  _selectedList.add(index);
                                });
                              },
                              child: IgnorePointer(
                                  ignoring: _selectedList.isNotEmpty,
                                  child: comp(
                                      stocks[index]?.change,
                                      stocks[index]?.changePercentage,
                                      stocks[index]?.name,
                                      stocks[index]?.lastPrice,
                                      stocks[index]?.isin)
                                  // child: ListTile(
                                  //   title: Text(isinList[index]),
                                  // ),
                                  ),
                            ),
                            Positioned(
                                top: 5,
                                left: 5,
                                child: Visibility(
                                  visible: _selectedList.isNotEmpty,
                                  child: Icon(Icons.check_circle,
                                      size: 18,
                                      color: _selectedList.contains(index)
                                          ? blue
                                          : white38),
                                ))
                          ],
                        ),
                      ),
                      // staggeredTileBuilder: (int index) {
                      //   return StaggeredTile.count(2, 0.45);
                      // },
                      // mainAxisSpacing: 8,
                      // crossAxisSpacing: 8,
                    ),
                  ),
                ),
    );
  }

  AlertDialog deleteDialog(BuildContext context) {
    return AlertDialog(
      backgroundColor: darkGrey,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      contentPadding: EdgeInsets.symmetric(vertical: 38, horizontal: 12),
      content: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Do you want to remove " +
                  _selectedList.length.toString() +
                  " selected items ?",
              textAlign: TextAlign.center,
              style: subtitle1White,
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              "Selected items will be removed from your watchlist",
              textAlign: TextAlign.center,
              style: subtitle2White60,
            ),
            SizedBox(
              height: 48,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () async {
                    var db = context.read(storageServicesProvider);

                    await db.removeStockWatchlistFromList(
                        _selectedList.map((e) => isinList[e]).toList());

                    SnackBar s = SnackBar(
                      elevation: 6.0,
                      backgroundColor: grey,
                      behavior: SnackBarBehavior.floating,
                      content: Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: blue,
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Text(
                            "Removed from watchlist",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    );
                    Navigator.of(context).pop();
                    List<Stock> a = [];
                    for (var stock in stocks) {
                      if (!_selectedList.contains(stocks.indexOf(stock))) {
                        a.add(stock);
                        print(stock?.name);
                      }
                    }
                    stocks = a;
                    _selectedList.clear();
                    setState(() {});
                    ScaffoldMessenger.of(context).showSnackBar(
                      s,
                    );

                    context.read(navBarVisibleProvider).setNavbarVisible(false);
                    _fetchApi();
                  },
                  child: Container(
                    height: 48,
                    width: 220,
                    decoration: BoxDecoration(
                      color: red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    //color: blue,
                    child: Center(
                        child: Text(
                      "Remove",
                      style: buttonWhite,
                    )),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: 220,
                    height: 48,
                    decoration: BoxDecoration(
                      //color: blue,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    //color: blue,
                    child: Center(
                        child: Text(
                      "Cancel",
                      style: button.copyWith(color: red),
                    )),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Center noItems(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/icons/saved_articles.svg",
            height: 107,
            width: 93,
          ),
          SizedBox(
            height: 27,
          ),
          Text(
            "No Saved Pages Yet",
            style: GoogleFonts.ibmPlexSans(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.1,
                color: Color(0xFFFFFFFF)),
          ),
          SizedBox(height: 18),
          Text(
            "Tap on bookmark icon on article page and read it later .",
            style: GoogleFonts.ibmPlexSans(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.1,
                color: Color(0xFFFFFFFF)),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 8,
          ),
          SizedBox(height: 123),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Container(
              height: 48,
              width: 296,
              decoration: BoxDecoration(
                color: Color(0xFF007AFF),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Center(
                child: Text(
                  'Discover',
                  style: GoogleFonts.ibmPlexSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.1,
                      color: Color(0xFFFFF6F6)),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
