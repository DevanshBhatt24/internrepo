import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:launch_review/launch_review.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_version/new_version.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:technical_ind/components/statefulWrapper.dart';
import 'package:technical_ind/refferal/refferalApi.dart';
import 'package:technical_ind/screens/News/News_home.dart';
import 'package:technical_ind/screens/alerts/noConnection.dart';
import 'package:technical_ind/screens/radar/dalalRoad.dart';
import 'package:technical_ind/screens/rss_feeds/rss_feeds_home.dart';
import 'package:technical_ind/screens/stocks/explore/shareholdingPage.dart';
import 'onboarding/authentication/auth_wrapper.dart';
import 'onboarding/splashScreen.dart';
import 'providers/navBarProvider.dart';
import 'screens/News/business/newsNotifications.dart';
import 'screens/landingPage.dart';
import 'screens/radar/radarHome.dart';
import 'screens/watchlist/watchlistHome.dart';
import 'styles.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

getDynamicLink(BuildContext context) async {
  DynamicLinksApi api = DynamicLinksApi();
  await api.handleDynamicLink(context);
}

var quotes;

class Counter {
  int index = 0;

  int get indexCount {
    return index;
  }

  set indexCount(int x) {
    this.index = x;
  }
}

Counter counter = Counter();
String getQuote() {
  print(quotes['${counter.index}']);
  if (counter.index == 28) {
    counter.indexCount = 0;
  } else
    counter.indexCount++;
  // print(counter.index);
  return quotes['${counter.indexCount}'];
}

Future<void> readJson() async {
  final String response = await rootBundle.loadString('assets/quotes.json');
  quotes = await json.decode(response);
}

Future<void> backgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
// AndroidNotificationChannel channel;

final FirebaseAnalytics firebaseAnalytics = FirebaseAnalytics.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NewsNotifications().initNotification();
  // FirebaseMessaging.onBackgroundMessage(backgroundHandler);

  await Firebase.initializeApp();

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  // channel = const AndroidNotificationChannel(
  //   'bottomstreet', // id
  //   'Bottomstreet Notification', // title
  //   'This is a notification from bottomstreet.', // description
  //   importance: Importance.max,
  // );
  // flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  // await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
  //   alert: true,
  //   badge: true,
  //   // sound: true,
  // );
  // await flutterLocalNotificationsPlugin
  //     .resolvePlatformSpecificImplementation<
  //         AndroidFlutterLocalNotificationsPlugin>()
  //     ?.createNotificationChannel(channel);
  if (kDebugMode) {
    // Force disable Crashlytics collection while doing every day development.
    // Temporarily toggle this to true if you want to test crash reporting in your app.
    await FirebaseCrashlytics.instance.app
        .setAutomaticDataCollectionEnabled(true);
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  } else {
    // Handle Crashlytics enabled status when not in Debug,
    // e.g. allow your users to opt-in to crash reporting.
  }
  // this is for making status bar black (was not working for search page)
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.black));

  await readJson();

  runApp(ProviderScope(child: MyApp()));
  FirebaseMessaging.instance.subscribeToTopic("news");
}

// For initializing (testing purposes) crashes from the app uncomment the
// lines below and test in stateful widget.

// @override
// void initState() {
//   FirebaseCrashlytics.instance.crash();
// }

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final botToastBuilder = BotToastInit();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      builder: (context, widget) {
        widget = botToastBuilder(context, widget);
        widget = MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: widget);
        widget = ResponsiveWrapper.builder(
            BouncingScrollWrapper.builder(context, widget),
            maxWidth: 1200,
            minWidth: 360,
            defaultScale: true,
            breakpoints: [
              ResponsiveBreakpoint.resize(360, name: MOBILE),
              ResponsiveBreakpoint.resize(420, name: MOBILE),
              ResponsiveBreakpoint.autoScale(800, name: TABLET),
              ResponsiveBreakpoint.autoScale(1000, name: TABLET),
              ResponsiveBreakpoint.resize(1200, name: DESKTOP),
              ResponsiveBreakpoint.autoScale(2460, name: "4K"),
            ],
            background: Container(color: Color(0xFFF5F5F5)));
        return widget;
      },
      navigatorObservers: [
        BotToastNavigatorObserver(),
        FirebaseAnalyticsObserver(analytics: firebaseAnalytics),
      ],
      title: 'Bottom Street',
      theme: ThemeData(
          brightness: Brightness.dark,
          fontFamily: "ibmPlexSans",
          primaryColor: Colors.black,
          backgroundColor: Colors.black,
          dividerColor: grey,
          scaffoldBackgroundColor: Colors.black,
          splashColor: grey,
          accentColor: Colors.white.withOpacity(0.87),
          inputDecorationTheme: InputDecorationTheme(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: grey)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: almostWhite)),
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              focusColor: almostWhite,
              labelStyle: bodyText2White60,
              helperStyle: captionWhite60)),
      home: StartView(),
    );
  }
}

