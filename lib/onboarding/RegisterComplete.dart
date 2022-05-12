import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../main.dart';
import '../styles.dart';

class RegisterComplete extends StatefulWidget {
  RegisterComplete({Key key}) : super(key: key);

  @override
  _RegisterCompleteState createState() => _RegisterCompleteState();
}

class _RegisterCompleteState extends State<RegisterComplete> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              top: 180,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _space(12),
                  // Icon(
                  //   Icons.check_circle_outline,
                  //   size: 96,
                  //   color: blue,
                  // ),
                  Lottie.asset('assets/instrument/animation_tick.json',
                      height: 96, width: 96, repeat: false),
                  _space(28),
                  Text("You did it, You're in.", style: headline5White),
                  _space(16),
                  Text('''The best time to invest is when you 
have money.
                                             - John Templedon''',
                      textAlign: TextAlign.center, style: subtitle1White60),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 90,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => NavC()),
                      (route) => false);
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: blue,
                  ),
                  child: Center(
                    child: Text("Welcome", style: button),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _space(double d) {
    return SizedBox(
      height: d,
    );
  }
}
