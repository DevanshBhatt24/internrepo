import 'package:flutter/material.dart';
import 'dialogbutton.dart';
import '../widgets/dialoghelperfeedback.dart';

class DialogHelper {
  static exit(context) =>
      showDialog(context: context, builder: (context) => DialogButton());
}

class DialogHelperFeedback {
  static exit(context) => showDialog(
      context: context, builder: (context) => DialogButtonFeedback());
}
