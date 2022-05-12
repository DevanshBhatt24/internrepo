import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../../styles.dart';
import '../../../widgets/appbar_with_back_and_search.dart';
import 'cancel.dart';

class ActiveSubscription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithBack(text: 'Subscription', height: 40),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            Center(
              child: Text(
                'Active Subcription',
                style: TextStyle(color: almostWhite, fontSize: 16),
              ),
            ),
            SizedBox(height: 30),
            Center(
              child: Text(
                '₹ 300/ Month',
                style: TextStyle(color: almostWhite, fontSize: 35),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Next Billing date ',
                  style: TextStyle(color: almostWhite, fontSize: 12),
                ),
                Text(
                  '21 Oct 2021',
                  style: TextStyle(color: Colors.green, fontSize: 12),
                ),
              ],
            ),
            SizedBox(height: 40),
            Text(
              'Plan includes',
              style: TextStyle(color: almostWhite, fontSize: 16),
            ),
            SizedBox(height: 20),
            _row('Unlimited Watchlist'),
            _row('End-to-End Encryption'),
            _row('Real-time Data'),
            _row('Transparent Data Policy'),
            _row('Live News'),
            _row('No Ads'),
            _row('Zero 3rd Party Access'),
            _row('Complete Financial Coverage'),
            SizedBox(height: 50),
            Center(
              child: InkWell(
                onTap: () {
                  pushNewScreen(context,
                      screen: CancelConfirm(), withNavBar: false);
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.red, fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _row(String s) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: almostWhite, size: 20),
          SizedBox(width: 15),
          Text(s, style: TextStyle(fontSize: 14, color: almostWhite)),
        ],
      ),
    );
  }
}
