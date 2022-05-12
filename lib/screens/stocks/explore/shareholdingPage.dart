import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:technical_ind/components/LoadingPage.dart';
import 'package:technical_ind/components/noDataAvailable.dart';
import 'package:technical_ind/components/slidePanel.dart';
import 'package:technical_ind/screens/stocks/business/stockServices.dart';
import 'package:technical_ind/widgets/miss.dart';
import 'package:technical_ind/widgets/tableItem.dart';
import '../../../components/bullet_with_body.dart';
import '../../../components/sampleview.dart';
import '../../../styles.dart';
import 'package:technical_ind/screens/stocks/business/models/StockDetailsModel.dart';

class ShareHoldingPage extends StatefulWidget {
  final String isin;
  ShareHoldingPage({Key key, this.isin}) : super(key: key);

  @override
  _ShareHoldingPageState createState() => _ShareHoldingPageState();
}

class _ShareHoldingPageState extends State<ShareHoldingPage> {
  Shareholding shareholding;
  bool loading = true;

  // static List<String> sept = ['72.05', '15.85', '2.25', '5.44', '0.14'];
  // static List<String> jun = ['72.05', '15.85', '2.25', '5.44', '0.14'];

  // static List<String> mar = ['72.05', '15.85', '2.25', '5.44', '0.14'];
  // static List<String> dec = ['72.05', '15.85', '2.25', '5.44', '0.14'];
  // static List<String> sept1 = ['72.05', '15.85', '2.25', '5.44', '0.14'];
  List<String> month1 = [], month2 = [], month3 = [], month4 = [], month5 = [];
  var rand = new Random();
  List<String> head = ['Promoters', 'FII', 'DII', 'Public', 'Others'];
  // List<List<String>> data1 = [sept, sept, sept, sept, sept];
  List<String> months = [];

