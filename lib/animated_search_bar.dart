import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:technical_ind/screens/cryptocurrency/explorecrypto.dart';
import 'package:technical_ind/screens/etf/etfexplorepage.dart';
import 'package:technical_ind/screens/forex/forexExplore.dart';
import 'package:technical_ind/screens/indices/globalIndices/global_explore.dart';
import 'package:technical_ind/screens/indices/indices_explore.dart';
import 'package:technical_ind/screens/search/business/model.dart';
import 'package:technical_ind/screens/search/searchPage.dart';
import 'package:technical_ind/screens/stocks/explore/home.dart';
import 'package:technical_ind/styles.dart';

class AnimatedSearchBar extends StatefulWidget {
  ///  width - double ,isRequired : Yes
  ///  textController - TextEditingController  ,isRequired : Yes
  ///  onSuffixTap - Function, isRequired : Yes
  ///  rtl - Boolean, isRequired : No
  ///  autoFocus - Boolean, isRequired : No
  ///  style - TextStyle, isRequired : No
  ///  closeSearchOnSuffixTap - bool , isRequired : No
  ///  suffixIcon - Icon ,isRequired :  No
  ///  prefixIcon - Icon  ,isRequired : No
  ///  animationDurationInMilli -  int ,isRequired : No
  ///  helpText - String ,isRequired :  No
  /// inputFormatters - TextInputFormatter, Required - No

  final double width;
  final TextEditingController textController;
  final Icon suffixIcon;
  final Widget prefixIcon;
  final String helpText;
  final int animationDurationInMilli;
  final onSuffixTap;
  final bool rtl;
  final bool autoFocus;
  final TextStyle style;
  final bool closeSearchOnSuffixTap;
  final Color color;
  final dynamic onSubmit;
  final List<TextInputFormatter> inputFormatters;
  // final List data;
  List<StockSearch> stocks;
  List<IndicesSearch> indices;
  List<FundEtfSearch> fundsEtf;
  List<EtfSearch> etf;
  List<ForexSearch> forex;
  List<CryptoSearch> crypto;
  List<CommoditySearch> commodity;

  AnimatedSearchBar({
    Key key,
    // this.data,
    this.stocks,
    this.indices,
    this.fundsEtf,
    this.etf,
    this.forex,
    this.crypto,
    this.commodity,

    /// The width cannot be null
    this.width,

    /// The textController cannot be null
    this.textController,
    this.suffixIcon,
    this.prefixIcon,
    this.onSubmit,
    this.helpText = "Search...",

    /// choose your custom color
    this.color = Colors.white,

    /// The onSuffixTap cannot be null
    this.onSuffixTap,
    this.animationDurationInMilli = 375,

    /// make the search bar to open from right to left
    this.rtl = false,

    /// make the keyboard to show automatically when the searchbar is expanded
    this.autoFocus = false,

    /// TextStyle of the contents inside the searchbar
    this.style,

    /// close the search on suffix tap
    this.closeSearchOnSuffixTap = false,

    /// can add list of inputformatters to control the input
    this.inputFormatters,
  }) : super(key: key);

  @override
  _AnimatedSearchBarState createState() => _AnimatedSearchBarState();
}

///toggle - 0 => false or closed
///toggle 1 => true or open
int toggle = 0;

