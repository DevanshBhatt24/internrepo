import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import '../../../providers/storageProviders.dart';
import '../../../styles.dart';
import '../../../widgets/appbar_with_back_and_search.dart';
import 'planActive.dart';

class FreeTrial extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final u = watch(firestoreUserProvider);

    DateTime dateTime = DateTime.parse(u['EndDate']);
    String expiresOn = DateTimeFormat.format(dateTime, format: 'D, M j');
    return Scaffold(
      appBar: AppBarWithBack(text: 'Subscription', height: 40),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 40),
            SvgPicture.asset('assets/icons/time-line.svg',
                color: almostWhite, width: 92, height: 92),
            SizedBox(height: 20),
            SizedBox(
              width: 280,
              child: Text('Free Trial Activated. Expires on $expiresOn ',
                  style: TextStyle(color: almostWhite, fontSize: 25),
                  textAlign: TextAlign.center),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 282,
              child: Text('You will not be billed during your free trial.',
                  style: TextStyle(color: white60, fontSize: 14),
                  textAlign: TextAlign.center),
            ),
            SizedBox(height: 180),
            FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0)),
                minWidth: 1 * MediaQuery.of(context).size.width,
                height: 48,
                color: blue,
                onPressed: () {
                  pushNewScreen(context,
                      screen: PlanActive(), withNavBar: false);
                },
                child: Text('Join the squad',
                    style: TextStyle(
                        fontSize: 14,
                        color: almostWhite,
                        fontWeight: FontWeight.w500)))
          ],
        ),
      ),
    );
  }
}
