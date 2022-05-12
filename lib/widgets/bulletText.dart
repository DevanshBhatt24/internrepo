import 'package:flutter/material.dart';


import '../styles.dart';

class BulletText extends StatelessWidget {
  final bool bullet;
  final Color color;
  final String text;

  const BulletText(this.text, {Key key, this.bullet, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('• ', style: bodyText2White60.copyWith(color: color)),
          Container(
            width: 1 * MediaQuery.of(context).size.width - 50,
            child: Text(
              text,
              style: bodyText2White60,
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }
}
