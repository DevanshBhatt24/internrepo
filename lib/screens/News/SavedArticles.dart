import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:technical_ind/providers/navBarProvider.dart';
import 'package:technical_ind/providers/storageProviders.dart';

import 'package:technical_ind/screens/News/broadcastPage.dart';
import 'package:technical_ind/screens/News/business/model.dart';
import 'package:technical_ind/screens/alerts/trialEnded.dart';
import 'package:technical_ind/widgets/appbar_with_back_and_search.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:technical_ind/widgets/griditemnews.dart';

import '../../styles.dart';

class SavedArticles extends StatefulWidget {
  @override
  _SavedArticlesState createState() => _SavedArticlesState();
}

class _SavedArticlesState extends State<SavedArticles> {
  List<Article> articles = [];
  @override
  void initState() {
    super.initState();
    _fetchApi();
  }

  List<int> _selectedList = [];
  _fetchApi() {
    Map<String, dynamic> user = context.read(firestoreUserProvider);

    if (user.containsKey('NewsWatchlist')) {
      articles =
          List.from(user['NewsWatchlist'].map((e) => Article.fromJson(e)));
      // articles.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    }
    setState(() {
      _refreshController.refreshCompleted();
    });
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithBack(
        text: 'Saved Articles',
      ),
      bottomNavigationBar: _selectedList.isNotEmpty
          ? Container(
              // margin: EdgeInsets.only(bottom: 56),
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
      body: articles.isEmpty
          ? noItems(context)
          : Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 5),
              child: SmartRefresher(
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
                child: StaggeredGridView.countBuilder(
                  crossAxisCount: 2,
                  addAutomaticKeepAlives: true,
                  itemCount: articles.length,
                  itemBuilder: (BuildContext context, int index) => Stack(
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
                          child: GridItem(
                            article: articles[index],
                            show: false,

                            // ontap: () {
                            //   setState(() {
                            //     _selectedList.contains(index)
                            //         ? _selectedList.remove(index)
                            //         : _selectedList.add(index);
                            //   });
                            //   if (_selectedList.isEmpty)
                            //     context
                            //         .read(navBarVisibleProvider)
                            //         .setNavbarVisible(false);
                            // },
                            // onLongPress: () {
                            //   setState(() {
                            //     _selectedList.add(index);
                            //     context
                            //         .read(navBarVisibleProvider)
                            //         .setNavbarVisible(true);
                            //   });
                            // },
                          ),
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
                  staggeredTileBuilder: (int index) {
                    return StaggeredTile.count(2, 0.8);
                  },
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
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

                    await db.removeNewsWatchlistFromList(
                        _selectedList.map((e) => articles[e]).toList());

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
                    List<Article> a = [];
                    for (var article in articles) {
                      if (!_selectedList.contains(articles.indexOf(article))) {
                        a.add(article);
                        print(article.title);
                      }
                    }
                    articles = a;
                    _selectedList.clear();
                    setState(() {});
                    ScaffoldMessenger.of(context).showSnackBar(
                      s,
                    );
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
          // InkWell(
          //   onTap: () {
          //     context.read(navBarVisibleProvider).controller.jumpToTab(0);
          //   },
          //   child: Container(
          //     height: 40,
          //     width: 220,
          //     decoration: BoxDecoration(
          //         color: darkGrey, borderRadius: BorderRadius.circular(6)),
          //     child: Center(
          //       child: Text(
          //         "Search",
          //         style: buttonWhite.copyWith(color: blue),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
