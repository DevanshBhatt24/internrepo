import 'package:flutter/material.dart';

import '../styles.dart';
//import 'package:flutter_screenutil/flutter_screenutil.dart';

class SummaryChart extends StatefulWidget {
  int index;

  SummaryChart({Key key, this.index}) : super(key: key);

  @override
  _SummaryChartState createState() => _SummaryChartState();
}

class _SummaryChartState extends State<SummaryChart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //duration: Duration(milliseconds: 500),
      height: 300,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 500),
                width: widget.index == 0 ? 12 : 8,
                color: blue,
              ),
            ),
          ),
          Expanded(
            child: AnimatedContainer(
              duration: Duration(milliseconds: 500),
              width: widget.index == 1 ? 12 : 8,
              color: blue.withOpacity(0.6),
            ),
          ),
          Expanded(
            child: AnimatedContainer(
              duration: Duration(milliseconds: 500),
              width: widget.index == 2 ? 12 : 8,
              color: yellow,
            ),
          ),
          Expanded(
            child: AnimatedContainer(
              duration: Duration(milliseconds: 500),
              width: widget.index == 3 ? 12 : 8,
              color: red.withOpacity(0.6),
            ),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30)),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 500),
                width: widget.index == 4 ? 12 : 8,
                color: red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
