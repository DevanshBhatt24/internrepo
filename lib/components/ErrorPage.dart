import 'package:flutter/material.dart';

import '../styles.dart';

class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Center(
        child: Text(
          "Some Error Occurred.",
          style: headline6,
        ),
      ),
    );
  }
}
