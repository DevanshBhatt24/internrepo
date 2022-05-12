import 'package:flutter/material.dart';

import '../styles.dart';

class CustomRow extends StatelessWidget {
  final String a;
  final String b;
  final String c;
  final String d;

  const CustomRow(this.a, this.b, this.c, this.d) : super();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(a, style: bodyText2White60),
                SizedBox(height: 4),
                Text(b, style: subtitle1White)
              ],
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(c, textAlign: TextAlign.end, style: bodyText2White60),
                SizedBox(height: 4),
                Text(d, textAlign: TextAlign.right, style: subtitle1White),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class CustomRow2 extends StatelessWidget {
  final String title;
  final String value;

  const CustomRow2(this.title, this.value) : super();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: subtitle1White60),
          SizedBox(
            width: 10,
          ),
          Text(value, style: subtitle1White),
        ],
      ),
    );
  }
}