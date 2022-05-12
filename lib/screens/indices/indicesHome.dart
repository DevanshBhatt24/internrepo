import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import '../../components/containPage.dart';
import 'forexIndices/forexIndices.dart';
import 'globalIndices/globalIndices.dart';
import 'indianIndices/indianIndices.dart';

class IndicesHome extends StatefulWidget {
  @override
  _IndicesHomeState createState() => _IndicesHomeState();
}

class _IndicesHomeState extends State<IndicesHome> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics.instance.setCurrentScreen(screenName: 'Indices');
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            ContainPage(
              menuWidgets: [
                IndianIndices(),
                GlobalIndices(),
                ForexIndices(),
              ],
              menu: ["Indian Indices", "Global Indices", "Forex Indices"],
              title: "Indices",
              defaultWidget: "Indian Indices",
            ),
          ],
        ),
      ),
    );
  }
}
