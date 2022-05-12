import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../../styles.dart';
import 'cancelled.dart';

class CancelConfirm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 40),
            SvgPicture.asset('assets/icons/Group 4766.svg',
                color: almostWhite, width: 96, height: 96),
            SizedBox(height: 30),
            Text(
              'Sad to see you go.',
              style: TextStyle(color: almostWhite, fontSize: 25),
            ),
            SizedBox(height: 20),
            Text(
              'You currently have 220 days left on your subscription for no additional charges & you won\'t be charged until 21 Oct 2021',
              textAlign: TextAlign.center,
              style: TextStyle(color: white60, fontSize: 14),
            ),
            SizedBox(height: 90),
            Text(
              'Are you sure, you want to cancel now?',
              style: TextStyle(color: almostWhite, fontSize: 16),
            ),
            SizedBox(height: 30),
            FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0)),
                minWidth: 220,
                height: 48,
                color: almostWhite,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Nevermind',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w500))),
            SizedBox(height: 30),
            InkWell(
              onTap: () {
                pushNewScreen(context, screen: Cancelled(), withNavBar: false);
              },
              child: Text(
                'No thanks, I want to cancel',
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