  fetchApi() async {
    shareholding = await StockServices.stockShareholdingDetails(widget.isin);
    shareholding.tableData.dii.forEach((element) {
      months.add(element.quarter.trim());
    });
    setState(() {
      loading = false;
      menu = months;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchApi();
    // print(shareholding.tableData);
  }

  bool isRight = false;

  _openRight(List<String> newMenu, int i) {
    setState(() {
      menu = newMenu;
      _currentRightPanel = i;
      isRight = true;
    });
    _panelController.open();
  }

  PanelController _panelController = PanelController();

  List<String> menu = [];
  int _s1 = 1;
  int _s2 = 0;
  int _currentLeftPanel = 0;
  int _currentRightPanel = 0;

  _openLeft(List<String> newMenu, int i) {
    setState(() {
      menu = newMenu;
      _currentLeftPanel = i;
      isRight = false;
    });
    _panelController.open();
  }

  //double _current = 0.91;
  int touchedIndex;
  List<Color> colors = [yellow, blue, red];
  @override
  Widget build(BuildContext context) {
    return loading
        ? LoadingPage()
        : shareholding == null ||
                (shareholding.pieChart.mutualFunds == null ||
                        shareholding.pieChart.mutualFunds == "no data") &&
                    (shareholding.pieChart.insurance == null ||
                        shareholding.pieChart.insurance == "no data") &&
                    (shareholding.pieChart.fiis == null ||
                        shareholding.pieChart.fiis == "no data") &&
                    (shareholding.pieChart.nonInstitution == null ||
                        shareholding.pieChart.nonInstitution == "no data") &&
                    (shareholding.pieChart.mutualFunds == null ||
                        shareholding.pieChart.mutualFunds == "no data")
            ? NoDataAvailablePage()
            : SlidePanel(
                menu: menu,
                defaultWidget:
                    menu.length != 0 ? (isRight ? menu[_s1] : menu[_s2]) : "",
                onChange: (val) {
                  setState(() {
                    isRight ? _s1 = val : _s2 = val;
                  });
                },
                panelController: _panelController,
                child: Scaffold(
                  //backgroundColor: kindaWhite,
                  body: SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          SizedBox(height: 30),
                          _getSmartLabelPieChart(),
                          SizedBox(height: 40),
                          Text('Analysis', style: subtitle1White),
                          SizedBox(height: 12),
                          ...List.generate(
                            shareholding.analysis?.length ?? 0,
                            (i) => BulletWithBody(
                              shareholding.analysis[i]?.prefix ?? "",
                              shareholding.analysis[i]?.sentence ?? "",
                              shareholding.analysis[i]?.dir == '-1'
                                  ? red
                                  : colors[
                                      int.parse(shareholding.analysis[i]?.dir)],
                            ),
                          ),
                          // BulletWithBody(
                          //     'Promoters',
                          //     'Promoters holding has increased by 0%. However, the number of shares held by the Promoters has remained constant during the period.',
                          //     Colors.yellow),
                          // BulletWithBody('FII', 'FII holding has increased by 0.15%', blue),
                          // BulletWithBody('MF', 'MF holding has increased by 0.15%', blue),
                          // BulletWithBody(
                          //     'Insurance',
                          //     'Holdings of Insurance companies has decreased by -0.48%',
                          //     Colors.pink),
                          // BulletWithBody('OtherDII',
                          //     'OtherDII  holding has decreased by -0.02%', blue),
                          // BulletWithBody(
                          //     'NII',
                          //     'Holdings of Non Institutional Shareholders has increased by 0.02%',
                          //     blue),
                          SizedBox(height: 26),
                          Container(
                              height: 400,
                              child: Column(
                                children: [
                                  TableBarWithDropDownTitle(
                                    title1: "Quarter",
                                    title2: menu[_s2].trim(),
                                    title3: menu[_s1].trim(),
                                    menu: menu,
                                    openLeft: _openLeft,
                                    openRight: _openRight,
                                    currentRightIndex: _s1,
                                    currentLeftIndex: _s2,
                                  ),
                                  ...List.generate(head.length, (i) {
                                    var d;
                                    if (i == 0) {
                                      d = shareholding.tableData?.promoter;
                                    } else if (i == 1) {
                                      d = shareholding.tableData?.fii;
                                    } else if (i == 2) {
                                      d = shareholding.tableData?.dii;
                                    } else if (i == 3) {
                                      d = shareholding.tableData?.public;
                                    } else {
                                      d = shareholding.tableData?.others;
                                    }
                                    return TableItem(
                                      isFinancial: true,
                                      title: head[i],
                                      value: d[_s2]?.value ?? "",
                                      remarks: d[_s1]?.value ?? "",
                                    );
                                  })
                                ],
                              )
                              // CustomTable(
                              //   scrollPhysics: NeverScrollableScrollPhysics(),
                              //   headersTitle: [
                              //     "Quarter",
                              //     ...months,
                              //   ],
                              //   fixedColumnWidth: 110,
                              //   columnwidth: 90,
                              //   totalColumns: months.length + 1,
                              //   itemCount: head.length,
                              //   leftSideItemBuilder: (c, i) {
                              //     return Container(
                              //       height: 52,
                              //       alignment: Alignment.centerLeft,
                              //       child: Padding(
                              //         padding:
                              //             const EdgeInsets.symmetric(vertical: 7),
                              //         child: Text(head[i],
                              //             textAlign: TextAlign.left,
                              //             style: subtitle2White60),
                              //       ),
                              //     );
                              //   },
                              //   rightSideItemBuilder: (c, i) {
                              // var d;
                              // if (i == 0) {
                              //   d = shareholding.tableData?.promoter;
                              // } else if (i == 1) {
                              //   d = shareholding.tableData?.fii;
                              // } else if (i == 2) {
                              //   d = shareholding.tableData?.dii;
                              // } else if (i == 3) {
                              //   d = shareholding.tableData?.public;
                              // } else {
                              //   d = shareholding.tableData?.others;
                              // }
                              //     return Center(
                              //       child: Container(
                              //         height: 52,
                              //         child: Row(
                              //           crossAxisAlignment:
                              //               CrossAxisAlignment.center,
                              //           children: List.generate(
                              //             5,
                              //             (index) => Container(
                              //               width: 90,
                              //               child: Text(d[index]?.value ?? "",
                              //                   textAlign: TextAlign.center,
                              //                   style: subtitle2White),
                              //             ),
                              //           ),
                              //         ),
                              //       ),
                              //     );
                              //   },
                              // ),
                              ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
  }

  SfCircularChart _getSmartLabelPieChart() {
    return SfCircularChart(
      legend: Legend(
          position: LegendPosition.bottom,
          isResponsive: true,
          textStyle: captionWhite,
          iconBorderColor: Colors.transparent,
          iconBorderWidth: 0,
          iconHeight: 15,
          iconWidth: 15,
          isVisible: true,
          overflowMode: LegendItemOverflowMode.wrap),
      series: _gettSmartLabelPieSeries(shareholding.pieChart),
      // tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  /// Returns the pie series with smart data labels.
  List<DoughnutSeries<ChartSampleData, String>> _gettSmartLabelPieSeries(
      PieChart pieChart) {
    final List<ChartSampleData> chartData = <ChartSampleData>[
      if (pieChart.mutualFunds != null || pieChart.mutualFunds != "no data")
        ChartSampleData(
            x: 'Mutual Funds',
            y: double.parse(pieChart.mutualFunds.replaceAll('%', '')),
            pointColor: Color(0xffe3f4ff)),
      if (pieChart.insurance != null || pieChart.insurance != "no data")
        ChartSampleData(
            x: 'Insurance Companies',
            y: double.parse(pieChart.insurance.replaceAll('%', '')),
            pointColor: Color(0xff8dd0ff)),
      if (pieChart.fiis != null || pieChart.fiis != "no data")
        ChartSampleData(
            x: "FII's",
            y: double.parse(pieChart.fiis.replaceAll('%', '')),
            pointColor: Color(0xff56bdff)),
      if (pieChart.nonInstitution != null ||
          pieChart.nonInstitution != "no data")
        ChartSampleData(
            x: 'Non Instituion',
            y: double.parse(pieChart.nonInstitution.replaceAll('%', '')),
            pointColor: Color(0xff009eff)),

      if (pieChart.mutualFunds != null || pieChart.mutualFunds != "no data")
        ChartSampleData(
            x: 'Promoters',
            y: double.parse(pieChart.promoters.replaceAll('%', '')),
            pointColor: blue),
      // ChartSampleData(x: 'Shopping', y: 19),
      // ChartSampleData(x: 'Savings', y: 9),
      // ChartSampleData(x: 'Others', y: 5),
      // ChartSampleData(x: 'Rent', y: 5),
      // ChartSampleData(x: 'Insurance', y: 4),
      // ChartSampleData(x: 'Tax', y: 3),
      // ChartSampleData(x: 'PF', y: 4),
    ];
    if (pieChart.mutualFunds != null &&
        pieChart.mutualFunds != "no data" &&
        pieChart.insurance != null &&
        pieChart.insurance != "no data" &&
        pieChart.fiis != null &&
        pieChart.fiis != "no data" &&
        pieChart.nonInstitution != null &&
        pieChart.nonInstitution != "no data" &&
        pieChart.mutualFunds != null &&
        pieChart.mutualFunds != "no data")
      return <DoughnutSeries<ChartSampleData, String>>[
        DoughnutSeries<ChartSampleData, String>(
            dataSource: chartData,
            xValueMapper: (ChartSampleData data, _) => data.x,
            yValueMapper: (ChartSampleData data, _) => data.y,
            pointColorMapper: (ChartSampleData data, _) => data.pointColor,
            startAngle: 90,
            endAngle: 360 + 90,
            // enableSmartLabels: true,      //not avilable in updated pacakage
            dataLabelMapper: (ChartSampleData data, _) =>
                data.y.toString() + " %",
            dataLabelSettings: DataLabelSettings(
                connectorLineSettings: ConnectorLineSettings(length: "10%"),
                isVisible: true,
                labelIntersectAction: LabelIntersectAction.none,
                labelPosition: ChartDataLabelPosition.outside)),
      ];
  }
}
