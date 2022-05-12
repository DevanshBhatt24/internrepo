//import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:technical_ind/components/LoadingPage.dart';
import 'package:technical_ind/components/noDataAvailable.dart';
import 'package:technical_ind/components/sampleview.dart';
import 'package:technical_ind/screens/stocks/business/stockServices.dart';
import 'package:technical_ind/widgets/datagrid.dart';
import 'package:technical_ind/screens/stocks/business/models/StockDetailsModel.dart';
import 'package:technical_ind/widgets/miss.dart';

import '../../../components/bullet_with_body.dart';
import '../../../styles.dart';

class DeliveryPage extends StatefulWidget {
  final String isin;
  DeliveryPage({Key key, this.isin}) : super(key: key);

  @override
  _DeliveryPageState createState() => _DeliveryPageState();
}

class _DeliveryPageState extends State<DeliveryPage> {
  Delivery delivery;
  bool loading = true;

  fetchApi() async {
    delivery = await StockServices.deliveryDetail(widget.isin);
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    fetchApi();
    super.initState();
    // print(delivery);
  }

  static List<String> NSE = [
    '1.15 Lacs',
    '1.15 Lacs',
    '1.15 Lacs',
    '1.15 Lacs',
    '1.15 Lacs',
    '1.15 Lacs',
    '1.15 Lacs',
    '1.15 Lacs',
  ];
  final Color leftBarColor = const Color(0xff009eff);
  final Color rightBarColor = blue;

  final double width = 14;
  List<String> head = [
    '13 Oct 2020',
    '13 Oct 2020',
    '13 Oct 2020',
    '13 Oct 2020',
    '13 Oct 2020',
    '13 Oct 2020',
    '13 Oct 2020',
    '13 Oct 2020'
  ];
  final data1 = [NSE, NSE, NSE, NSE, NSE];

  int touchedGroupIndex;

  @override
  Widget build(BuildContext context) {
    return loading
        ? LoadingPage()
        : delivery != null
            ? delivery.anlysisData[0].mssg == "" &&
                    delivery.anlysisData[1].mssg == "" &&
                    delivery.tableData.length == 0
                ? NoDataAvailablePage()
                : Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          // SizedBox(height: 20),
                          Text('Analysis', style: subtitle1White),
                          SizedBox(height: 12),
                          if (delivery.anlysisData[0].mssg != "")
                            BulletWithBody(
                              delivery.anlysisData[0].mssg.substring(
                                    0,
                                    delivery.anlysisData[0].mssg.indexOf(':'),
                                  ) ??
                                  "",
                              delivery.anlysisData[0].mssg.substring(delivery
                                          .anlysisData[0].mssg
                                          .indexOf(':') +
                                      2) ??
                                  "",
                              delivery.anlysisData[0].status == 'green'
                                  ? blue
                                  : red,
                            ),
                          if (delivery.anlysisData[1].mssg != "")
                            BulletWithBody(
                              delivery.anlysisData[1].mssg.substring(
                                    0,
                                    delivery.anlysisData[1].mssg.indexOf(':'),
                                  ) ??
                                  "",
                              delivery.anlysisData[1].mssg.substring(delivery
                                          .anlysisData[1].mssg
                                          .indexOf(':') +
                                      2) ??
                                  "",
                              delivery.anlysisData[1].status == 'green'
                                  ? blue
                                  : red,
                            ),
                          // SizedBox(height: 30),
                          // SingleChildScrollView(
                          //   scrollDirection: Axis.horizontal,
                          //   child: Container(
                          //     height: 250,
                          //     width: 1.sw,
                          //     padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          //     child: getChart(),
                          //
                          //   ),
                          // ),
                          // SizedBox(height: 32),
                          _historyBuilder2(delivery.tableData),
                          // Container(
                          //   height: MediaQuery.of(context).size.height * 3 / 4,
                          //   child: CustomTable(
                          //     scrollPhysics: NeverScrollableScrollPhysics(),
                          //     headersTitle: [
                          //       "Date",
                          //       "Delivery - NSE",
                          //       "Delivery - BSE",
                          //       "Total Delivery Vol",
                          //       "Total Volume",
                          //       "Volume %"
                          //     ],
                          //     fixedColumnWidth: 130,
                          //     columnwidth: 110,
                          //     totalColumns: 6,
                          //     itemCount: delivery.tableData.length,
                          //     // leftSideItemBuilder: (c, i) {
                          //     //   return Container(
                          //     //     height: 52,
                          //     //     alignment: Alignment.centerLeft,
                          //     //     child: Padding(
                          //     //       padding: const EdgeInsets.symmetric(vertical: 7),
                          //     //       child: Text(delivery.tableData[i].date,
                          //     //           textAlign: TextAlign.left, style: subtitle2White60),
                          //     //     ),
                          //     //   );
                          //     // },
                          //     leftSideItemBuilder: (c, i) {
                          //       return Padding(
                          //         padding: const EdgeInsets.symmetric(vertical: 10),
                          //         child: Text(
                          //           delivery.tableData[i].date,
                          //           style: subtitle2White60,
                          //         ),
                          //       );
                          //     },
                          //     rightSideItemBuilder: (c, i) {
                          //       return DataTableItem(
                          //         data: [
                          //           delivery.tableData[i].deliveryVolumeNse ?? "",
                          //           delivery.tableData[i].deliveryVolumeBse ?? "",
                          //           delivery.tableData[i].totalDeliveryVolume ?? "",
                          //           delivery.tableData[i].totalVolume ?? "",
                          //           delivery.tableData[i].delivery ?? "",
                          //         ],
                          //       );
                          //     },
                          //     // rightSideItemBuilder: (c, i) => Center(
                          //     //   child: Container(
                          //     //     height: 52,
                          //     //     child: Row(
                          //     //       crossAxisAlignment: CrossAxisAlignment.center,
                          //     //       children: List.generate(
                          //     //         5,
                          //     //         (index) => Container(
                          //     //           width: 110,
                          //     //           child: Text(data1[index][i],
                          //     //               textAlign: TextAlign.center,
                          //     //               style: subtitle2White),
                          //     //         ),
                          //     //       ),
                          //     //     ),
                          //     //   ),
                          //     // ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  )
            : NoDataAvailablePage();
  }

