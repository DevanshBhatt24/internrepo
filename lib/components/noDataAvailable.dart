import 'package:flutter/material.dart';

class NoDataAvailablePage extends StatelessWidget {
  final String message;
  NoDataAvailablePage({this.message = "No data available"});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        color: Colors.blue,
        child: Center(
          child: Text(
            message,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
