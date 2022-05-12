// import 'dart:async';
// import 'package:flutter/cupertino.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:horizontal_data_table/refresh/pull_to_refresh/pull_to_refresh.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:technical_ind/components/LoadingPage.dart';
import 'package:technical_ind/components/noDataAvailable.dart';
import 'package:technical_ind/screens/cryptocurrency/containerpagecrypto.dart';
import 'package:technical_ind/screens/landingPage.dart';
import 'package:technical_ind/screens/search/business/model.dart';
// import 'explorecrypto.dart';
import '../../animated_search_bar.dart';
import '../../styles.dart';
import '../../widgets/appbar_with_back_and_search.dart';
import 'business/crypto_list_model.dart';
import 'business/crypto_services.dart';
import 'package:http/http.dart' as http;

class CryptoListItem extends StatelessWidget {
  final String cyptoName, mCap, value, highlight, imageurl;
  final Color color;
  final Function onTap, onLongPress;

  const CryptoListItem(
      {Key key,
      this.imageurl,
      this.cyptoName,
      this.mCap,
      this.value,
      this.highlight,
      this.color,
      this.onTap,
      this.onLongPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 16),
                  height: 35,
                  width: 35,
                  // child: SvgPicture.asset(
                  //   'assets/icons/$cyptoName.svg',
                  // ),
                  child: Image.network(imageurl),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(cyptoName,
                        textAlign: TextAlign.start, style: subtitle1White),
                    Row(
                      children: <Widget>[
                        Text('MCap  ', style: captionWhite60),
                        Text(' ₹ $mCap', style: captionWhite),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(value, textAlign: TextAlign.end, style: subtitle2White),
                  SizedBox(height: 2),
                  Text(
                    highlight[0] != '-' ? '+' + highlight : highlight,
                    textAlign: TextAlign.end,
                    style: highlightStyle.copyWith(
                        color: highlight[0] != '-' ? blue : red),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CryptoListingPage extends StatefulWidget {
  CryptoListingPage({Key key}) : super(key: key);

  @override
  _CryptoListingPageState createState() => _CryptoListingPageState();
}

class _CryptoListingPageState extends State<CryptoListingPage> {
  List<CryptoModel> arr;
  bool _loading = true;

  getCryptolist() async {
    arr = await CryptoServices.getCryptoList();

    arr[0].data.removeWhere((element) => element?.name == "Avalanche");
    setState(() {
      _loading = false;
    });
    _refreshController.refreshCompleted();
  }

  @override
  void initState() {
    super.initState();
    getCryptolist();
    // Timer.periodic(Duration(milliseconds: autoRefreshDuration), (t) {
    //   if (mounted)
    //     getCryptolist();
    //   else {
    //     print("Timer Ticking is stopping.");
    //     t.cancel();
    //   }
    // });
  }

  List<String> containerMenu = [
    "Overview",
    "Charts",
    "Technical Indicators",
    "Historical Data",
    "News",
  ];

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithBack(
        text: "Cryptocurrency",
      ),
      body: _loading
          ? LoadingPage()
          : arr == null
              ? NoDataAvailablePage()
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
                    onRefresh: () => getCryptolist(),
                    child: ListView.builder(
                      itemCount: arr[0]?.data?.length ?? 0,
                      itemBuilder: (c, i) {
                        if (arr[0]?.data[i]?.name != 'FilecoinFutures') {
                          return CryptoListItem(
                            cyptoName: arr[0]?.data[i]?.name == 'MaticNetwork'
                                ? 'Polygon'
                                : arr[0]?.data[i]?.name ?? "",
                            mCap: arr[0]?.data[i]?.marketCap ?? "",
                            value: '₹ ' + arr[0]?.data[i]?.price ?? "",
                            highlight: arr[0]?.data[i]?.change +
                                '(' +
                                arr[0]?.data[i]?.changePercent +
                                ')',
                            imageurl: arr[0].data[i].imageSrc,
                            onTap: () {
                              pushNewScreen(
                                context,
                                withNavBar: false,
                                screen: ContainPageCrypto(
                                  isList: true,
                                  value:
                                      // widget.value == null ? price :
                                      '₹ ' + arr[0]?.data[i]?.price ?? "",
                                  subValue:
                                      // widget.subValue == null
                                      //     ? chng
                                      //     :
                                      arr[0]?.data[i]?.change +
                                          '(' +
                                          arr[0]?.data[i]?.changePercent +
                                          ')',
                                  currencyChart:
                                      arr[0]?.data[i]?.backendParameterName ??
                                          "" + '/INR',
                                  title: arr[0]?.data[i]?.name == 'MaticNetwork'
                                      ? 'Polygon'
                                      : arr[0]?.data[i]?.name ?? "",
                                  defaultWidget: containerMenu[0],
                                  query:
                                      arr[0]?.data[i]?.backendParameterName ??
                                          "",
                                ),
                                // ExplorePageCrypto(
                                //   top: SvgPicture.asset(
                                //     arr[0].data[i].name == 'MaticNetwork'
                                //         ? 'assets/icons/Polygon.svg'
                                //         : 'assets/icons/${arr[0].data[i].name}.svg',
                                //     height: 50,
                                //     width: 50,
                                //   ),
                                //   mid: Padding(
                                //     padding: const EdgeInsets.symmetric(
                                //         vertical: 10.0),
                                //     child: Text(
                                //       arr[0].data[i].name == 'MaticNetwork'
                                //           ? 'Polygon'
                                //           : arr[0].data[i].name,
                                //       style: headline6,
                                //     ),
                                //   ),
                                //   filter:
                                //       arr[0]?.data[i]?.backendParameterName ??
                                //           "",
                                //   currencychart:
                                //       arr[0]?.data[i]?.backendParameterName ??
                                //           "" + '/INR',
                                //   title: arr[0]?.data[i]?.name == 'MaticNetwork'
                                //       ? 'Polygon'
                                //       : arr[0]?.data[i]?.name ?? "",
                                //   value: '₹ ' + arr[0]?.data[i]?.price ?? "",
                                //   subValue: arr[0]?.data[i]?.change +
                                //       '(' +
                                //       arr[0]?.data[i]?.changePercent +
                                //       ')',
                                // ),
                              );
                            },
                            // color: i % 2 == 0
                            //     ? const Color(0xff479fff)
                            //     : const Color(0xffff6880),
                          );
                        } else {
                          return SizedBox.shrink();
                        }
                      },
                    ),
                  ),
                ),
    );
  }
}

class CryptoListingPage2 extends StatefulWidget {
  const CryptoListingPage2({Key key}) : super(key: key);

