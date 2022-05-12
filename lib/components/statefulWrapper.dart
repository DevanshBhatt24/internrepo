// Wrapper for stateful functionality to provide onInit calls in stateless widget
import 'package:flutter/material.dart';

class StatefulWrapper extends StatefulWidget {
  final VoidCallback onInit;

  final Widget child;
  const StatefulWrapper({
    @required this.onInit,
    @required this.child,
  })  : assert(onInit != null,
            "If you are not using onInit then there is no reason to use this widget."),
        assert(child != null, "Child should not be null.");

  @override
  _StatefulWrapperState createState() => _StatefulWrapperState();
}

class _StatefulWrapperState extends State<StatefulWrapper> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void initState() {
    super.initState();
    widget.onInit();
  }
}
