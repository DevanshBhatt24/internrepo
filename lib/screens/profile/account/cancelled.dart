import 'package:flutter/material.dart';


import '../../../styles.dart';

class Cancelled extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(child: Container()),
            Text(
              'Your Subscription has been cancelled.',
              textAlign: TextAlign.center,
              style: TextStyle(color: almostWhite, fontSize: 25),
            ),
            SizedBox(height: 10),
            Text(
              'You will not be charged further',
              style: TextStyle(color: white60, fontSize: 14),
            ),
            Expanded(child: Container()),
            FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0)),
                minWidth: 1 * MediaQuery.of(context).size.width,
                height: 48,
                color: blue,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Renew Subscription',
                    style: TextStyle(
                        fontSize: 14,
                        color: almostWhite,
                        fontWeight: FontWeight.w500))),
          ],
        ),
      ),
    );
  }
}
