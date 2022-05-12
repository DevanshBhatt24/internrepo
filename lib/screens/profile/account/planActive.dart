import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

import '../../../onboarding/authentication/auth_wrapper.dart';
import '../../../providers/authproviders.dart';
import '../../../styles.dart';

class PlanActive extends StatelessWidget {
  final Map<String, dynamic> user;
  final String planTime;
  final bool isSub;
  const PlanActive({Key key, this.user, this.planTime, this.isSub})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            // SvgPicture.asset('assets/icons/checkbox-circle-line.svg',
            //     color: blue, width: 92, height: 92),
            Lottie.asset('assets/instrument/animation_tick.json',
                height: 92, width: 92, repeat: false),
            SizedBox(height: 20),
            SizedBox(
              width: 265,
              child: Text(
                  'Hi ' + getUserName(context) + ', Welcome to the squad!',
                  style: TextStyle(color: almostWhite, fontSize: 25),
                  textAlign: TextAlign.center),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 282,
              child: Text('An Investment in knowledge pays the best interest.',
                  style: TextStyle(color: white60, fontSize: 14),
                  textAlign: TextAlign.center),
            ),
            SizedBox(
              width: 282,
              child: Row(children: [
                Expanded(child: Container()),
                Text('- Benjamin Franklin',
                    style: TextStyle(color: white60, fontSize: 14)),
              ]),
            ),
            SizedBox(height: 40),
            SizedBox(
              width: 200,
              child: Text(
                  (isSub
                          ? 'Current plan extended till '
                          : '$planTime Plan activated till ') +
                      DateTimeFormat.format(DateTime.parse(user['EndDate']),
                          format: 'D, M j Y'),
                  style: TextStyle(color: Colors.green, fontSize: 16),
                  textAlign: TextAlign.center),
            ),
            SizedBox(height: 70),
            FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0)),
                minWidth: MediaQuery.of(context).size.width,
                height: 48,
                color: blue,
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AuthenticationWrapper()),
                      (route) => false);
                },
                child: Text('Let\'s go',
                    style: TextStyle(
                        fontSize: 14,
                        color: almostWhite,
                        fontWeight: FontWeight.w500)))
          ],
        ),
      ),
    );
  }

  String getUserName(BuildContext context) {
    var user = context.read(authServicesProvider).currentUser;
    return user.displayName;
  }
}