class _AnimatedSearchBarState extends State<AnimatedSearchBar>
    with SingleTickerProviderStateMixin {
  ///initializing the AnimationController
  AnimationController _con;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    ///Initializing the animationController which is responsible for the expanding and shrinking of the search bar
    _con = AnimationController(
      vsync: this,

      /// animationDurationInMilli is optional, the default value is 375
      duration: Duration(milliseconds: widget.animationDurationInMilli),
    );
  }

  unfocusKeyboard() {
    final FocusScopeNode currentScope = FocusScope.of(context);
    if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  final TextEditingController _typeAheadController = TextEditingController();
  CupertinoSuggestionsBoxController _suggestionsBoxController =
      CupertinoSuggestionsBoxController();
  List<SearchIdentifier> searchIdentifier = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,

      ///if the rtl is true, search bar will be from right to left
      alignment: widget.rtl ? Alignment.centerRight : Alignment(-1.0, 0.0),
      // alignment: Alignment.center,
      // alignment: Alignment.centerRight,

      ///Using Animated container to expand and shrink the widget
      child: AnimatedContainer(
        duration: Duration(milliseconds: widget.animationDurationInMilli),
        height: 48.0,
        width: (toggle == 0) ? 48.0 : widget.width,
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          /// can add custom color or the color will be white
          color: widget.color,
          borderRadius: BorderRadius.circular(30.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              spreadRadius: -10.0,
              blurRadius: 10.0,
              offset: Offset(0.0, 10.0),
            ),
          ],
        ),
        child: Stack(
          children: [
            ///Using Animated Positioned widget to expand and shrink the widget
            AnimatedPositioned(
              duration: Duration(milliseconds: widget.animationDurationInMilli),
              top: 6.0,
              right: 7.0,
              curve: Curves.easeOut,
              child: AnimatedOpacity(
                opacity: (toggle == 0) ? 0.0 : 1.0,
                duration: Duration(milliseconds: 200),
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    /// can add custom color or the color will be white
                    color: widget.color,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: AnimatedBuilder(
                    child: GestureDetector(
                      onTap: () {
                        try {
                          ///trying to execute the onSuffixTap function
                          widget.onSuffixTap();

                          ///closeSearchOnSuffixTap will execute if it's true
                          if (widget.closeSearchOnSuffixTap) {
                            unfocusKeyboard();
                            setState(() {
                              toggle = 0;
                            });
                          }
                        } catch (e) {
                          ///print the error if the try block fails
                          print(e);
                        }
                      },

                      ///suffixIcon is of type Icon
                      child: widget.suffixIcon != null
                          ? widget.suffixIcon
                          : Icon(
                              Icons.close,
                              size: 20.0,
                            ),
                    ),
                    builder: (context, widget) {
                      ///Using Transform.rotate to rotate the suffix icon when it gets expanded
                      return Transform.rotate(
                        angle: _con.value * 2.0 * pi,
                        child: widget,
                      );
                    },
                    animation: _con,
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: widget.animationDurationInMilli),
              left: (toggle == 0) ? 20.0 : 40.0,
              curve: Curves.easeOut,
              top: 11.0,

              ///Using Animated opacity to change the opacity of th textField while expanding
              child: AnimatedOpacity(
                opacity: (toggle == 0) ? 0.0 : 1.0,
                duration: Duration(milliseconds: 200),
                child: Container(
                  padding: const EdgeInsets.only(left: 10),
                  alignment: Alignment.topCenter,
                  width: widget.width / 1.4,
                  child: Material(
                    color: black,
                    child: CupertinoTypeAheadFormField(
                      getImmediateSuggestions: false,
                      autovalidateMode: AutovalidateMode.disabled,
                      animationDuration: Duration(milliseconds: 0),
                      suggestionsBoxController: _suggestionsBoxController,
                      loadingBuilder: (c) {
                        return Container();
                      },
                      errorBuilder: (context, o) {
                        return Container();
                      },
                      noItemsFoundBuilder: (context) {
                        return Container();
                      },
                      textFieldConfiguration: CupertinoTextFieldConfiguration(
                        placeholder: 'Search',
                        controller: _typeAheadController,
                        clearButtonMode: OverlayVisibilityMode.never,
                        decoration: BoxDecoration(
                            color: darkGrey,
                            borderRadius: BorderRadius.circular(6)),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 9),
                        // prefix: Padding(
                        //   padding: const EdgeInsets.only(left: 18),
                        //   child: ImageIcon(
                        //     AssetImage("assets/nav/search.png"),
                        //     color: white60,
                        //   ),
                        // ),
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
                            searchIdentifier.indexWhere(
                                (element) => element.name == suggestion)];
                        return Material(
                          color: Colors.transparent,
                          borderOnForeground: false,
                          child: InkWell(
                            onTap: () {
                              // if (!_recent.contains(s.name)) {
                              //   _recent.insert(0, s.name);
                              //   _setRecents();
                              // }
                              // if (trending.trending.indexWhere(
                              //         (element) =>
                              //             element.name == s.name) !=
                              //     -1) {
                              //   trending
                              //       .trending[trending.trending
                              //           .indexWhere((element) =>
                              //               element.name == s.name)]
                              //       .count++;
                              // } else {
                              //   trending.trending.add(
                              //     Trending(name: s.name, count: 1),
                              //   );
                              // }
                              // user.updateTrending(
                              //     trending.toJson(), 'mainTrending');
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
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
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
            ),

            ///Using material widget here to get the ripple effect on the prefix icon
            Material(
              /// can add custom color or the color will be white
              color: widget.color,
              borderRadius: BorderRadius.circular(30.0),
              child: IconButton(
                splashRadius: 19.0,

                ///if toggle is 1, which means it's open. so show the back icon, which will close it.
                ///if the toggle is 0, which means it's closed, so tapping on it will expand the widget.
                ///prefixIcon is of type Icon
                icon: widget.prefixIcon != null
                    ? toggle == 1
                        ? Icon(Icons.arrow_back_ios)
                        : widget.prefixIcon
                    : Icon(
                        toggle == 1 ? Icons.arrow_back_ios : Icons.search,
                        size: 20.0,
                      ),
                onPressed: () {
                  setState(
                    () {
                      ///if the search bar is closed
                      if (toggle == 0) {
                        toggle = 1;
                        setState(() {
                          ///if the autoFocus is true, the keyboard will pop open, automatically
                          if (widget.autoFocus)
                            FocusScope.of(context).requestFocus(focusNode);
                        });

                        ///forward == expand
                        _con.forward();
                      } else {
                        ///if the search bar is expanded
                        toggle = 0;

                        ///if the autoFocus is true, the keyboard will close, automatically
                        setState(() {
                          if (widget.autoFocus) unfocusKeyboard();
                        });

                        ///reverse == close
                        _con.reverse();
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // List<String> getSuggestions(String pattern) {
  //   List<String> suggestions = [];
  //   searchIdentifier = [];
  //   if (pattern.length < 2) return suggestions;
  //   //stocks--------------------------------
  //   for (var i = 0; i < widget.data.length; i++) {
  //     if (widget.data[i].name.toLowerCase().contains(pattern.toLowerCase())) {
  //       searchIdentifier.add(SearchIdentifier(widget.data[i].name,
  //           widget.data[i].isin, "STOCK", widget.data[i].sector));
  //       suggestions.add(widget.data[i].name);
  //       if (suggestions.length > 30) break;
  //     } else if (widget.data[i].shortCode
  //         .toLowerCase()
  //         .contains(pattern.toLowerCase())) {
  //       searchIdentifier.add(SearchIdentifier(widget.data[i].name,
  //           widget.data[i].isin, "STOCK", widget.data[i].sector));
  //       suggestions.add(widget.data[i].name);
  //       if (suggestions.length > 30) break;
  //     }
  //   }
  //   //----------------------------------------
  //   return suggestions;
  // }

  List<String> getSuggestions(String pattern) {
    List<String> suggestions = [];
    searchIdentifier = [];
    if (pattern.length < 2) return suggestions;
    for (var i = 0; i < widget.stocks.length; i++) {
      // String temp = stocks[i].shortCode != ""
      //     ? "${stocks[i].shortCode}"
      //     : "${stocks[i].name}";
      if (widget.stocks[i].name.toLowerCase().contains(pattern.toLowerCase())) {
        searchIdentifier.add(SearchIdentifier(widget.stocks[i].name,
            widget.stocks[i].isin, "STOCK", widget.stocks[i].sector));
        suggestions.add(widget.stocks[i].name);
        if (suggestions.length > 30) break;
      } else if (widget.stocks[i].shortCode
          .toLowerCase()
          .contains(pattern.toLowerCase())) {
        searchIdentifier.add(SearchIdentifier(widget.stocks[i].name,
            widget.stocks[i].isin, "STOCK", widget.stocks[i].sector));
        suggestions.add(widget.stocks[i].name);
        if (suggestions.length > 30) break;
      }
    }
    for (var i in widget.indices) {
      if (i.indiceName.toLowerCase().contains(pattern.toLowerCase())) {
        searchIdentifier
            .add(SearchIdentifier(i.indiceName, i.indiceName, "INDEX", ""));
        suggestions.add(i.indiceName);
        if (suggestions.length > 50) break;
      }
    }
    for (var i in widget.fundsEtf) {
      if (i.fundName.toLowerCase().contains(pattern.toLowerCase()) &&
          !i.fundName.contains("etf")) {
        searchIdentifier
            .add(SearchIdentifier(i.fundName, i.field3.toString(), "MF", ""));
        suggestions.add(i.fundName);
        if (suggestions.length > 70) break;
      }
    }
    for (var i in widget.etf) {
      if (i.fundName.toLowerCase().contains(pattern.toLowerCase())) {
        searchIdentifier
            .add(SearchIdentifier(i.fundName, i.id.toString(), "ETF", ""));
        suggestions.add(i.fundName);
        if (suggestions.length > 70) break;
      }
    }
    for (var i in widget.forex) {
      if (i.currencyName.toLowerCase().contains(pattern.toLowerCase())) {
        searchIdentifier.add(SearchIdentifier(i.currencyName,
            i.currencyName.toUpperCase().replaceAll('-', '/'), "FOREX", ""));
        suggestions.add(i.currencyName);
        if (suggestions.length > 90) break;
      }
    }
    for (var i in widget.crypto) {
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

  // searchNavigation(SearchIdentifier s) {
  //   if (s.type == 'STOCK') {
  //     pushNewScreen(
  //       context,
  //       withNavBar: false,
  //       screen: Homepage(
  //           name: s.name, isin: s.identifier, isSearch: true, sector: s.sector),
  //     );
  //   }
  // }

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
}

Summary({String title, int code, bool isSearch}) {}
