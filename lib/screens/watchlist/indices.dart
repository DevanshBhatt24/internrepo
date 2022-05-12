import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:marquee_text/marquee_text.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:technical_ind/components/LoadingPage.dart';
import 'package:technical_ind/providers/navBarProvider.dart';
import 'package:technical_ind/providers/storageProviders.dart';
import 'package:technical_ind/screens/indices/business/indices_global_model.dart';
import 'package:technical_ind/screens/indices/business/indices_services.dart';
import 'package:technical_ind/screens/indices/globalIndices/global_explore.dart';
import 'package:technical_ind/screens/indices/indices_explore.dart';
import 'package:technical_ind/screens/watchlist/emptyWatchlist.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:technical_ind/styles.dart';

class IndicesW extends StatefulWidget {
  final String title;
  final bool isIndian;

  IndicesW({Key key, this.title, this.isIndian}) : super(key: key);

  @override
  _IndiceWState createState() => _IndiceWState();
}

class _IndiceWState extends State<IndicesW> with TickerProviderStateMixin {
  List<int> _selectedList = [];

  List<dynamic> globalCodeList = [];
  List<dynamic> indianCodeList = [];
  List<GlobalIndiceWatchModel> indianIndice = null;
  List<GlobalIndiceWatchModel> globalIndice = null;

  _fetchApi() async {
    Map<String, dynamic> user = context.read(firestoreUserProvider);

    List<GlobalIndiceWatchModel> tempIndianList = [];
    List<GlobalIndiceWatchModel> tempGlobalList = [];
    if (user.containsKey('IndianIndicesWatchlist')) {
      indianCodeList = user['IndianIndicesWatchlist'];
    }
    for (var i in indianCodeList) {
      final response = await IndicesServices.watchIndian(i);
      tempIndianList.add(response);
    }
    indianIndice = tempIndianList;
    setState(() {});

    if (user.containsKey('GlobalIndicesWatchlist')) {
      globalCodeList = user['GlobalIndicesWatchlist'];
    }

    for (var i in globalCodeList) {
      final response = await IndicesServices.watchGlobal(i);
      tempGlobalList.add(response);
    }

    globalIndice = tempGlobalList;
    setState(() {});
    _refreshController.refreshCompleted();
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _controller = TabController(vsync: this, length: 2, initialIndex: 0);

    _fetchApi();
  }

  Widget comp(bool isIndian, String query, String chg, String name,
      String price, String changePercent) {
    // String shortName;
    // if (name != null) {
    //   shortName = name.split(' ')[0];
    // }
    return name != null
        ? InkWell(
            onTap: () {
              if (isIndian) {
                List<String> menu = [
                  'Overview',
                  'Charts',
                  'Stock Effect',
                  'Components',
                  'Technical Indicators',
                  'Historical Data',
                  'News'
                ];

                pushNewScreen(context,
                    withNavBar: false,
                    screen: ExplorePageIndices(
                      isSearch: true,
                      title: query,
                      mid: name.toLowerCase().contains('bse')
                          ? Text(
                              'BSE',
                              style: bodyText2White60,
                            )
                          : Text(
                              'NSE',
                              style: bodyText2White60,
                            ),
                      menu: menu,
                    ));
              } else {
                pushNewScreen(
                  context,
                  withNavBar: false,
                  screen: ExplorePageGlobal(
                    menu: [
                      'Overview',
                      'Charts',
                      'Components',
                      'Technical Indicators',
                      'Historical Data',
                      'News'
                    ],
                    isSearch: true,
                    title: query,
                  ),
                );
              }
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
                      child: MarqueeText(
                    text: TextSpan(text: name ?? ''),
                    style: bodyText1white,
                    speed: 10,
                  )),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(price ?? '',
                          style: bodyText2White, textAlign: TextAlign.right),
                      if (chg != null)
                        Row(children: [
                          Text(
                            chg,
                            style: bodyText2AnyColour.copyWith(
                              color: chg[0] != '-' ? blue : red,
                            ),
                            textAlign: TextAlign.right,
                          ),
                          if (changePercent != '')
                            Text(
                              isIndian == false
                                  ? '($changePercent)'
                                  : '$changePercent',
                              style: bodyText2AnyColour.copyWith(
                                color: changePercent.contains('-') ? red : blue,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          DefaultTabController(
            length: 2,
            initialIndex: 0,
            child: Column(
              children: [
                StickyHeader(
                  header: Material(
                    color: Colors.black,
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: TabBar(
                          // controller: _controller,
                          labelStyle: buttonWhite,
                          unselectedLabelColor: white38,
                          indicator: MaterialIndicator(
                            horizontalPadding: 30,
                            bottomLeftRadius: 8,
                            bottomRightRadius: 8,
                            color: Colors.white.withOpacity(0.87),
                            paintingStyle: PaintingStyle.fill,
                          ),
                          tabs: [
                            Tab(
                              text: "Indian",
                            ),
                            Tab(
                              text: "Global",
                            ),
                          ],
                        ),
                      ),
                    ]),
                  ),
                  content: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: TabBarView(
                          children: [section(true), section(false)])),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  Widget section(bool isIndian) {
    List<GlobalIndiceWatchModel> indice;
    if (isIndian == true) {
      indice = indianIndice;
    } else {
      indice = globalIndice;
    }

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
                        builder: (context) => deleteDialog(
                            context, isIndian == true ? true : false));
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
      body: indice == null
          ? LoadingPage()
          : indice.isEmpty
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
                        itemCount: isIndian == false
                            ? globalCodeList.length
                            : indianCodeList.length,
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
                                        isIndian,
                                        isIndian == true
                                            ? indianCodeList[index]
                                            : globalCodeList[index],
                                        indice[index]?.chng,
                                        indice[index]?.name,
                                        indice[index]?.price,
                                        indice[index]?.chngPercent)
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
                      ))),
    );
  }

  AlertDialog deleteDialog(BuildContext context, bool _isIndian) {
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

                    if (_isIndian == true) {
                      await db.removeIndianIndicesWatchlist(
                          _selectedList.map((e) => indianCodeList[e]).toList());
                    } else {
                      await db.removeGlobalIndicesWatchlist(
                          _selectedList.map((e) => globalCodeList[e]).toList());
                    }

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
                    List<GlobalIndiceWatchModel> a = [];

                    if (_isIndian == true) {
                      for (var _indice in indianIndice) {
                        if (!_selectedList
                            .contains(indianIndice.indexOf(_indice))) {
                          a.add(_indice);
                          print(_indice.name);
                        }
                      }
                      indianIndice = a;
                    } else {
                      for (var _indice in globalIndice) {
                        if (!_selectedList
                            .contains(globalIndice.indexOf(_indice))) {
                          a.add(_indice);
                          print(_indice.name);
                        }
                      }
                      globalIndice = a;
                    }

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
