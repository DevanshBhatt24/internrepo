import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:technical_ind/components/LoadingPage.dart';
import 'package:technical_ind/providers/storageProviders.dart';
import 'package:technical_ind/screens/cryptocurrency/business/crypto_list_model.dart';
import 'package:technical_ind/screens/cryptocurrency/business/crypto_services.dart';
import 'package:technical_ind/screens/cryptocurrency/explorecrypto.dart';
import 'package:technical_ind/screens/watchlist/emptyWatchlist.dart';

import '../../providers/navBarProvider.dart';
import '../../styles.dart';

class CryptoW extends StatefulWidget {
  final String title;

  CryptoW({Key key, this.title}) : super(key: key);

  @override
  _CryptoWState createState() => _CryptoWState();
}

class _CryptoWState extends State<CryptoW> {
  List<int> _selectedList = [];

  Widget comp(String query, String chg, String name, String price) {
    // String shortName;
    // if (name != null) {
    //   shortName = name.split(' ')[0];
    // }
    return name != null
        ? InkWell(
            onTap: () {
              print("crypto");
              String iconName = name[0].toUpperCase() + name.substring(1);
              String finaliconName = iconName.split(' ')[0];
              pushNewScreen(
                context,
                withNavBar: false,
                screen: ExplorePageCrypto(
                  top: SvgPicture.asset(
                    'assets/icons/$finaliconName.svg',
                    height: 50,
                    width: 50,
                  ),
                  mid: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      finaliconName,
                      style: headline6,
                    ),
                  ),
                  isSearch: true,
                  filter: query,
                  title: finaliconName,
                ),
              );
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
                  Flexible(
                      child: Text(
                    name ?? '',
                    style: bodyText1white,
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                  )),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        price ?? '',
                        style: bodyText2White,
                        textAlign: TextAlign.right,
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                      ),
                      if (chg != null && chg != "")
                        Row(children: [
                          Text(
                            chg,
                            style: bodyText2AnyColour.copyWith(
                              color: chg.contains('-') ? red : blue,
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

  List<dynamic> cryptoCodeList = [];
  List<CryptoWatch> crypto = null;

  _fetchApi() async {
    Map<String, dynamic> user = context.read(firestoreUserProvider);

    if (user.containsKey('CryptoWatchlist')) {
      cryptoCodeList = user['CryptoWatchlist'];
    }

    List<CryptoWatch> tempList = [];
    // isinList.forEach((element) async {
    //   final response = await StockServices.watchStockDetail(element);
    //   print(response);
    // });

    for (var i in cryptoCodeList) {
      final response = await CryptoServices.watchCrypto(i);
      tempList.add(response);
    }

    print(tempList);

    setState(() {
      crypto = tempList;
    });
    _refreshController.refreshCompleted();
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchApi();
  }

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
      body: crypto == null
          ? LoadingPage()
          : crypto.isEmpty
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
                  ))
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
                      itemCount: cryptoCodeList.length,
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
                                      cryptoCodeList[index],
                                      crypto[index].chng,
                                      crypto[index].name,
                                      crypto[index].price)
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
    // return EmptyWatchlist(
    //   title: widget.title,
    // );
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

                    await db.removeCryptoWatchlist(
                        _selectedList.map((e) => cryptoCodeList[e]).toList());

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
                      action: SnackBarAction(
                        label: "Undo",
                        textColor: blue,
                        onPressed: () {},
                      ),
                    );
                    Navigator.of(context).pop();
                    List<CryptoWatch> a = [];

                    for (var _crypto in crypto) {
                      if (!_selectedList.contains(crypto.indexOf(_crypto))) {
                        a.add(_crypto);
                        print(_crypto.name);
                      }
                    }
                    crypto = a;
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

                    context.read(navBarVisibleProvider).setNavbarVisible(false);
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

  Container _emptyView() {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/startIcons/${widget.title}.svg",
            height: 130,
            width: 130,
          ),
          SizedBox(
            height: 24,
          ),
          Text(
            "Experience Investing",
            style: subtitle1White,
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            "Watchlist helps you experience investing by\nallowing you to add ${widget.title} and track their\nperformance over time.",
            style: bodyText2White60,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 48,
          ),
          Container(
            height: 40,
            width: 220,
            decoration: BoxDecoration(
                color: darkGrey, borderRadius: BorderRadius.circular(6)),
            child: Center(
              child: Text(
                "Search ${widget.title}",
                style: buttonWhite.copyWith(color: blue),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
