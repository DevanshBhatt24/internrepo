import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:technical_ind/components/LoadingPage.dart';
import 'package:technical_ind/components/noDataAvailable.dart';
import 'package:technical_ind/screens/indices/business/indices_services.dart';

import '../../../styles.dart';
import '../business/indian_overview_model.dart';

class ChartData {
  final String x;

  final double y;
  final Color color;
  ChartData(this.x, this.y, [this.color]);
}

class StockEffect extends StatefulWidget {
  // final StockEffects stockEffects;
  final String query;
  StockEffect({this.query});
  @override
  _StockEffectState createState() => _StockEffectState();
}

class _StockEffectState extends State<StockEffect> {
  StockEffects stockEffects;
  bool loading = true;
  fetchApi() async {
    stockEffects =
        await IndicesServices.getIndianIndicesStockEffect(widget.query);
    setState(() {
      loading = false;
    });
    _refreshController.refreshCompleted();
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  void initState() {
    fetchApi();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<ChartData> chartDatadown = [];
    List<ChartData> chartDataup = [];
    if (stockEffects != null) {
      for (int i = 0; i < stockEffects.down.length; i++) {
        chartDatadown.add(ChartData(
            stockEffects.down[i].name,
            double.parse(stockEffects.down[i].contributionPercent),
            i == 0
                ? Color(0xffFF2E50)
                : i == 1
                    ? Color(0xffFF526E)
                    : i == 2
                        ? Color(0xffFF768D)
                        : i == 3
                            ? Color(0xffFF9BAC)
                            : Color(0xffFF5555)));
      }
      for (int i = 0; i < stockEffects.up.length; i++) {
        chartDataup.add(ChartData(
            stockEffects.up[i].name,
            double.parse(stockEffects.up[i].contributionPercent),
            i == 0
                ? Color(0xff004999)
                : i == 1
                    ? Color(0xff007AFF)
                    : i == 2
                        ? Color(0xff009EFF)
                        : i == 3
                            ? Color(0xff56BDFF)
                            : Color(0xffE3F4FF)));
      }
    }

    Widget row(String title, String subtitle, ChartData c) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 9),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                SizedBox(height: 6),
                CircleAvatar(backgroundColor: c.color, radius: 4),
              ],
            ),
            SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(title ?? "" + ' ', style: bodyText1white),
                    Text(' ' + subtitle ?? "",
                        style: highlightStyle.copyWith(
                            color: !subtitle[1].contains('-') ? blue : red))
                  ],
                ),
                Text(c.x, style: captionWhite60),
              ],
            )
          ],
        ),
      );
    }

    return loading
        ? LoadingPage()
        : stockEffects != null
            ? Scaffold(
                body: SmartRefresher(
                enablePullDown: true,
                enablePullUp: false,
                controller: _refreshController,
                onRefresh: fetchApi,
                header: ClassicHeader(
                  completeIcon: Icon(Icons.done, color: Colors.white60),
                  refreshingIcon: SizedBox(
                    width: 25,
                    height: 25,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                      color: Colors.white60,
                    ),
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.arrow_upward,
                                size: 36, color: almostWhite),
                            SizedBox(width: 6),
                            Text('Stocks pulling Indices UP',
                                style: bodyText1white),
                          ],
                        ),
                        SizedBox(height: 36),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              height: MediaQuery.of(context).size.width * 0.5,
                              child: SfCircularChart(
                                series: <CircularSeries>[
                                  // Renders doughnut chart
                                  DoughnutSeries<ChartData, String>(
                                      dataSource: chartDataup,
                                      pointColorMapper: (ChartData data, _) =>
                                          data.color,
                                      xValueMapper: (ChartData data, _) =>
                                          data.x,
                                      yValueMapper: (ChartData data, _) =>
                                          data.y)
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: stockEffects.up.length,
                                      itemBuilder: (context, i) {
                                        return stockEffects?.up[i]
                                                    ?.contributionPercent ==
                                                null
                                            ? SizedBox()
                                            : row(
                                                stockEffects?.up[i]?.cmp ?? "",
                                                stockEffects?.up[i]
                                                        .contributionPercent
                                                        .contains('-')
                                                    ? '(' +
                                                        stockEffects?.up[i]
                                                            ?.contributionPercent +
                                                        ')'
                                                    : '(+' +
                                                        stockEffects?.up[i]
                                                            ?.contributionPercent +
                                                        ')',
                                                chartDataup[i],
                                              );
                                      }),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 30),
                        Row(
                          children: [
                            Icon(Icons.arrow_downward,
                                size: 36, color: almostWhite),
                            SizedBox(width: 6),
                            Text('Stocks dragging Indices DOWN',
                                style: bodyText1white),
                          ],
                        ),
                        SizedBox(height: 36),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              height: MediaQuery.of(context).size.width * 0.5,
                              child: SfCircularChart(
                                series: <CircularSeries>[
                                  // Renders doughnut chart
                                  DoughnutSeries<ChartData, String>(
                                      dataSource: chartDatadown,
                                      pointColorMapper: (ChartData data, _) =>
                                          data.color,
                                      xValueMapper: (ChartData data, _) =>
                                          data.x,
                                      yValueMapper: (ChartData data, _) =>
                                          data.y)
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount:
                                          stockEffects?.down?.length ?? 0,
                                      itemBuilder: (context, i) {
                                        return stockEffects?.down[i]
                                                    ?.contributionPercent ==
                                                null
                                            ? SizedBox()
                                            : row(
                                                stockEffects?.down[i]?.cmp ??
                                                    "",
                                                stockEffects?.down[i]
                                                        .contributionPercent
                                                        .contains('-')
                                                    ? '(' +
                                                        stockEffects?.down[i]
                                                            ?.contributionPercent +
                                                        ')'
                                                    : '(+' +
                                                        stockEffects?.down[i]
                                                            ?.contributionPercent +
                                                        ')',
                                                chartDatadown[i],
                                              );
                                      }),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ))
            : NoDataAvailablePage();
  }
}