  SfCartesianChart getChart() {
    return SfCartesianChart(
      //enableSideBySideSeriesPlacement: false,

      axes: <ChartAxis>[
        NumericAxis(
            opposedPosition: true,
            name: "yAxis1",
            labelFormat: '{value}',
            title: AxisTitle(text: 'Score'),
            axisLine: AxisLine(width: 0),
            majorTickLines: MajorTickLines(size: 0),
            minimum: 0,
            maximum: 60,
            interval: 15),
      ],

      plotAreaBorderWidth: 0,
      //legend: Legend(isVisible: !isCardView, position: LegendPosition.top),

      /// X axis as numeric axis placed here.
      primaryXAxis: NumericAxis(
          title: AxisTitle(text: 'Match'),
          minimum: 0,
          maximum: 6,
          interval: 1,
          majorGridLines: MajorGridLines(width: 0),
          majorTickLines: MajorTickLines(size: 0),
          edgeLabelPlacement: EdgeLabelPlacement.hide),
      primaryYAxis: NumericAxis(
          title: AxisTitle(text: 'Score'),
          axisLine: AxisLine(width: 0),
          majorTickLines: MajorTickLines(size: 0),
          majorGridLines: MajorGridLines(width: 0),
          minimum: 0,
          maximum: 60,
          interval: 15),
      //series: getDefaultNumericSeries(),
      tooltipBehavior: TooltipBehavior(
          enable: true, format: 'Score: point.y', canShowMarker: false),
    );
  }

  /// Returns the list of Chart series
  /// which need to render on the default numeric axis.
  List<ColumnSeries<ChartSampleData, num>> getDefaultNumericSeries() {
    final List<ChartSampleData> chartData = <ChartSampleData>[
      ChartSampleData(xValue: 1, y: 45, yValue: 35, secondSeriesYValue: 15),
      ChartSampleData(xValue: 2, y: 45, yValue: 35, secondSeriesYValue: 15),
      ChartSampleData(xValue: 3, y: 45, yValue: 35, secondSeriesYValue: 15),
      ChartSampleData(xValue: 4, y: 45, yValue: 35, secondSeriesYValue: 15),
      ChartSampleData(xValue: 5, y: 45, yValue: 35, secondSeriesYValue: 15)
    ];
    return <ColumnSeries<ChartSampleData, num>>[
      ///first series named "Australia".
      // ColumnSeries<ChartSampleData, num>(
      //     dataSource: chartData,
      //     width: 0.7,

      //     color: const Color.fromRGBO(237, 221, 76, 1),
      //     name: 'Australia',
      //     xValueMapper: (ChartSampleData sales, _) => sales.xValue,
      //     yValueMapper: (ChartSampleData sales, _) => sales.y),
      ColumnSeries<ChartSampleData, num>(
          //width: 0.5,
          isTrackVisible: true,
          dataSource: chartData,
          color: blue,
          name: 'Australia',
          xValueMapper: (ChartSampleData sales, _) => sales.xValue,
          yValueMapper: (ChartSampleData sales, _) => sales.secondSeriesYValue),

      ///second series named "India".
      ColumnSeries<ChartSampleData, num>(
          isTrackVisible: true,
          dataSource: chartData,
          yAxisName: 'yAxis1',
          color: red,
          xValueMapper: (ChartSampleData sales, _) => sales.xValue,
          yValueMapper: (ChartSampleData sales, _) => sales.yValue,
          name: 'India'),
    ];
  }

// BarChartGroupData makeGroupData(int x, double tv, double y1, double y2) {
//   return BarChartGroupData(barsSpace: 0, x: x, barRods: [
//     BarChartRodData(
//         y: y1,
//         colors: [leftBarColor],
//         width: width,
//         borderRadius: BorderRadius.circular(0),
//         backDrawRodData: BackgroundBarChartRodData(
//             y: tv, colors: [Color(0xff8dd0ff)], show: true)),
//     BarChartRodData(
//         y: y2,
//         colors: [rightBarColor],
//         width: width,
//         borderRadius: BorderRadius.circular(0),
//         backDrawRodData: BackgroundBarChartRodData(
//             y: tv, colors: [Color(0xff8dd0ff)], show: true)),
//   ]);
// }

  _historyBuilder2(List<DeliveryTableDatum> list) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, i) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            children: [
              TableBarv2(
                title1: list[i].date ?? '-',
                title2: '',
                color: Colors.white,
              ),
              SizedBox(height: 12),
              TableItemv2(
                title: 'Delivery NSE',
                value: list[i].deliveryVolumeNse ?? '-',
              ),
              TableItemv2(
                title: 'Delivery BSE',
                value: list[i].deliveryVolumeBse ?? '-',
              ),
              TableItemv2(
                title: 'Total Delivery Vol',
                value: list[i].totalDeliveryVolume ?? '-',
              ),
              TableItemv2(
                title: 'Total Volume',
                value: list[i].totalVolume ?? '-',
              ),
              TableItemv2(
                title: 'Volume(%)',
                value: list[i].delivery ?? '-',
              ),
              // SizedBox(height: 26),
            ],
          ),
        );
      },
      itemCount: list.length ?? 0,
    );
  }
}
