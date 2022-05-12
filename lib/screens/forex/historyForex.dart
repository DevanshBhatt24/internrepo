import 'package:flutter/material.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import '../../styles.dart';
import '../../widgets/datagrid.dart';

class HistoryPageForex extends StatefulWidget {
  HistoryPageForex({Key key}) : super(key: key);

  @override
  _HistoryPageForexState createState() => _HistoryPageForexState();
}

class _HistoryPageForexState extends State<HistoryPageForex> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: TabBar(
          labelStyle: buttonWhite,
          unselectedLabelColor: Colors.white38,
          //indicatorSize: TabBarIndicatorSize.label,
          indicator: MaterialIndicator(
            horizontalPadding: 24,
            bottomLeftRadius: 8,
            bottomRightRadius: 8,
            color: almostWhite,
            paintingStyle: PaintingStyle.fill,
          ),
          tabs: [
            Tab(
              text: "Daily",
            ),
            Tab(
              text: "Weekly",
              //child: NSEtab(),
            ),
            Tab(
              text: "Monthly",
              //child: NSEtab(),
            ),
          ],
        ),
        body: TabBarView(
          children: [
            _historyBuilder(),
            _historyBuilder(),
            _historyBuilder(),
          ],
        ),
      ),
    );
  }

  Padding _historyBuilder() {
    return Padding(
      padding: const EdgeInsets.only(right: 16, left: 16, top: 24),
      child: CustomTable(
        headersTitle: ["DATE", "PRICE", "OPEN", "HIGH", "LOW", "VOL", "CHG %"],
        fixedColumnWidth: 112,
        columnwidth: 72,
        totalColumns: 7,
        itemCount: 20,
        leftSideItemBuilder: (c, i) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text("Oct 13,2020",
                textAlign: TextAlign.left, style: subtitle2White),
          );
        },
        rightSideItemBuilder: (c, i) => DataTableItem(
          data: [
            "3108.15",
            "3108.15",
            "3108.15",
            "3108.15",
            "3108.15",
            "-1.45 %",
          ],
          color: i % 2 == 0 ? blue : red,
        ),
      ),
    );
  }
}
