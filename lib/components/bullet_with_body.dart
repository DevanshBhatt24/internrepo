import 'package:flutter/material.dart';


import '../styles.dart';

class BulletWithBody extends StatelessWidget {
  final String a;
  final String b;
  final Color color;

  const BulletWithBody(this.a, this.b, this.color) : super();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(backgroundColor: color, radius: 3),
              SizedBox(width: 8),
              Text(
                a,
                style: buttonWhite,
              ),
            ],
          ),
          SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 14),
              SizedBox(
                  width: 1 * MediaQuery.of(context).size.width - 50, child: Text(b, style: bodyText2White60))
            ],
          )
        ],
      ),
    );
  }
}
