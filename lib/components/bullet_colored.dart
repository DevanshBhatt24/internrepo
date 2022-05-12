import 'package:flutter/material.dart';

import '../styles.dart';

class BulletColored extends StatelessWidget {
  final String a;
  final String status;
  final Color color;

  const BulletColored(this.a, this.color, {this.status = null}) : super();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              SizedBox(height: 6),
              CircleAvatar(backgroundColor: color, radius: 3),
            ],
          ),
          SizedBox(width: 8),
          status == null
              ? SizedBox()
              : Expanded(
                  child: SizedBox(
                    child: Text(
                      status,
                      style: bodyText2White.copyWith(color: white60),
                    ),
                  ),
                ),
          Expanded(
            child: SizedBox(
              child: Text(
                a,
                style: bodyText2White,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