  @override
  _CryptoListingPage2State createState() => _CryptoListingPage2State();
}

class _CryptoListingPage2State extends State<CryptoListingPage2> {
  List<CryptoModel2> arr;
  bool isLoading = true;
  var jsonText;
  List<StockSearch> stocks;
  List<IndicesSearch> indices;
  List<FundEtfSearch> fundsEtf;
  List<EtfSearch> etf;
  List<ForexSearch> forex;
  List<CryptoSearch> crypto;
  List<CommoditySearch> commodity;
  TextEditingController textController = TextEditingController();

  List<String> containerMenu = [
    "Overview",
    "Charts",
    "Technical Indicators",
    "Historical Data",
    "News",
  ];

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  getCryptolistandSearchData() async {
    arr = await CryptoServices2.getCryptoList();
    // if (gstocks == null) {
    //   jsonText = (await http.get(Uri.parse(
    //           "https://api.bottomstreet.com/api/data?page=stocks_isin_list")))
    //       .body;
    //   // await rootBundle.loadString('assets/instrument/stocks_list.json');
    //   print("done");
    //   gstocks = stockSearchFromJson(jsonText);
    //   jsonText = await rootBundle.loadString('assets/instrument/indices.json');
    //   print("done");
    //   gindices = indicesSearchFromJson(jsonText);
    //   jsonText = await rootBundle.loadString('assets/instrument/fundsEtf.json');
    //   print("done");
    //   gfundsEtf = fundEtfSearchFromJson(jsonText);
    //   jsonText = await rootBundle
    //       .loadString('assets/instrument/investing_etf_list.json');
    //   print("done");
    //   getf = etfSearchFromJson(jsonText);
    //   jsonText = await rootBundle.loadString('assets/instrument/forex.json');
    //   print("done");
    //   gforex = forexSearchFromJson(jsonText);
    //   jsonText = await rootBundle.loadString('assets/instrument/crypto.json');
    //   print("done");
    //   gcrypto = cryptoSearchFromJson(jsonText);
    // }

    setState(() {
      isLoading = false;
    });
    _refreshController.refreshCompleted();
  }

