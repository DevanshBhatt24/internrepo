import 'dart:core';

import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
// import 'package:flutter_appavailability/flutter_appavailability.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:technical_ind/onboarding/authentication/auth.dart';
import 'package:technical_ind/providers/authproviders.dart';
import 'package:technical_ind/styles.dart';

class CheckEmail extends StatefulWidget {
  final String email;

  CheckEmail({Key key, this.email}) : super(key: key);

  @override
  _CheckEmailState createState() => _CheckEmailState();
}

class _CheckEmailState extends State<CheckEmail> {
  AuthenticationService service;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 70),
            SvgPicture.asset('assets/icons/Group 4776.svg',
                width: 128, height: 128),
            SizedBox(height: 20),
            SizedBox(
              width: 265,
              child: Text('Check your email',
                  style: TextStyle(color: almostWhite, fontSize: 25),
                  textAlign: TextAlign.center),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 282,
              child: Text(
                  'We have sent an email to ${widget.email} with a link to get back into your account ',
                  style: TextStyle(color: white60, fontSize: 14),
                  textAlign: TextAlign.center),
            ),
            SizedBox(height: 40),
            FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0)),
                minWidth: MediaQuery.of(context).size.width,
                height: 48,
                color: blue,
                onPressed: () async {
                  // await AppAvailability.launchApp(Platform.isIOS
                  //         ? "message://"
                  //         : "com.google.android.gm")
                  //     .then((_) {
                  //   print("App Email launched!");
                  // }).catchError((err) {
                  //   BotToast.showText(contentColor: blue,backgroundColor: Colors.white,contentColor: Colors.black,text: "Email App Not Found.");
                  // });
                  // pushNewScreen(context,
                  //     screen: CreateNewPass(), withNavBar: false);
                  await LaunchApp.openApp(
                      androidPackageName: 'com.google.android.gm');
                },
                child: Text('Open Email App', style: subtitle2White)),
            SizedBox(height: 30),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Text('Skip, I\'ll confirm later',
                  style: subtitle2White, textAlign: TextAlign.center),
            ),
            SizedBox(height: 70),
            Text('Did not receive the mail? Check your spam folder',
                style: bodyText2White60, textAlign: TextAlign.center),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('or ', style: TextStyle(color: white60, fontSize: 14)),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text('try another email address',
                      style: TextStyle(color: blue, fontSize: 14)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    context.read(authServicesProvider).resetPassword(widget.email);
  }
}
