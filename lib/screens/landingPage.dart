import 'package:date_time_format/date_time_format.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_net_promoter_score/model/nps_survey_texts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:launch_review/launch_review.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:technical_ind/screens/radar/radarHome.dart';
import 'package:technical_ind/screens/search/business/model.dart';
import 'package:technical_ind/screens/search/searchPage.dart';
import '../styles.dart';
import 'bonds/bond.dart';
import 'package:flutter_net_promoter_score/flutter_net_promoter_score.dart';
import 'commodity/commodityhome.dart';
import 'cryptocurrency/cyptoListingPage.dart';
import 'etf/etfHome.dart';
import 'forex/forexPage.dart';
import 'indices/indicesHome.dart';
import 'mutual/mutualFundsHome.dart';
import 'profile/homeProfile.dart';
import 'stocks/stocks_home.dart';
import 'package:shared_preferences/shared_preferences.dart';

BuildContext contextg;
typedef BackgroundMessageHandler = Future<void> Function(RemoteMessage message);

// Future<void> _backgroundMessageHandler(RemoteMessage message) async {
//   if (message.notification != null) {
//     print(message.data["url"]);
//   }
//   print("backgorund message recieved");
//   // NewsNotifications().isLaunchedByNotification();
//   // NewsNotifications().showNotificationNow();

//   return;
// }

List<StockSearch> gstocks;
List<IndicesSearch> gindices;
List<FundEtfSearch> gfundsEtf;
List<EtfSearch> getf;
List<ForexSearch> gforex;
List<CryptoSearch> gcrypto;
List<CommoditySearch> gcommodity;

