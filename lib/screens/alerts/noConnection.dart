import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:technical_ind/main.dart';

import '../../styles.dart';

class NoConnectionPage extends StatefulWidget {
  const NoConnectionPage({Key key}) : super(key: key);

  @override
  _NoConnectionPageState createState() => _NoConnectionPageState();
}

class _NoConnectionPageState extends State<NoConnectionPage> {
  StreamSubscription<ConnectivityResult> subscription;

  @override
  void initState() {
    super.initState();
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => StartView()),
            (route) => false);
      }
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        var result = await Connectivity().checkConnectivity();
        if (result == ConnectivityResult.none) return false;
        return true;
      },
      child: Material(
        child: Container(
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/no-signal.svg",
                      ),
                      SizedBox(
                        height: 44,
                      ),
                      Text(
                        "No Connection",
                        style: headline5White,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Please check your internet connection\nand try again",
                        textAlign: TextAlign.center,
                        style: subtitle2White60,
                      )
                    ],
                  ),
                )
                // Column(
                //   children: List.generate(
                //       result.length,
                //       (index) => _buildListItem(
                //           "assets/icons/search.svg", result[index])),
                // ),
                // _buildRecentAndTrending(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
