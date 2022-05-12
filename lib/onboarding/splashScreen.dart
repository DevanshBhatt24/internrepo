import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:technical_ind/screens/News/business/model.dart';
import 'package:technical_ind/screens/News/business/newsNotifications.dart';
import 'package:technical_ind/screens/News/business/newsServices.dart';
import 'package:technical_ind/screens/News/newsDetails.dart';

// import 'package:technical_ind/onboarding/startScreen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:technical_ind/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.black,
        child: Stack(
          children: [
            Positioned.fill(
                child: Center(
              child: Image.asset("assets/startIcons/splashImage.png"),
            )),
            Positioned(
              bottom: 90,
              left: 0,
              right: 0,
              child: Text(
                "Bottom Street",
                style: GoogleFonts.workSans(
                  fontSize: 32.0,
                  color: Colors.white.withOpacity(0.87),
                  letterSpacing: -0.04,
                  height: 5.0,
                ),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    // Timer(
    //     Duration(seconds: 2),
    //     () => Navigator.of(context).pushReplacement(
    //         MaterialPageRoute(builder: (BuildContext context) => NavC())));
  }
}
