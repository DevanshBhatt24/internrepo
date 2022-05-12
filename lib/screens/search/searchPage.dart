import 'dart:convert';
import 'dart:math';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:technical_ind/components/LoadingPage.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:technical_ind/providers/storageProviders.dart';
import 'package:technical_ind/screens/cryptocurrency/explorecrypto.dart';
import 'package:technical_ind/screens/etf/etfexplorepage.dart';
import 'package:technical_ind/screens/forex/forexExplore.dart';
import 'package:technical_ind/screens/indices/globalIndices/global_explore.dart';
import 'package:technical_ind/screens/indices/indices_explore.dart';
import 'package:technical_ind/screens/mutual/mutualExplore.dart';
import 'package:technical_ind/screens/mutual/summary.dart';
import 'package:technical_ind/screens/stocks/explore/home.dart';
import '../../styles.dart';
import 'business/model.dart';
import 'package:http/http.dart' as http;

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  // List<String> recent = [
  //   'NASDAQ',
  //   'Axis Mutual Fund',
  //   'ICICI prudential',
  //   'Parag Parikh MF'
  // ];
  // List<String> trending = [
  //   'NASDAQ',
  //   'Axis Mutual Fund',
  //   'ICICI prudential',
  //   'Parag Parikh MF'
  // ];

  var jsonText;
  List<StockSearch> stocks;
  List<IndicesSearch> indices;
  List<FundEtfSearch> fundsEtf;
  List<EtfSearch> etf;
  List<ForexSearch> forex;
  List<CryptoSearch> crypto;
  List<CommoditySearch> commodity;
  bool isloading = true;
  _loadJson() async {
    // try {
    //   jsonText = await http.get(Uri.parse(
    //       'https://api.bottomstreet.com/api/data?page=stocks_isin_list'));
    //   print("done");
    //   stocks = stockSearchFromJson(jsonText.body);
    // } catch (e) {
    //   print('this is the error ${e.toString()}');
    // }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stockSearch = prefs.getString('stockSearch');
    if (stockSearch == null) {
      jsonText = (await http.get(Uri.parse(
              "https://api.bottomstreet.com/api/data?page=stocks_isin_list")))
          .body;
      // await rootBundle.loadString('assets/instrument/stocks_list.json');
      print("done");
      stocks = stockSearchFromJson(jsonText);
    } else {
      stocks = stockSearchFromJson(stockSearch);
    }
    // jsonText = (await http.get(Uri.parse(
    //         "https://api.bottomstreet.com/api/data?page=stocks_isin_list")))
    //     .body;
    // // await rootBundle.loadString('assets/instrument/stocks_list.json');
    // print("done");
    // stocks = stockSearchFromJson(jsonText);
    jsonText = await rootBundle.loadString('assets/instrument/indices.json');
    print("done");
    indices = indicesSearchFromJson(jsonText);
    jsonText = await rootBundle.loadString('assets/instrument/fundsEtf.json');
    print("done");
    fundsEtf = fundEtfSearchFromJson(jsonText);
    jsonText = await rootBundle
        .loadString('assets/instrument/investing_etf_list.json');
    print("done");
    etf = etfSearchFromJson(jsonText);
    jsonText = await rootBundle.loadString('assets/instrument/forex.json');
    print("done");
    forex = forexSearchFromJson(jsonText);
    jsonText = await rootBundle.loadString('assets/instrument/crypto.json');
    print("done");
    crypto = cryptoSearchFromJson(jsonText);
    // jsonText = await rootBundle.loadString('assets/instrument/commodity.json');
    // print("done");
    // commodity = commoditySearchFromJson(jsonText);
    setState(() {
      isloading = false;
    });
  }

  updateCachedStocks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    jsonText = (await http.get(Uri.parse(
            "https://api.bottomstreet.com/api/data?page=stocks_isin_list")))
        .body;
    prefs.setString('stockSearch', jsonText);
  }

  @override
  void initState() {
    super.initState();
    _loadJson();
    _fetchTrending();
    _getRecents();
    updateCachedStocks();
  }

  FindTrending trending;
  List _trending = [];
  _fetchTrending() async {
    await FirebaseFirestore.instance
        .collection('global')
        .doc('mainTrending')
        .get()
        .then(
      (value) {
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
      },
    );
  }

  var _recent = <String>[];

  SharedPreferences prefs;

  _setRecents() async {
    prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('mainRecent', _recent);
  }

  _getRecents() async {
    prefs = await SharedPreferences.getInstance();
    List<String> _list = prefs.getStringList('mainRecent');
    if (_list != null) _recent.addAll(_list);
  }

  final TextEditingController _typeAheadController = TextEditingController();
  CupertinoSuggestionsBoxController _suggestionsBoxController =
      CupertinoSuggestionsBoxController();
  List<SearchIdentifier> searchIdentifier = [];
  List<String> getSuggestions(String pattern) {
    List<String> suggestions = [];
    searchIdentifier = [];
    if (pattern.length < 2) return suggestions;
    for (var i = 0; i < stocks.length; i++) {
      // String temp = stocks[i].shortCode != ""
      //     ? "${stocks[i].shortCode}"
      //     : "${stocks[i].name}";
      if (stocks[i].name.toLowerCase().contains(pattern.toLowerCase())) {
        searchIdentifier.add(SearchIdentifier(
            stocks[i].name, stocks[i].isin, "STOCK", stocks[i].sector));
        suggestions.add(stocks[i].name);
        if (suggestions.length > 30) break;
      } else if (stocks[i]
          .shortCode
          .toLowerCase()
          .contains(pattern.toLowerCase())) {
        searchIdentifier.add(SearchIdentifier(
            stocks[i].name, stocks[i].isin, "STOCK", stocks[i].sector));
        suggestions.add(stocks[i].name);
        if (suggestions.length > 30) break;
      }
    }
    for (var i in indices) {
      if (i.indiceName.toLowerCase().contains(pattern.toLowerCase())) {
        searchIdentifier
            .add(SearchIdentifier(i.indiceName, i.indiceName, "INDEX", ""));
        suggestions.add(i.indiceName);
        if (suggestions.length > 50) break;
      }
    }
    for (var i in fundsEtf) {
      if (i.fundName.toLowerCase().contains(pattern.toLowerCase()) &&
          !i.fundName.contains("etf")) {
        searchIdentifier
            .add(SearchIdentifier(i.fundName, i.field3.toString(), "MF", ""));
        suggestions.add(i.fundName);
        if (suggestions.length > 70) break;
      }
    }
    for (var i in etf) {
      if (i.fundName.toLowerCase().contains(pattern.toLowerCase())) {
        searchIdentifier
            .add(SearchIdentifier(i.fundName, i.id.toString(), "ETF", ""));
        suggestions.add(i.fundName);
        if (suggestions.length > 70) break;
      }
    }
    for (var i in forex) {
      if (i.currencyName.toLowerCase().contains(pattern.toLowerCase())) {
        searchIdentifier.add(SearchIdentifier(i.currencyName,
            i.currencyName.toUpperCase().replaceAll('-', '/'), "FOREX", ""));
        suggestions.add(i.currencyName);
        if (suggestions.length > 90) break;
      }
    }
    for (var i in crypto) {
      if (i.fullName.toLowerCase().contains(pattern.toLowerCase())) {
        searchIdentifier
            .add(SearchIdentifier(i.fullName, i.symbol, "CRYPTO", ""));
        suggestions.add(i.fullName);
        if (suggestions.length > 110) break;
      }
    }
    // for (var i in commodity) {
    //   if (i.commodityName.toLowerCase().contains(pattern.toLowerCase())) {
    //     searchIdentifier.add(SearchIdentifier(
    //         i.commodityName, i.categoricalCommodityName, "COMMODITY"));
    //     suggestions.add(i.commodityName);
    //     if (suggestions.length > 130) break;
    //   }
    // }
    return suggestions;
  }

  @override
  Widget build(BuildContext context) {
    var user = context.read(storageServicesProvider);
    FirebaseAnalytics.instance.setCurrentScreen(screenName: 'SearchPage');
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            'Search',
            style: headingStyle,
          ),
        ),
        body: isloading
            ? LoadingPage()
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 10),
                      Container(
                        height: 40,
                        color: black,
                        child: Container(
                          // margin:
                          // EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          // height: 40,
                          child: Material(
                            color: black,
                            child: CupertinoTypeAheadFormField(
                              getImmediateSuggestions: false,
                              autovalidateMode: AutovalidateMode.disabled,
                              animationDuration: Duration(milliseconds: 0),
                              suggestionsBoxController:
                                  _suggestionsBoxController,
                              loadingBuilder: (c) {
                                return Container();
                              },
                              errorBuilder: (context, o) {
                                return Container();
                              },
                              noItemsFoundBuilder: (context) {
                                return Container();
                              },
                              textFieldConfiguration:
                                  CupertinoTextFieldConfiguration(
                                placeholder: 'Search',
                                controller: _typeAheadController,
                                clearButtonMode: OverlayVisibilityMode.editing,
                                decoration: BoxDecoration(
                                    color: darkGrey,
                                    borderRadius: BorderRadius.circular(6)),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 9),
                                prefix: Padding(
                                  padding: const EdgeInsets.only(left: 18),
                                  child: ImageIcon(
                                    AssetImage("assets/nav/search.png"),
                                    color: white60,
                                  ),
                                ),
                                style: subtitle2White,
                              ),
                              suggestionsBoxDecoration:
                                  CupertinoSuggestionsBoxDecoration(
                                      color: Colors.black,
                                      border: Border.all(width: 0),
                                      borderRadius: BorderRadius.circular(8)),
                              suggestionsCallback: (pattern) {
                                return Future.delayed(
                                  Duration(milliseconds: 200),
                                  () => getSuggestions(pattern),
                                );
                              },
                              itemBuilder: (context, String suggestion) {
                                SearchIdentifier s = searchIdentifier[
                                    searchIdentifier.indexWhere((element) =>
                                        element.name == suggestion)];
                                return Material(
                                  color: Colors.transparent,
                                  borderOnForeground: false,
                                  child: InkWell(
                                    onTap: () {
                                      if (!_recent.contains(s.name)) {
                                        _recent.insert(0, s.name);
                                        _setRecents();
                                      }
                                      if (trending.trending.indexWhere(
                                              (element) =>
                                                  element.name == s.name) !=
                                          -1) {
                                        trending
                                            .trending[trending.trending
                                                .indexWhere((element) =>
                                                    element.name == s.name)]
                                            .count++;
                                      } else {
                                        trending.trending.add(
                                          Trending(name: s.name, count: 1),
                                        );
                                      }
                                      user.updateTrending(
                                          trending.toJson(), 'mainTrending');
                                      FocusScope.of(context).unfocus();
                                      searchNavigation(s);
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12, horizontal: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              // s.mixName != ""
                                              //     ? "${s.mixName}"
                                              //     :
                                              s.name,
                                              style: subtitle1White60,
                                              overflow: TextOverflow.visible,
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(color: blue),
                                              borderRadius:
                                                  BorderRadius.circular(2),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Text(
                                                s.type,
                                                style: TextStyle(
                                                    color: blue, fontSize: 12),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              onSuggestionSelected: (String suggestion) {
                                _typeAheadController.text = suggestion;
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      _buildRecentAndTrending(),
                      SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color: darkGrey,
                            border: Border.all(color: Colors.white12),
                            borderRadius: BorderRadius.circular(8)),
                        child: Text(
                          "Search for Stocks, Forex, Crypto, Indices, Mutual Munds and ETF",
                          style: subtitle2White60,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  searchNavigation(SearchIdentifier s) {
    if (s.type == 'STOCK') {
      pushNewScreen(
        context,
        withNavBar: false,
        screen: Homepage(
            name: s.name, isin: s.identifier, isSearch: true, sector: s.sector),
      );
    }
    if (s.type == 'CRYPTO') {
      print("crypto");
      print(s.identifier);
      String iconName = s.name[0].toUpperCase() + s.name.substring(1);

      print(iconName);
      pushNewScreen(
        context,
        withNavBar: false,
        screen: ExplorePageCrypto(
          top: SvgPicture.asset(
            'assets/icons/$iconName.svg',
            height: 50,
            width: 50,
          ),
          mid: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              iconName,
              style: headline6,
            ),
          ),
          isSearch: true,
          filter: s.identifier.toUpperCase(),
          title: iconName,
        ),
      );
    }
    if (s.type == 'FOREX') {
      pushNewScreen(
        context,
        withNavBar: false,
        screen: ForexExplorePage(
          menu: [
            "Overview",
            "Charts",
            "Technical Indicators",
            "Historical Data",
            "News",
          ],
          code: s.identifier.replaceAll("/", ""),
          title: s.identifier,
          isSearch: true,
          //good
        ),
      );
    }
    if (s.type == 'MF') {
      pushNewScreen(context,
          screen: Summary(
            title: s.name,
            // latestNav: dataList[index]
            //     .latestNav
            //     .toString(),
            code: int.parse(s.identifier),
            isSearch: true,
          ),
          withNavBar: false);
    }
    if (s.type == "ETF") {
      pushNewScreen(
        context,
        screen: ExplorePageETF(
          id: s.identifier,
          defaultheight: 95,
          title: s.name,
          isSearch: true,
        ),
        withNavBar: false,
      );
    }
    if (s.type == "COMMODITY") {}
    if (s.type == "INDEX") {
      if (s.name.toLowerCase().contains("bse") ||
          s.name.toLowerCase().contains("nifty") ||
          s.name.toLowerCase().contains("sensex")) {
        print('indian');

        List<String> menu = [
          'Overview',
          'Charts',
          'Stock Effect',
          'Components',
          'Technical Indicators',
          'Historical Data',
          'News'
        ];

        pushNewScreen(
          context,
          withNavBar: false,
          screen: ExplorePageIndices(
            isSearch: true,
            title: s.name,
            mid: s.name.toLowerCase().contains('bse')
                ? Text(
                    'BSE',
                    style: bodyText2White60,
                  )
                : Text(
                    'NSE',
                    style: bodyText2White60,
                  ),
            menu: menu,
          ),
        );
      } else {
        print('global');
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
            title: s.name,
          ),
        );
      }
    }
  }

  Widget _buildListItem(String assetName, String title) {
    var c = getSuggestions(title)[0];
    SearchIdentifier s = searchIdentifier[
        searchIdentifier.indexWhere((element) => element.name == c)];
    return InkWell(
      onTap: () async {
        searchNavigation(s);
        if (!_recent.contains(s.name)) _recent.insert(0, s.name);
        _setRecents();
        if (trending.trending.indexWhere((element) => element.name == s.name) !=
            -1) {
          trending
              .trending[trending.trending
                  .indexWhere((element) => element.name == s.name)]
              .count++;
        } else {
          trending.trending.add(
            Trending(name: s.name, count: 1),
          );
        }
        setState(() {});
        await context
            .read(storageServicesProvider)
            .updateTrending(trending.toJson(), 'mainTrending');
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
            Flexible(
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

  Column _buildRecentAndTrending() {
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
              min(4, _recent.length),
              (index) =>
                  _buildListItem("assets/icons/recent.svg", _recent[index])),
        ),
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
              (index) => _buildListItem(
                  "assets/icons/trending.svg", _trending[index])),
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

class SearchIdentifier {
  final String name, identifier, type, sector;
  SearchIdentifier(this.name, this.identifier, this.type, this.sector);
}

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
