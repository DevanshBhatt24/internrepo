import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import '../../../styles.dart';
import 'activeSubcription.dart';

class PlanActive extends StatelessWidget {
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
              child: Text('Hi Gupil Kapoor, Welcome to the squad!',
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
              child: Text('Monthly Plan activated on 19 Dec 2020',
                  style: TextStyle(color: Colors.green, fontSize: 16),
                  textAlign: TextAlign.center),
            ),
            SizedBox(height: 70),
            FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0)),
                minWidth: 1 * MediaQuery.of(context).size.width,
                height: 48,
                color: blue,
                onPressed: () {
                  pushNewScreen(context,
                      screen: ActiveSubscription(), withNavBar: false);
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
}
