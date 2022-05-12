import 'package:flutter/material.dart';

import '../styles.dart';

class Heading extends StatelessWidget {
  final String text;

  const Heading({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text, style: subtitle1White);
  }
}