  @override
  void initState() {
    super.initState();
    getCryptolistandSearchData();
    // Timer.periodic(Duration(milliseconds: autoRefreshDuration), (t) {
    //   if (mounted)
    //     getCryptolist();
    //   else {
    //     print("Timer Ticking is stopping.");
    //     t.cancel();
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics.instance.setCurrentScreen(screenName: 'Cryptocurrency');
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBarWithBack(
          text: "Cryptocurrency",
        ),
        // child: Container(
        //   // margin: EdgeInsets.only(top: 5),
        //   child: Stack(
        //     children: [
        //       AppBarWithBack(
        //         text: "Cryptocurrency",
        //       ),
        //       Container(
        //         margin: EdgeInsets.fromLTRB(0, 33, 20, 0),
        //         child: AnimatedSearchBar(
        //           stocks: gstocks,
        //           indices: gindices,
        //           fundsEtf: gfundsEtf,
        //           etf: getf,
        //           forex: gforex,
        //           crypto: gcrypto,
        //           commodity: gcommodity,
        //           color: Colors.black,
        //           onSubmit: (value) {
        //             print('submitted search : $value');
        //           },
        //           style: TextStyle(
        //             color: Colors.white,
        //           ),
        //           closeSearchOnSuffixTap: true,
        //           suffixIcon: Icon(
        //             Icons.close,
        //             color: Colors.white,
        //           ),
        //           prefixIcon: Image.asset(
        //             'images/loupe.png',
        //             color: Colors.white,
        //             height: 24,
        //           ),
        //           rtl: true,
        //           width: MediaQuery.of(context).size.width,
        //           textController: textController,
        //           onSuffixTap: () {
        //             setState(() {
        //               textController.clear();
        //             });
        //           },
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ),
      body: isLoading
          ? LoadingPage()
          : arr == null
              ? NoDataAvailablePage()
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
                    onRefresh: () => getCryptolistandSearchData(),
                    child: ListView.builder(
                      itemCount: arr.length ?? 0,
                      itemBuilder: (c, i) {
                        if (arr[i].coinImageUrl != null) {
                          return CryptoListItem(
                            cyptoName: arr[i].shortName.split(" ")[0] ?? "--",
                            mCap: arr[i].marketCap == null
                                ? "--"
                                : arr[i].marketCap.fmt ?? "--",
                            value: '₹ ' +
                                (arr[i].regularMarketPrice == null
                                    ? "--"
                                    : arr[i].regularMarketPrice.fmt ?? "--"),
                            highlight: arr[i].regularMarketChange == null
                                ? "--"
                                : arr[i].regularMarketChange.fmt +
                                    '(' +
                                    (arr[i].regularMarketChangePercent == null
                                        ? "--"
                                        : arr[i]
                                                    .regularMarketChangePercent
                                                    .fmt[0] ==
                                                "-"
                                            ? arr[i]
                                                .regularMarketChangePercent
                                                .fmt
                                            : "+" +
                                                    arr[i]
                                                        .regularMarketChangePercent
                                                        .fmt ??
                                                "--") +
                                    ')',
                            imageurl: arr[i].coinImageUrl ?? "",
                            onTap: () {
                              pushNewScreen(
                                context,
                                withNavBar: false,
                                screen: ContainPageCrypto(
                                  isList: true,
                                  value:
                                      // widget.value == null ? price :
                                      '₹ ' + arr[i].regularMarketPrice.fmt ??
                                          "",
                                  subValue:
                                      // widget.subValue == null
                                      //     ? chng
                                      //     :
                                      arr[i].regularMarketChange.fmt +
                                          '(' +
                                          arr[i]
                                              .regularMarketChangePercent
                                              .fmt +
                                          ')',
                                  currencyChart: arr[i].symbol.split("-")[0] ??
                                      "" + '/INR',
                                  title:
                                      arr[i].symbol.split("-")[0] ?? "" ?? "--",
                                  defaultWidget: containerMenu[0],
                                  query: arr[i].symbol.split("-")[0] ?? "",
                                ),
                              );
                            },
                            // color: i % 2 == 0
                            //     ? const Color(0xff479fff)
                            //     : const Color(0xffff6880),
                          );
                        } else {
                          return SizedBox(
                            height: 0,
                          );
                        }
                      },
                    ),
                  ),
                ),
    );
  }
}
