import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../styles.dart';
import '../profile/account/subscription.dart';

class SubEndedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            SvgPicture.asset('assets/icons/Solid.svg',
                color: almostWhite, width: 92, height: 92),
            SizedBox(height: 20),
            SizedBox(
              width: 265,
              child: Text('Your subcription has Ended',
                  style: TextStyle(color: almostWhite, fontSize: 25),
                  textAlign: TextAlign.center),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 282,
              child: Text(
                  'Thank you for trying Bottomstreet. To continue please Join us.',
                  style: subtitle1,
                  textAlign: TextAlign.center),
            ),
            SizedBox(height: 58),
            SizedBox(
              width: 282,
              child: Text(
                  '"Don\'t look for the needle in the haystack. Just buy the haystack!" — John Bogle',
                  style: TextStyle(color: white60, fontSize: 14)),
            ),
            SizedBox(height: 133),
            FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0)),
                minWidth: 200,
                height: 48,
                color: blue,
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => Subscription()),
                      (route) => false);
                },
                child: Center(
                  child: Text('Join now',
                      style: TextStyle(
                          fontSize: 14,
                          color: almostWhite,
                          fontWeight: FontWeight.w500)),
                ))
          ],
        ),
      ),
    );
  }
}
