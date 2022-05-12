import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:technical_ind/providers/storageProviders.dart';
import 'package:technical_ind/screens/profile/enterYpi.dart';
import 'package:technical_ind/widgets/appbar_with_back_and_search.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../styles.dart';
import 'payoutPage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:technical_ind/widgets/dialoghelper.dart';
import 'package:share/share.dart';

// https://play.google.com/store/apps/details?id=com.paprclip.bottomstreet
class ReferalPage2 extends StatefulWidget {
  @override
  _ReferalPage2State createState() => _ReferalPage2State();
}

class _ReferalPage2State extends State<ReferalPage2> {
  Map<String, dynamic> fireStoreUser;

  @override
  Widget build(BuildContext context) {
    var firestoreUser = context.read(firestoreUserProvider);
    return Scaffold(
      appBar: AppBarWithBack(
        text: 'Invite Friends',
      ),
      body: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/icons/inviteFriend.svg",
              height: 50,
              width: 50,
            ),
            SizedBox(
              height: 27,
            ),
            Text(
              "Refer this App to your friends and family!",
              style: heading1profile,
              textAlign: TextAlign.center,
            ),
            // SizedBox(height: 8),
            // Padding(
            //   padding: const EdgeInsets.only(left: 24, right: 24),
            //   child: Text(
            //     "Earn 10% bonus whenever your referrals recharge for a monthly or yearly plan . Receive comission directly in your bank account.",
            //     style: subtitle1profile,
            //     textAlign: TextAlign.center,
            //   ),
            // ),
            // SizedBox(
            //   height: 8,
            // ),
            // GestureDetector(
            //   onTap: () async {
            //     launch("https://www.bottomstreet.com/referal-program.php");
            //   },
            //   child: Text(
            //     'Learn more',
            //     style: subtitle1profileblue,
            //     textAlign: TextAlign.center,
            //   ),
            // ),
            SizedBox(height: 123),
            TextButton(
              onPressed: () async {
                Share.share("""Try Bottom Street! A investment info app goes deep in each investing segment and provides you with categorized tools you need to make smart investment decisions and grow your portfolio.
Click the link below.
https://play.google.com/store/apps/details?id=com.paprclip.bottomstreet""",
                  subject : "BottomStreet",
                    );
                // firestoreUser['status'] != 'onTrial'
                //     ?
                // pushNewScreen(context, screen: EnterUPIpage())
                // : DialogHelper.exit(context);
                // // pushNewScreen(context, screen: EnterUPIpage());
              },
              child: Container(
                height: 48,
                width: 296,
                decoration: BoxDecoration(
                  color: Color(0xFF007AFF),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Center(
                  child: Text(
                    'Get started',
                    style: GoogleFonts.ibmPlexSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.1,
                      color: Color(0xFFFFF6F6),
                    ),
                  ),
                ),
              ),
            )
            // InkWell(
            //   onTap: () {
            //     context.read(navBarVisibleProvider).controller.jumpToTab(0);
            //   },
            //   child: Container(
            //     height: 40,
            //     width: 220,
            //     decoration: BoxDecoration(
            //         color: darkGrey, borderRadius: BorderRadius.circular(6)),
            //     child: Center(
            //       child: Text(
            //         "Search",
            //         style: buttonWhite.copyWith(color: blue),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
