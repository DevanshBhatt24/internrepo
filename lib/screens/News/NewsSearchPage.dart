import 'dart:collection';
import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:horizontal_data_table/refresh/pull_to_refresh/pull_to_refresh.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:technical_ind/providers/storageProviders.dart';
import 'package:technical_ind/screens/News/broadcastPage.dart';
import 'package:technical_ind/screens/News/business/model.dart';
import 'package:technical_ind/screens/News/searchResults.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/scheduler.dart';
import 'package:technical_ind/widgets/appbar_with_back_and_search.dart';
import '../../styles.dart';
import 'business/newsServices.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewsSearchPage extends StatefulWidget {
  NewsSearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<NewsSearchPage> {
  bool _showsearchpage = false;

  TextEditingController _controller = TextEditingController();

  var _recent = <String>[];

  SharedPreferences prefs;

  _setRecents() async {
    prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('recent', _recent);
  }

  _getRecents() async {
    prefs = await SharedPreferences.getInstance();
    List<String> _list = prefs.getStringList('recent');
    _recent.addAll(_list);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => setState(
        () {
          _getRecents();
          _fetchTrending();
        },
      ),
    );
  }

  List<Article> articles = [];

  void getArticles(String title) async {
    articles = await NewsServices.getNewsFromQuery(title).whenComplete(() {
      setState(() {});
    });
  }

  RefreshController _refreshController = RefreshController();

  FindTrending trending;
  List _trending = [];
  _fetchTrending() async {
    await FirebaseFirestore.instance
        .collection('global')
        .doc('findtrending')
        .get()
        .then((value) {
      trending = FindTrending.fromJson(value.data());
      setState(
        () {
          trending.trending.sort(
            (a, b) {
              return b.count.compareTo(a.count);
            },
          );
          trending.trending.forEach(
            (element) {
              _trending.add(element.name);
            },
          );
        },
      );
    });
  }

  String _title;
  @override
  Widget build(BuildContext context) {
    var user = context.read(storageServicesProvider);
    return SafeArea(
      child: Scaffold(
        appBar: !_showsearchpage
            ? PreferredSize(
                child: Container(
                  height: 58,
                  color: grey,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    // height: 40,
                    child: CupertinoTextField(
                      controller: _controller,
                      onSubmitted: (val) {
                        setState(
                          () {
                            _title = val;
                            getArticles(val);
                            _showsearchpage = true;
                            _recent.add(val);
                            _setRecents();
                            if (trending.trending.indexWhere(
                                    (element) => element.name == val) !=
                                -1) {
                              trending
                                  .trending[trending.trending.indexWhere(
                                      (element) => element.name == val)]
                                  .count++;
                            } else {
                              trending.trending.add(
                                Trending(name: val, count: 1),
                              );
                            }
                            user.updateTrending(
                                trending.toJson(), 'findtrending');
                          },
                        );
                        _controller.clear();
                      },
                      onTap: () {
                        setState(() {
                          _showsearchpage = false;
                        });
                      },
                      autofocus: true,
                      clearButtonMode: OverlayVisibilityMode.editing,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 9),
                      prefix: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: InkWell(
                          child: Icon(
                            Icons.chevron_left_rounded,
                            color: white60,
                          ),
                          onTap: () => Navigator.pop(context),
                        ),
                        // ImageIcon(
                        // AssetImage("assets/nav/search.png"),
                        // color: white60,
                        // ),
                      ),
                      style: subtitle2White,
                    ),
                  ),
                ),
                preferredSize: Size.fromHeight(58),
              )
            : AppBarWithBack(
                text: "Results for $_title",
              ),
        body: !_showsearchpage
            ? SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildRecent(),
                      _buildTrending(),
                    ],
                  ),
                ),
              )
            : articles.isEmpty
                ? Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  )
                : NewsWidget(
                    articles: articles,
                    // refresh: getArticles(title),
                  ),
      ),
    );
  }

  Widget _buildListItem(String assetName, String title, {Function() ontap}) {
    return InkWell(
      onTap: () {
        if (ontap != null) ontap();
        pushNewScreen(
          context,
          screen: SearchResultsPage(
            title: title,
            isSearched: true,
            isIpo: false,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            SvgPicture.asset(
              assetName,
            ),
            SizedBox(
              width: 12,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.25,
              child: Text(
                title,
                style: bodyText2White,
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildRecent() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 12),
          alignment: Alignment.centerLeft,
          child: Text(
            "Recent",
            style: bodyText2White60,
          ),
        ),
        Column(
          children: List.generate(
            min(_recent.length, 5),
            (index) => _buildListItem(
                "assets/icons/recent.svg", _recent[_recent.length - index - 1],
                ontap: () {
              if (trending.trending.indexWhere((element) =>
                      element.name == _recent[_recent.length - index - 1]) !=
                  -1) {
                trending
                    .trending[trending.trending.indexWhere((element) =>
                        element.name == _recent[_recent.length - index - 1])]
                    .count++;
              } else {
                trending.trending.add(
                  Trending(name: _recent[_recent.length - index - 1], count: 1),
                );
              }
              context
                  .read(storageServicesProvider)
                  .updateTrending(trending.toJson(), 'findtrending');
            }),
          ),
        ),
      ],
    );
  }

  Column _buildTrending() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 12),
          alignment: Alignment.centerLeft,
          child: Text(
            "Trending",
            style: bodyText2White60,
          ),
        ),
        Column(
          children: List.generate(
            min(4, _trending.length),
            (index) {
              return _buildListItem(
                  "assets/icons/trending.svg", _trending[index],
                  ontap: () async {
                _recent.add(_trending[index]);
                _setRecents();
                setState(() {});
              });
            },
          ),
        )
      ],
    );
  }

  Widget _noResult() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 38),
      child: Text(
        "Sorry! No result found for ' Relvnc'",
        style: bodyText1white,
      ),
    );
  }
}

// To parse this JSON data, do
//
//     final findTrending = findTrendingFromJson(jsonString);

FindTrending findTrendingFromJson(String str) =>
    FindTrending.fromJson(json.decode(str));

String findTrendingToJson(FindTrending data) => json.encode(data.toJson());

class FindTrending {
  FindTrending({
    this.trending,
  });

  List<Trending> trending;

  factory FindTrending.fromJson(Map<String, dynamic> json) => FindTrending(
        trending: List<Trending>.from(
            json["trending"].map((x) => Trending.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "trending": List<dynamic>.from(trending.map((x) => x.toJson())),
      };
}

class Trending {
  Trending({
    this.name,
    this.count,
  });

  String name;
  int count;

  factory Trending.fromJson(Map<String, dynamic> json) => Trending(
        name: json["name"],
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "count": count,
      };
}