class NavC extends ConsumerWidget {
  NavC({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final isVisible = watch(navBarVisibleProvider);

    final List<Widget> screens = [
      LandingPage(),
      DalalRoadPage(),
      RssFeedHome(),
      NewsScreen(),
      WatchListHome(),
    ];

    _checkVersion() async {
      final newVersion = NewVersion(androidId: 'com.paprclip.bottomstreet');
      final status = await newVersion.getVersionStatus();

      if (status.localVersion != status.storeVersion)
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: darkGrey,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 28, horizontal: 20),
                title: Text("UPDATE!"),
                content: Text("Please update the app from " +
                    "${status.localVersion}" +
                    " to " +
                    "${status.storeVersion}"),
                actions: [
                  FlatButton(
                    onPressed: () {
                      LaunchReview.launch(
                        androidAppId: "com.paprclip.bottomstreet",
                        writeReview: false,
                      );
                    },
                    child: Text(
                      "Update",
                      style: button,
                    ),
                    color: blue,
                  )
                ],
              );
            });
    }

    return StatefulWrapper(
      onInit: () {
        _checkVersion();
        Connectivity()
            .onConnectivityChanged
            .listen((result) => _updateConnectionStatus(result, context));
        isVisible.controller.jumpToTab(0);
      },
      child: PersistentTabView(
        context,
        controller: isVisible.controller,
        screens: screens,
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.black,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        hideNavigationBar: isVisible.isNavBarVisible,
        // This needs to be true if you want to move up the screen when keyboard appears.
        stateManagement: true,
        hideNavigationBarWhenKeyboardShows: true,
        // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument.
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(6),
          colorBehindNavBar: Colors.black,
        ),
        itemAnimationProperties: ItemAnimationProperties(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimation(
          // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        padding: NavBarPadding.fromLTRB(16, 8, 20, 20),

        onWillPop: (context) {
          return onWillPop(context);
        },
        navBarStyle: NavBarStyle.style12,
      ),
    );
  }

  Future<bool> onWillPop(BuildContext context) async {
    bool a = false;
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: darkGrey,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 28, horizontal: 20),
              content: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Close BottomStreet?",
                      style: subtitle1White,
                    ),
                    SizedBox(
                      height: 36,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                            child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              //color: blue,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            //color: blue,
                            child: Center(
                                child: Text(
                              "No",
                              style: button.copyWith(color: blue),
                            )),
                          ),
                        )),
                        Expanded(
                            child: InkWell(
                          onTap: () {
                            a = true;
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: blue,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            //color: blue,
                            child: Center(
                                child: Text(
                              "Yes",
                              style: button,
                            )),
                          ),
                        ))
                      ],
                    )
                  ],
                ),
              ),
            ));
    return a;
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: ImageIcon(AssetImage("assets/nav/home.png")),
        title: ("Home"),
        activeColorPrimary: almostWhite,
        inactiveColorPrimary: white38,
      ),
      PersistentBottomNavBarItem(
        icon: ImageIcon(
          AssetImage("assets/nav/light-bulb.png"),
        ),
        title: ("Radar"),
        activeColorPrimary: almostWhite,
        inactiveColorPrimary: white38,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.circle_outlined),
        title: ("PitStop"),
        activeColorPrimary: almostWhite,
        inactiveColorPrimary: white38,
      ),
      PersistentBottomNavBarItem(
        icon: ImageIcon(AssetImage("assets/nav/news.png")),
        title: ("News"),
        activeColorPrimary: almostWhite,
        inactiveColorPrimary: white38,
      ),
      PersistentBottomNavBarItem(
        icon: ImageIcon(AssetImage("assets/nav/watchlist.png")),
        title: ("Watchlist"),
        activeColorPrimary: almostWhite,
        inactiveColorPrimary: white38,
      ),
    ];
  }

  void _updateConnectionStatus(
      ConnectivityResult result, BuildContext context) {
    if (result == ConnectivityResult.none) {
      print("NO CONNECTION");
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => NoConnectionPage()));
    }
  }
}

class StartView extends StatefulWidget {
  static final navigatorKey = new GlobalKey<NavigatorState>();
  @override
  _StartViewState createState() => _StartViewState();
}

class _StartViewState extends State<StartView> {
  int count = 0;
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  ConnectivityResult result;

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        Connectivity().onConnectivityChanged.listen(_updateConnectionStatus);
    getDynamicLink(context);
  }

  Future<void> initConnectivity() async {
    result = ConnectivityResult.none;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }
    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    if (result == ConnectivityResult.none) {
      print("NO CONNECTION");
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => NoConnectionPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text("Something Went wrong"),
          );
        }
        if (snapshot.connectionState == ConnectionState.done &&
            result != ConnectivityResult.none) {
          return AuthenticationWrapper();
        }
        //loading
        else {
          return SplashScreen();
        }
      },
    );
  }
}

class Show extends ChangeNotifier {
  bool show = true;
  void toggleshow() {
    show = false;
    notifyListeners();
  }
}
