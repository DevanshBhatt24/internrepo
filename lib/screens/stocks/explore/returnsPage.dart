import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:technical_ind/components/LoadingPage.dart';
import 'package:technical_ind/components/noDataAvailable.dart';
import 'package:technical_ind/components/utils.dart';

import 'package:technical_ind/screens/stocks/business/models/StockDetailsModel.dart';
import 'package:technical_ind/screens/stocks/business/stockServices.dart';

import '../../../components/bullet_with_body.dart';
import '../../../styles.dart';
import '../../../widgets/miss.dart';
import '../../../widgets/tableItem.dart';

class ReturnsPage extends StatefulWidget {
  final String isin;
  ReturnsPage({Key key, this.isin}) : super(key: key);

  @override
  _ReturnsPageState createState() => _ReturnsPageState();
}

class _ReturnsPageState extends State<ReturnsPage> {
  ReturnsClass returns;
  bool loading = true;
  fetchApi() async {
    returns = await StockServices.stockReturnsDetails(widget.isin);
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    fetchApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? LoadingPage()
        : returns == null
            ? NoDataAvailablePage()
            : Scaffold(
                body: returns.analysis.isEmpty &&
                        returns.stockVsSensex.isEmpty &&
                        returns.byClosestPeers.rows.isEmpty
                    ? NoDataAvailablePage()
                    : SingleChildScrollView(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            children: [
                              if (returns.analysis.isNotEmpty)
                                Column(
                                  children: [
                                    SizedBox(height: 38),
                                    Text('Analysis', style: bodyText1white),
                                    SizedBox(height: 16),
                                    _analysis(
                                        blue,
                                        returns.analysis[0].prefix ?? "",
                                        returns.analysis[0].suffix ?? ""),
                                    _analysis(
                                        Colors.pink,
                                        returns.analysis[1].prefix ?? "",
                                        returns.analysis[1].suffix ?? ""),
                                    _analysis(
                                        Colors.yellow,
                                        returns.analysis[2].prefix ?? "",
                                        returns.analysis[2].suffix ?? ""),
                                  ],
                                ),
                              if (returns.stockVsSensex.isNotEmpty)
                                Column(
                                  children: [
                                    SizedBox(height: 34),
                                    Text("Stock Vs Sensex",
                                        style: subtitle1White),
                                    SizedBox(height: 26),
                                    TableBar(
                                      title1: "Duration",
                                      title2: "Stock",
                                      title3: "Sensex",
                                    ),
                                    SizedBox(height: 12),
                                    TableItem(
                                      title: "1 Day",
                                      value: returns.stockVsSensex[0].stock ??
                                          "" + " %",
                                      valueColor: Utils.determineColorfromValue(
                                          returns.stockVsSensex[0].stock ?? ""),
                                      remarks:
                                          returns.stockVsSensex[0].sensex ??
                                              "" + " %",
                                      remarksColor:
                                          Utils.determineColorfromValue(
                                              returns.stockVsSensex[0].sensex ??
                                                  ""),
                                    ),
                                    TableItem(
                                      title: "1 Week",
                                      value:
                                          returns.stockVsSensex[1].stock + " %",
                                      valueColor: Utils.determineColorfromValue(
                                          returns.stockVsSensex[1].stock ?? ""),
                                      remarks:
                                          returns.stockVsSensex[1].sensex ??
                                              "" + " %",
                                      remarksColor:
                                          Utils.determineColorfromValue(
                                              returns.stockVsSensex[1].sensex ??
                                                  ""),
                                    ),
                                    TableItem(
                                      title: "1 Month",
                                      value: returns.stockVsSensex[2].stock ??
                                          "" + " %",
                                      valueColor: Utils.determineColorfromValue(
                                          returns.stockVsSensex[2].stock ?? ""),
                                      remarks:
                                          returns.stockVsSensex[2].sensex ??
                                              "" + " %",
                                      remarksColor:
                                          Utils.determineColorfromValue(
                                              returns.stockVsSensex[2].sensex ??
                                                  ""),
                                    ),
                                    TableItem(
                                      title: "3 Months",
                                      value: returns.stockVsSensex[3].stock ??
                                          "" + " %",
                                      valueColor: Utils.determineColorfromValue(
                                          returns.stockVsSensex[3].stock ?? ""),
                                      remarks:
                                          returns.stockVsSensex[3].sensex ??
                                              "" + " %",
                                      remarksColor:
                                          Utils.determineColorfromValue(
                                              returns.stockVsSensex[3].sensex ??
                                                  ""),
                                    ),
                                    TableItem(
                                      title: "6 Months",
                                      value: returns.stockVsSensex[4].stock ??
                                          "" + " %",
                                      valueColor: Utils.determineColorfromValue(
                                          returns.stockVsSensex[4].stock ?? ""),
                                      remarks:
                                          returns.stockVsSensex[4].sensex ??
                                              "" + " %",
                                      remarksColor:
                                          Utils.determineColorfromValue(
                                              returns.stockVsSensex[4].sensex ??
                                                  ""),
                                    ),
                                    TableItem(
                                      title: "Year to date",
                                      value: returns.stockVsSensex[5].stock ??
                                          "" + " %",
                                      valueColor: Utils.determineColorfromValue(
                                          returns.stockVsSensex[5].stock ?? ""),
                                      remarks:
                                          returns.stockVsSensex[5].sensex ??
                                              "" + " %",
                                      remarksColor:
                                          Utils.determineColorfromValue(
                                              returns.stockVsSensex[5].sensex ??
                                                  ""),
                                    ),
                                    TableItem(
                                      title: "1 Year",
                                      value: returns.stockVsSensex[6].stock ??
                                          "" + " %",
                                      valueColor: Utils.determineColorfromValue(
                                          returns.stockVsSensex[6].stock ?? ""),
                                      remarks:
                                          returns.stockVsSensex[6].sensex ??
                                              "" + " %",
                                      remarksColor:
                                          Utils.determineColorfromValue(
                                              returns.stockVsSensex[6].sensex ??
                                                  ""),
                                    ),
                                    TableItem(
                                      title: "3 Years",
                                      value: returns.stockVsSensex[8].stock ??
                                          "" + " %",
                                      valueColor: Utils.determineColorfromValue(
                                          returns.stockVsSensex[8].stock ?? ""),
                                      remarks:
                                          returns.stockVsSensex[8].sensex ??
                                              "" + " %",
                                      remarksColor:
                                          Utils.determineColorfromValue(
                                              returns.stockVsSensex[8].sensex ??
                                                  ""),
                                    ),
                                    TableItem(
                                      title: "5 Years",
                                      value: returns.stockVsSensex[10].stock ??
                                          "" + " %",
                                      valueColor: Utils.determineColorfromValue(
                                          returns.stockVsSensex[10].stock ??
                                              ""),
                                      remarks:
                                          returns.stockVsSensex[10].sensex ??
                                              "" + " %",
                                      remarksColor:
                                          Utils.determineColorfromValue(returns
                                                  .stockVsSensex[10].sensex ??
                                              ""),
                                    ),
                                    TableItem(
                                      title: "10 Years",
                                      value: returns.stockVsSensex[11].stock ??
                                          "" + " %",
                                      valueColor: Utils.determineColorfromValue(
                                          returns.stockVsSensex[11].stock ??
                                              ""),
                                      remarks:
                                          returns.stockVsSensex[11].sensex ??
                                              "" + " %",
                                      remarksColor:
                                          Utils.determineColorfromValue(returns
                                                  .stockVsSensex[11].sensex ??
                                              ""),
                                    ),
                                  ],
                                ),
                              SizedBox(height: 32),
                              new Text("Total Returns", style: subtitle1White),
                              SizedBox(height: 26),
                              TableBar(
                                title1: "Period",
                                title2: "Price",
                                title3: "Dividend",
                                title4: "Total",
                              ),
                              SizedBox(height: 12),
                              ...List.generate(
                                returns.totalReturns.length,
                                (i) => TableItem(
                                  title: returns.totalReturns[i].period ?? "",
                                  value: returns.totalReturns[i].price ?? "",
                                  remarks:
                                      returns.totalReturns[i].dividend ?? "",
                                  total: returns.totalReturns[i].total ?? "",
                                ),
                              ),
                              SizedBox(height: 32),
                              Text("Quaterly Returns", style: subtitle1White),
                              SizedBox(height: 26),
                              Text("BY CLOSEST PEERS", style: bodyText2White60),
                              SizedBox(height: 12),
                              Text(returns.byClosestPeers.text ?? "",
                                  style: subtitle18),
                              SizedBox(height: 24),
                              TableBar(
                                title1: "Quarter",
                                title2: "Time",
                                title3: "Returns",
                              ),
                              SizedBox(height: 12),
                              ...List.generate(
                                returns.byClosestPeers.rows.length,
                                (i) => TableItem(
                                  title:
                                      "${returns.byClosestPeers.rows[i].quarter ?? "-"} Quarter",
                                  value:
                                      returns.byClosestPeers.rows[i].time ?? "",
                                  remarks:
                                      "${returns.byClosestPeers.rows[i].returns ?? "-"} %",
                                  remarksColor: Utils.determineColorfromValue(
                                      returns.byClosestPeers.rows[i].returns ??
                                          "-"),
                                ),
                              ),
                              SizedBox(height: 24),
                              Text("BY INDUSTRY", style: bodyText2White60),
                              SizedBox(height: 12),
                              Text(returns.byIndustryPeers.text ?? "",
                                  textAlign: TextAlign.center,
                                  style: subtitle18),
                              SizedBox(height: 24),
                              TableBar(
                                title1: "QUARTER",
                                title2: "TIME",
                                title3: "RETURNS",
                              ),
                              SizedBox(height: 12),
                              ...List.generate(
                                returns.byIndustryPeers.rows.length,
                                (i) => TableItem(
                                  title:
                                      "${returns.byIndustryPeers.rows[i].quarter ?? "-"} Quarter",
                                  value: returns.byIndustryPeers.rows[i].time ??
                                      "",
                                  remarks:
                                      "${returns.byIndustryPeers.rows[i].returns ?? "-"} %",
                                  remarksColor: Utils.determineColorfromValue(
                                      returns.byIndustryPeers.rows[i].returns ??
                                          "-"),
                                ),
                              ),
                              SizedBox(height: 24),
                              Text("BY MCAP PEERS", style: bodyText2White60),
                              SizedBox(height: 12),
                              Text(returns.byMcapPeers.text, style: subtitle18),
                              SizedBox(height: 24),
                              TableBar(
                                title1: "QUARTER",
                                title2: "TIME",
                                title3: "RETURNS",
                              ),
                              SizedBox(height: 12),
                              ...List.generate(
                                returns.byMcapPeers.rows.length,
                                (i) => TableItem(
                                  title:
                                      "${returns.byMcapPeers.rows[i].quarter ?? "-"} Quarter",
                                  value: returns.byMcapPeers.rows[i].time ?? "",
                                  remarks:
                                      "${returns.byMcapPeers.rows[i].returns ?? "-"} %",
                                  remarksColor: Utils.determineColorfromValue(
                                      returns.byMcapPeers.rows[i].returns ??
                                          "-"),
                                ),
                              ),
                              SizedBox(height: 40),
                            ],
                          ),
                        ),
                      ),
              );
  }

  Widget _analysis(Color color, String a, String b) {
    return BulletWithBody(a, b, color);
  }
}
