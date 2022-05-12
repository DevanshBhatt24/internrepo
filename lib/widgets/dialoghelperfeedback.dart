import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../styles.dart';

class DialogButtonFeedback extends StatelessWidget {
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
              top: 60,
              left: 0,
              right: 0,
              // bottom: 0,
              child: Lottie.asset(
                'assets/instrument/animation_tick.json',
                height: 90,
                width: 90,
                repeat: false,
              ),
            ),
            Positioned(
              // top: 125,
              bottom: 79,
              left: 0,
              right: 0,
              child: Text(
                "Thank you",
                textAlign: TextAlign.center,
                style: GoogleFonts.ibmPlexSans(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  // letterSpacing: 0.1,
                  color: white,
                ),
              ),
            ),
            SizedBox(height: 24),
            Positioned(
              left: 0,
              right: 0,
              bottom: 59,
              child: Text(
                "Your feedback has been submitted",
                textAlign: TextAlign.center,
                style: GoogleFonts.ibmPlexSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  // letterSpacing: 0.1,
                  color: white60,
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
