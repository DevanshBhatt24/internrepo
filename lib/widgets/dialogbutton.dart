import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:technical_ind/screens/profile/account/subscription.dart';

import '../styles.dart';

class DialogButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(3),
      ),
      elevation: 0,
      backgroundColor: Color(0xff1C1C1E),
      child: Container(
        height: 262,
        width: 316,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Stack(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                child: IconButton(
                  icon: Icon(Icons.clear_rounded),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
            Positioned(
              top: 84,
              bottom: 114,
              left: 57,
              right: 57,
              child: Text(
                "You need an active plan to continue.",
                textAlign: TextAlign.center,
                style: GoogleFonts.ibmPlexSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  // letterSpacing: 0.1,
                  color: white,
                ),
              ),
            ),
            SizedBox(height: 24),
            Positioned(
              left: 65,
              right: 65,
              bottom: 56,
              child: FlatButton(
                onPressed: () {
                  pushNewScreen(context, screen: Subscription());
                },
                child: Container(
                  height: 34,
                  width: 185,
                  decoration: BoxDecoration(
                    color: Color(0xFF007AFF),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      'Recharge',
                      style: GoogleFonts.ibmPlexSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.1,
                          color: Color(0xFFFFF6F6)),
                    ),
                  ),
                ),
              ),
            ),
            // SizedBox(height: ),
          ],
        ),
      ),
    );
  }
}
