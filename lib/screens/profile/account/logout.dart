import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../onboarding/authentication/auth_wrapper.dart';
import '../../../providers/authproviders.dart';
import '../../../styles.dart';

class Logout extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final _auth = watch(authServicesProvider);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 60),
            SvgPicture.asset('assets/icons/logout-circle-r-line.svg',
                color: almostWhite, width: 96, height: 96),
            SizedBox(height: 30, width: 1 * MediaQuery.of(context).size.width),
            Text(
              'You will be missed',
              style: TextStyle(color: almostWhite, fontSize: 25),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 250,
              child: Text(
                'Risk comes from not knowing what you\'re doing.',
                textAlign: TextAlign.center,
                style: TextStyle(color: white60, fontSize: 14),
              ),
            ),
            SizedBox(
              width: 250,
              child: Row(children: [
                Expanded(child: Container()),
                Text('-Warren Buffett',
                    style: TextStyle(color: white60, fontSize: 14)),
              ]),
            ),
            SizedBox(height: 90),
            Text(
              'Are you sure, you want to logout?',
              style: TextStyle(color: almostWhite, fontSize: 16),
            ),
            SizedBox(height: 20),
            FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0)),
                minWidth: 220,
                height: 48,
                color: Color.fromRGBO(255, 46, 80, 1),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancel',
                    style: TextStyle(
                        fontSize: 14,
                        color: almostWhite,
                        fontWeight: FontWeight.w500))),
            SizedBox(height: 30),
            InkWell(
              onTap: () async {
                await _auth.signOut().whenComplete(() => Navigator.of(context)
                    .pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                AuthenticationWrapper()),
                        (route) => false));
              },
              child: Text(
                'Yes, logout',
                style: TextStyle(
                    color: Color.fromRGBO(255, 46, 80, 1),
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
