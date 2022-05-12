import 'package:flutter/material.dart';
import '../etf/business/models/etf_explore_model.dart';
import '../../styles.dart';
import '../../widgets/datagrid.dart';
import '../../widgets/miss.dart';
import '../../widgets/tableItem.dart';

class Analysis extends StatefulWidget {
  static List<String> sept = [
    '29',
    '58.85 %',
    '81.26 %',
    'Infosys',
    '27',
    '81.26 %',
    '58.85 %',
    'Technology'
  ];

  static List<String> jun = [
    '29',
    '58.85 %',
    '81.26 %',
    'Infosys',
    '27',
    '81.26 %',
    '58.85 %',
    'Technology'
  ];
  static List<String> mar = [
    '29',
    '58.85 %',
    '81.26 %',
    'Infosys',
    '27',
    '81.26 %',
    '58.85 %',
    'Technology'
  ];
  static List<String> dec = [
    '29',
    '58.85 %',
    '81.26 %',
    'Infosys',
    '27',
    '81.26 %',
    '58.85 %',
    'Technology'
  ];
  static List<String> sept1 = [
    '29',
    '58.85 %',
    '81.26 %',
    'Infosys',
    '27',
    '81.26 %',
    '58.85 %',
    'Technology'
  ];
  final History history;
  final Factsheet factsheet;
  Analysis({this.history, this.factsheet});
  @override
  _AnalysisState createState() => _AnalysisState();
}

class _AnalysisState extends State<Analysis> {
  List<String> head = [
    'Number Of Holdings',
    'Top 10 Company Holdings',
    'Top 5 Company Holdings',
    'Company with Highest Exposure',
    'Number of Sector',
    'Top 5 Sector Holdings',
    'Top 3 Sector Holdings',
    'Sectors with Highest Exposure'
  ];

  final data1 = [
    Analysis.sept,
    Analysis.jun,
    Analysis.mar,
    Analysis.dec,
    Analysis.sept1
  ];

  List<String> _list = [];

  History history;
  @override
  void initState() {
    super.initState();
    history = widget.history;
    // history.concentrationAnalysis[0].toJson().forEach((key, value) {
    //   _list.add(key);
    // });
    _list.removeLast();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // SizedBox(height: 24),
            // Text(
            //   'Parag Parikh Long Term Equity Fund Direct - Growth',
            //   style: headline5White,
            //   textAlign: TextAlign.center,
            // ),
            SizedBox(height: 28),
            _returns(history),
            SizedBox(height: 40),
            Center(
              child: Text('Style Analysis',
                  textAlign: TextAlign.center, style: subtitle1White),
            ),
            Center(
              child: Text('(2020)',
                  textAlign: TextAlign.center, style: captionWhite60),
            ),
            SizedBox(height: 18),
            TableBar(
              title1: "MONTH",
              title2: "VALUATION",
              title3: "MKT CAP",
            ),
            SizedBox(height: 2),
            Column(
              children: List.generate(
                history.styleAnalysis.length,
                (index) => TableItem(
                  title: history.styleAnalysis[index].month,
                  value: history.styleAnalysis[index].valuation,
                  remarks: history.styleAnalysis[index].marketCaptalization,
                ),
              ),
            ),
            SizedBox(height: 38),
            Center(
              child: Text('Valuation Metrics',
                  textAlign: TextAlign.center, style: subtitle1White),
            ),
            SizedBox(height: 32),
            car('Parag Parikh Long Term Equity Fund Direct-Growth'),
            car('Equity Multi Cap'),
            SizedBox(height: 44),
            Center(
              child: Text(
                'Market Capitalisation',
                textAlign: TextAlign.center,
                style: subtitle1White,
              ),
            ),
            SizedBox(height: 20),
            TableBar(
              title1: "MKT CAP",
              title2: "FUND",
              title3: "CATEGORY",
            ),
            SizedBox(height: 2),
            // Column(
            //   children: List.generate(
            //     widget.factsheet.marketcapData.length,
            //     (index) => TableItem(
            //       title: widget.factsheet.marketcapData[index].mktCap,
            //       value: widget.factsheet.marketcapData[index].fund,
            //       remarks: widget.factsheet.marketcapData[index].category,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget car(String s) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        child: Card(
          color: darkGrey,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: Column(
              children: [
                Center(
                  child: Text(s,
                      textAlign: TextAlign.center, style: subtitle1White),
                ),
                SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('26.35', style: subtitle2White),
                        Text('Price Earnings', style: captionWhite60)
                      ],
                    ),
                    SizedBox(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('2.35', style: subtitle2White),
                        Text('Price to Book Value', style: captionWhite60)
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        width: 1 * MediaQuery.of(context).size.width);
  }

  Widget text(String s) {
    return Container(
      height: 52,
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 7),
        child: Text(s, textAlign: TextAlign.left, style: subtitle2White60),
      ),
    );
  }

  Widget _returns(History history) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text('Concentration Analysis',
              textAlign: TextAlign.center, style: subtitle1White),
        ),
        SizedBox(height: 26),
        Container(
          height: 468,
          child: CustomTable(
            scrollPhysics: NeverScrollableScrollPhysics(),
            headersTitle: [
              "",
              ..._list,
            ],
            fixedColumnWidth: 148,
            columnwidth: 90,
            totalColumns: _list.length + 1,
            itemCount: head.length,
            leftSideItemBuilder: (c, i) {
              return text(head[i]);
            },
            rightSideItemBuilder: (c, i) {
              return Center(
                child: Container(
                  height: 52,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: List.generate(
                      5,
                      (index) => Container(
                        width: 90,
                        child: Text(data1[index][i],
                            textAlign: TextAlign.center, style: subtitle2White),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
