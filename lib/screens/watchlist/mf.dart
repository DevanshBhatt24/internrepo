import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:marquee_text/marquee_text.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:technical_ind/components/LoadingPage.dart';
import 'package:technical_ind/providers/navBarProvider.dart';
import 'package:technical_ind/providers/storageProviders.dart';
import 'package:technical_ind/screens/mutual/summary.dart';
import 'package:technical_ind/screens/watchlist/emptyWatchlist.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../styles.dart';

class MfW extends StatefulWidget {
  final String title;

  MfW({Key key, this.title}) : super(key: key);

  @override
  _MfWState createState() => _MfWState();
}

class _MfWState extends State<MfW> {
  List<int> _selectedList = [];

  Widget comp(title, id) {
    int _id = int.parse(id);
    return title != null
        ? InkWell(
            onTap: () {
              pushNewScreen(context,
                  screen: Summary(
                    title: title,
                    // latestNav: dataList[index]
                    //     .latestNav
                    //     .toString(),
                    code: _id,
                    isWatchlist: true,
                  ),
                  withNavBar: false);
            },
            child: Container(
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.symmetric(vertical: 4),
              color: darkGrey,
              // height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                      child: MarqueeText(
                          text: title ?? '', style: bodyText1white, speed: 10)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(" ",
                          style: bodyText2White, textAlign: TextAlign.right),
                      Row(children: [
                        Text(
                          " ",
                          style: bodyText2AnyColour,
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

  List<dynamic> mfCodeList;
  // List<FundWatchModel> mf = null;

  _fetchApi() async {
    Map<String, dynamic> user = context.read(firestoreUserProvider);

    if (user.containsKey('MutualWatchlist')) {
      mfCodeList = user['MutualWatchlist'];
    } else {
      mfCodeList = [];
    }

    // List<FundWatchModel> tempList = [];

    // for (var i in mfCodeList) {
    //   final response = await FundsService.watchMutual(i);
    //   tempList.add(response);
    // }

    // print(tempList);

    // setState(() {
    //   mf = tempList;
    // });
    setState(() {});
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
      body: mfCodeList == null
          ? LoadingPage()
          : mfCodeList.isEmpty
              ? SmartRefresher(
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
                      itemCount: mfCodeList.length,
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
                                    mfCodeList[index]["title"],
                                    mfCodeList[index]["id"],
                                  )),
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

                    await db.removeMutualWatchlist(
                        _selectedList.map((e) => mfCodeList[e]).toList());

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
}