class LandingPage extends StatefulWidget {
  LandingPage({Key key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _launches = 0;
  bool _hasRated = false;

  List<String> menuItems = [
    "Stocks",
    "Indices",
    "Mutual Funds",
    "ETF",
    "Forex",
    "Cryptocurrency",
    "Commodity",
    "Bonds"
  ];

  List<Widget> menuWidgets = [
    StockHome(
      defaultWidget: "Trending",
    ),
    IndicesHome(),
    MutualFundsHome(),
    EtfHome(),
    ForexPage(),
    CryptoListingPage2(),
    CommodityHome(),
    BondPage(),
  ];

  // var jsonText;
  // List<StockSearch> stocks;
  // List<IndicesSearch> indices;
  // List<FundEtfSearch> fundsEtf;
  // List<EtfSearch> etf;
  // List<ForexSearch> forex;
  // List<CryptoSearch> crypto;
  // List<CommoditySearch> commodity;

  // _loadJson() async {
  //   // try {
  //   //   jsonText = await http.get(Uri.parse(
  //   //       'https://api.bottomstreet.com/api/data?page=stocks_isin_list'));
  //   //   print("done");
  //   //   stocks = stockSearchFromJson(jsonText.body);
  //   // } catch (e) {
  //   //   print('this is the error ${e.toString()}');
  //   // }
  //   jsonText = (await http.get(Uri.parse(
  //           "https://api.bottomstreet.com/api/data?page=stocks_isin_list")))
  //       .body;
  //   // await rootBundle.loadString('assets/instrument/stocks_list.json');
  //   print("done");
  //   stocks = stockSearchFromJson(jsonText);
  //   jsonText = await rootBundle.loadString('assets/instrument/indices.json');
  //   print("done");
  //   indices = indicesSearchFromJson(jsonText);
  //   jsonText = await rootBundle.loadString('assets/instrument/fundsEtf.json');
  //   print("done");
  //   fundsEtf = fundEtfSearchFromJson(jsonText);
  //   jsonText = await rootBundle
  //       .loadString('assets/instrument/investing_etf_list.json');
  //   print("done");
  //   etf = etfSearchFromJson(jsonText);
  //   jsonText = await rootBundle.loadString('assets/instrument/forex.json');
  //   print("done");
  //   forex = forexSearchFromJson(jsonText);
  //   jsonText = await rootBundle.loadString('assets/instrument/crypto.json');
  //   print("done");
  //   crypto = cryptoSearchFromJson(jsonText);
  //   // jsonText = await rootBundle.loadString('assets/instrument/commodity.json');
  //   // print("done");
  //   // commodity = commoditySearchFromJson(jsonText);
  //   if (mounted) {
  //     setState(() {});
  //   }
  // }

  // bool showRefferalPage() {
  //   int today = DateTime.now().day;
  //   if (today % 2 == 0) return true;
  //   return false;
  // }

//  Future<void> _backgroundMessageHandler (RemoteMessage message) async {
//   if (message.notification != null) {
//         print(message.notification.body);
//         print(message.notification.title);
//       }
//       print("--------------------------------\nbackgorund message recieved\n\n\n\n\n\n\n\n\n\n\n");
//       NewsNotifications(context: context).isLaunchedByNotification();
//       NewsNotifications(context: context).showNotificationNow();
//       return;
// }

  @override
  void initState() {
    // contextg = context;
    // _loadJson();
    _loadLaunches();
    _incrementLaunches();
    // FirebaseMessaging.instance.getInitialMessage().then((message) async {
    //   if (message != null) {
    //     // FullArticle farticle =
    //     //     await NewsServices.getFullArticle(message.data["url"]);
    //     String imageUrl = await NewsServices.getImageUrl(message.data["url"]);
    //     FullArticle fullArticle =
    //         await NewsServices.getFullArticle(message.data["url"]);
    //     Article article =
    //         Article(link: message.data["url"], title: fullArticle.title);
    //     pushNewScreen(
    //       context,
    //       screen:
    //           NewsDetails(
    //         article: article,
    //         imageUrl: imageUrl,
    //       ),
    //       withNavBar: false,
    //     );
    //   }
    // });
    // FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);
    // FirebaseMessaging.onMessageOpenedApp.listen((message) async {
    //   if (message != null) {
    //     // Article article = await NewsServices.getLatestArticle("MARKETS");
    //     String imageUrl = await NewsServices.getImageUrl(message.data["url"]);
    //     Article article = Article(link: message.data["url"]);
    //     // String imageUrl = await NewsServices.getImageUrl(article.link);
    //     pushNewScreen(
    //       context,
    //       screen:
    //           // Container(child:Text(article.link)),
    //           NewsDetails(
    //         article: article,
    //         imageUrl: imageUrl,
    //       ),
    //       withNavBar: false,
    //     );
    //   }
    // });
    // FirebaseMessaging.onMessage.listen((message) async {
    //   if (message != null) {
    //     NewsNotifications(context: context).showNotificationNow();
    //   }
    // });

    // NewsDynamicLinks.handleDynamicLinkforNews(context);

    // getToken();
    super.initState();
  }

  // void getToken() async {
  //   print(await FirebaseMessaging.instance.getToken());
  // }

  void _loadLaunches() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _launches = (prefs.getInt('launches') ?? 0);
      _hasRated = (prefs.getBool('hasRated') ?? false);
    });
  }

  //Incrementing launches after click
  void _incrementLaunches() async {
    final prefs = await SharedPreferences.getInstance();
    _loadLaunches();
    if (_launches >= 9 && !_hasRated) {
      _resetLaunches();
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await _showRatingPopup(context);
      });
    }

    setState(() {
      _launches++;
      _launches = (prefs.getInt('launches') ?? 0) + 1;
      prefs.setInt('launches', _launches);
    });
    print(_launches);
  }

  void _resetLaunches() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _launches = 0;
      prefs.setInt('launches', _launches);
    });
    print("reset");
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics.instance.setCurrentScreen(screenName: 'Markets');
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: blue,
        splashColor: grey,
        onPressed: () {
          pushNewScreen(context,
              screen: RadarHome(),
              pageTransitionAnimation: PageTransitionAnimation.cupertino);
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => SearchPage(),
          //         settings: RouteSettings(name: 'SearchPage')));
        },
        child: Container(
          padding: EdgeInsets.only(left: 5),
          height: 38,
          width: 38,
          child: Image.asset(
            'assets/images/chevron.png',
            alignment: Alignment.center,
            color: Colors.white,
          ),
        ),
        // child: Icon(
        //   Icons.search_sharp,
        //   size: 32,
        // ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
            icon: ImageIcon(AssetImage("assets/nav/profile.png")),
            onPressed: () {
              pushNewScreen(context, screen: HomeProfile(), withNavBar: false);
            },
          ),
        ],
        title: Text(DateTime.now().format('j M, l'),
            style: headline5.copyWith(color: white60)),
      ),
      body: Container(
          // height: 560,
          padding:
              const EdgeInsets.only(top: 30, bottom: 10, left: 6, right: 6),
          child: ListView.builder(
            itemBuilder: (c, i) => _buildtile(i),
            itemCount: menuWidgets.length,
            // physics: NeverScrollableScrollPhysics(),
          )
          // Column(
          //   children: [
          //     Expanded(
          //         child: Row(
          //       children: [
          //         Expanded(child: _buildtile(0)),
          //         Expanded(child: _buildtile(1))
          //       ],
          //     )),
          //     Expanded(
          //         child: Row(
          //       children: [
          //         Expanded(child: _buildtile(2)),
          //         Expanded(child: _buildtile(3))
          //       ],
          //     )),
          //     Expanded(
          //         child: Row(
          //       children: [
          //         Expanded(child: _buildtile(4)),
          //         Expanded(child: _buildtile(5))
          //       ],
          //     )),
          //     Expanded(
          //         child: Row(
          //       children: [
          //         Expanded(child: _buildtile(6)),
          //         Expanded(child: _buildtile(7))
          //       ],
          //     )),
          //   ],
          // ),
          ),
    );
  }

  Widget _buildtile(int index) {
    return InkWell(
      onTap: () {
        pushNewScreen(
          context,
          screen: menuWidgets[index],
          withNavBar: true, // OPTIONAL VALUE. True by default.
          pageTransitionAnimation: PageTransitionAnimation.cupertino,
        );
      },
      child: Container(
        height: 52,
        margin: EdgeInsets.all(6),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 6),
            SvgPicture.asset(
              "assets/startIcons/${menuItems[index]}.svg",
              width: 36,
              height: 36,
            ),
            SizedBox(width: 20),
            Text(menuItems[index],
                textAlign: TextAlign.center, style: subtitle18),
            Expanded(child: SizedBox()),
            Icon(Icons.arrow_forward_ios, color: white60, size: 20)
          ],
        ),
      ),
    );
  }

  _notification(int launches) => IconButton(
        icon: new Stack(
          children: <Widget>[
            new Icon(CupertinoIcons.bell),
            new Positioned(
              right: 0,
              child: new Container(
                padding: EdgeInsets.all(1),
                decoration: new BoxDecoration(
                    color: const Color(0xff04df54),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black, width: 2)),
                constraints: BoxConstraints(
                  minWidth: 16,
                  minHeight: 16,
                ),
                child: Center(
                  child: new Text(
                    '$launches',
                    style: new TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            )
          ],
        ),
        onPressed: () {},
      );
}

_showRatingPopup(context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: darkGrey,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          contentPadding: EdgeInsets.symmetric(vertical: 28, horizontal: 20),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/startIcons/rating.png",
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Recommend us to others by rating on Play Store",
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlatButton(
                    onPressed: () async {
                      var prefs = await SharedPreferences.getInstance();
                      prefs.setBool('hasRated', true);

                      LaunchReview.launch();
                    },
                    child: Text(
                      "Rate Us",
                      style: button,
                    ),
                    color: blue,
                  )
                ],
              )
            ],
          ),
          actions: [],
        );
      });
}
// showNetPromoterScore(
//       context: context,
//       texts: NpsSurveyTexts(
//         selectScorePageTexts: NpsSelectScorePageTexts(
//           surveyQuestionText:
//               "How likely are you to recommend Bottom Street to a friend or colleague?",
//         ),
//       ),
//       onSurveyCompleted: (result) {
//         print("NPS Completed");
//         print("Score: ${result.score}");
//         print("Feedback: ${result.feedback}");
//         print("Promoter Type: ${result.promoterType}");
//       },
//       onClosePressed: () {
//         print("User closed the survery");
//       },
//       onScoreChanged: (newScore) {
//         print("User changed the score to $newScore");
//       },
//       onFeedbackChanged: (newFeedback) {
//         print("User change the feedback to $newFeedback");
//       },
//       thankYouIcon: Icon(
//         Icons.thumb_up,
//       ),
//       theme: ThemeData(
//           sliderTheme: SliderThemeData(
//             activeTickMarkColor: Colors.white,
//           ),
//           focusColor: Colors.white,
//           hintColor: Colors.black54,
//           buttonColor: blue,
//           backgroundColor: const Color(0xff1c1c1e),
//           cardColor: black,
//           iconTheme: IconThemeData(color: Colors.white),
//           textTheme: TextTheme(
//               caption: TextStyle(color: Colors.white70),
//               bodyText1: TextStyle(color: Colors.white),
//               button: TextStyle(color: Colors.white),
//               subtitle2: TextStyle(color: Colors.white))));