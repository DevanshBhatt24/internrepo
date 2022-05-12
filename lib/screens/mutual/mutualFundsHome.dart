import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:technical_ind/screens/landingPage.dart';
import 'package:technical_ind/screens/search/business/model.dart';

//import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../animated_search_bar.dart';
import '../../styles.dart';
import '../../widgets/appbar_with_back_and_search.dart';
import 'fundsPage.dart';
import 'package:http/http.dart' as http;

class MutualFundsHome extends StatefulWidget {
  MutualFundsHome({Key key}) : super(key: key);

  @override
  _MutualFundsHomeState createState() => _MutualFundsHomeState();
}

class _MutualFundsHomeState extends State<MutualFundsHome> {
  List<String> titles = [
    "All Mutual Funds",
    "Top Tax Saver Funds",
    "Better Than Fixed Deposits",
    "Low Cost High Return Funds",
    "Best Hybrid Funds",
    "Best Large Cap Funds",
    "Top Performing Mid Caps",
    "Top Rated Funds"
  ];
  List<String> codes = [
    "ALL",
    'TOP_TAX_SAVER',
    'BETTER_THAN_FIXED_DEPOSITS',
    'LOW_COST_HIGH_RETURN_FUNDS',
    'BEST_HYBRID_FUNDS',
    'BEST_LARGE_CAP_FUNDS',
    'TOP_PERFORMING_MID_CAPS',
    'TOP_RATED_FUNDS',
  ];

  var jsonText;
  List<StockSearch> stocks;
  List<IndicesSearch> indices;
  List<FundEtfSearch> fundsEtf;
  List<EtfSearch> etf;
  List<ForexSearch> forex;
  List<CryptoSearch> crypto;
  List<CommoditySearch> commodity;
  bool isLoading = false;
  TextEditingController textController = TextEditingController();

  // _loadJson() async {
  //   // try {
  //   //   jsonText = await http.get(Uri.parse(
  //   //       'https://api.bottomstreet.com/api/data?page=stocks_isin_list'));
  //   //   print("done");
  //   //   stocks = stockSearchFromJson(jsonText.body);
  //   // } catch (e) {
  //   //   print('this is the error ${e.toString()}');
  //   // }
  //   if (gstocks == null) {
  //     jsonText = (await http.get(Uri.parse(
  //             "https://api.bottomstreet.com/api/data?page=stocks_isin_list")))
  //         .body;
  //     // await rootBundle.loadString('assets/instrument/stocks_list.json');
  //     print("done");
  //     gstocks = stockSearchFromJson(jsonText);
  //     jsonText = await rootBundle.loadString('assets/instrument/indices.json');
  //     print("done");
  //     gindices = indicesSearchFromJson(jsonText);
  //     jsonText = await rootBundle.loadString('assets/instrument/fundsEtf.json');
  //     print("done");
  //     gfundsEtf = fundEtfSearchFromJson(jsonText);
  //     jsonText = await rootBundle
  //         .loadString('assets/instrument/investing_etf_list.json');
  //     print("done");
  //     getf = etfSearchFromJson(jsonText);
  //     jsonText = await rootBundle.loadString('assets/instrument/forex.json');
  //     print("done");
  //     gforex = forexSearchFromJson(jsonText);
  //     jsonText = await rootBundle.loadString('assets/instrument/crypto.json');
  //     print("done");
  //     gcrypto = cryptoSearchFromJson(jsonText);
  //   }

  //   // jsonText = await rootBundle.loadString('assets/instrument/commodity.json');
  //   // print("done");
  //   // commodity = commoditySearchFromJson(jsonText);
  //   setState(() {
  //     isLoading = false;
  //   });
  // }

  @override
  void initState() {
    super.initState();
    // _loadJson();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics.instance.setCurrentScreen(screenName: 'Mutual Funds');
    return Scaffold(
      appBar: AppBarWithBack(
        text: "Mutual Funds",
        //height: 40,
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                physics: ClampingScrollPhysics(),
                itemCount: titles.length,
                itemBuilder: (c, i) {
                  return _customListTile(titles[i], codes[i]);
                },
              ),
            ),
          ],
        ),
      ),
      // body: Container(
      //   // margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
      //   child: Stack(
      //     children: [
      //       Container(
      //         child: Column(
      //           children: [
      //             AppBarWithBack(
      //               text: "Mutual Funds",
      //             ),
      //             Expanded(
      //               child: ListView.builder(
      //                 physics: ClampingScrollPhysics(),
      //                 itemCount: titles.length,
      //                 itemBuilder: (c, i) {
      //                   return _customListTile(titles[i], codes[i]);
      //                 },
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //       // Container(
      //       //   margin: EdgeInsets.fromLTRB(0, 8, 20, 0),
      //       //   child: AnimatedSearchBar(
      //       //     stocks: gstocks,
      //       //     indices: gindices,
      //       //     fundsEtf: gfundsEtf,
      //       //     etf: getf,
      //       //     forex: gforex,
      //       //     crypto: gcrypto,
      //       //     commodity: gcommodity,
      //       //     color: Colors.black,
      //       //     onSubmit: (value) {
      //       //       print('submitted search : $value');
      //       //     },
      //       //     style: TextStyle(
      //       //       color: Colors.white,
      //       //     ),
      //       //     closeSearchOnSuffixTap: true,
      //       //     suffixIcon: Icon(
      //       //       Icons.close,
      //       //       color: Colors.white,
      //       //     ),
      //       //     prefixIcon: Image.asset(
      //       //       'images/loupe.png',
      //       //       color: Colors.white,
      //       //       height: 24,
      //       //     ),
      //       //     rtl: true,
      //       //     width: MediaQuery.of(context).size.width,
      //       //     textController: textController,
      //       //     onSuffixTap: () {
      //       //       setState(() {
      //       //         textController.clear();
      //       //       });
      //       //     },
      //       //   ),
      //       // ),
      //     ],
      //   ),
      // ),
    );
  }

  Widget _customListTile(String title, String code) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16),
      title: new Text(title,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w500, color: almostWhite)),
      trailing: Icon(
        CupertinoIcons.forward,
        color: white60,
      ),
      onTap: () {
        pushNewScreen(context,
            screen: FundsPage(
              title: title,
              code: code,
            ));
      },
    );
  }

  Container builditem(String title, String desc) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: darkGrey,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: subtitle1.copyWith(color: almostWhite)),
          SizedBox(
            height: 4,
          ),
          Text(desc, style: bodyText2.copyWith(color: white60)),
          SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }
}
