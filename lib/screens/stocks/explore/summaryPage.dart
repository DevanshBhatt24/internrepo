import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:technical_ind/components/LoadingPage.dart';
import 'package:technical_ind/components/noDataAvailable.dart';
import 'package:technical_ind/components/utils.dart';
import 'package:technical_ind/screens/stocks/business/models/StockDetailsModel.dart';
import 'package:technical_ind/screens/stocks/business/stockServices.dart';

import '../../../components/four_items_in_a_row.dart';
import '../../../styles.dart';
import '../../../widgets/bulletText.dart';
import '../../../widgets/miss.dart';
import '../../../widgets/tableItem.dart';

class SummaryPage extends StatefulWidget {
  final String isin;
  SummaryPage({Key key, this.isin}) : super(key: key);

  @override
  _SummaryPageState createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  QuickSummary summary;
  bool loading = true;

  fetchApi() async {
    print(widget.isin);
    summary = await StockServices.stockSummaryDetails(widget.isin);
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
    return loading == true
        ? LoadingPage()
        : summary == null
            ? NoDataAvailablePage()
            : Scaffold(
                body: summary != null
                    ? SingleChildScrollView(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: 38),
                              new Text("Analysis", style: subtitle1White),
                              SizedBox(height: 20),
                              Column(
                                children: List.generate(
                                    summary?.analysis?.length ?? 0,
                                    (index) => BulletText(
                                          summary.analysis[index].text,
                                          color:
                                              summary.analysis[index].status ==
                                                      'green'
                                                  ? blue
                                                  : yellow,
                                        )),
                              ),

                              SizedBox(height:20),
                              DefaultTabController(
                          length: 2,
                          initialIndex: 0,
                          child: Column(
                            children: [
                              StickyHeader(
                                header: Material(
                                  color: Colors.black,
                                  child: Column(children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: TabBar(
                                        labelStyle: buttonWhite,
                                        unselectedLabelColor: white38,
                                        indicator: MaterialIndicator(
                                          horizontalPadding: 30,
                                          bottomLeftRadius: 8,
                                          bottomRightRadius: 8,
                                          color: Colors.white.withOpacity(0.87),
                                          paintingStyle: PaintingStyle.fill,
                                        ),
                                        tabs: [
                                          Tab(
                                            text: "Consolidated",
                                          ),
                                          Tab(
                                            text: "Standalone",
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]),
                                ),
                                content: 
                                Container(
                                  height: 670,
                                  child: TabBarView(children: [
                                    Column(
                                  children: List.generate(
                                    summary?.consolidated?.length ?? 0,
                                    (index) => CustomRow2(summary.consolidated[index].title, summary.consolidated[index].value)),
                              ),
                                    Column(
                                  children: List.generate(
                                    summary?.standalone?.length ?? 0,
                                    (index) => CustomRow2(summary.standalone[index].title, summary.standalone[index].value)),
                              ),
                                  ]),
                                ),
                              ),
                            ],
                          ),
                        ),
                              // SizedBox(height: 38),
                              // new Text("Price/Volume Action",
                              //     style: subtitle1White),
                              // SizedBox(height: 16),
                              // CustomRow(
                              //     "Code",
                              //     summary?.priceVolumeAction?.code ?? "",
                              //     "EOD Share Price",
                              //     summary?.priceVolumeAction?.eodSharePrice ??
                              //         ""),
                              // CustomRow(
                              //     "Previous Share Price",
                              //     summary?.priceVolumeAction?.previousPrice ??
                              //         "",
                              //     "Price Change",
                              //     summary?.priceVolumeAction?.priceChange ??
                              //         "".split('/')[0].replaceAll(' ', '')),
                              // CustomRow(
                              //     "Change %",
                              //     summary?.priceVolumeAction?.priceChange
                              //             ?.split('/')[1]
                              //             .replaceAll(' ', '') ??
                              //         "",
                              //     "Volume",
                              //     summary?.priceVolumeAction?.volume ?? ""),
                              // CustomRow(
                              //     "Five Day Avg Vol",
                              //     summary?.priceVolumeAction?.fiveDayAvgVol ??
                              //         "",
                              //     "Beta",
                              //     summary?.priceVolumeAction?.beta ?? ""),
                              // CustomRow(
                              //     "Fno Stock",
                              //     summary?.priceVolumeAction?.fnoStock ?? "",
                              //     "Last Business Date",
                              //     summary?.priceVolumeAction
                              //             ?.lastBusinessDate ??
                              //         ""),
                              // SizedBox(height: 34),
                              // Text("Price Gain/Loss", style: subtitle1White),
                              // SizedBox(height: 30),
                              // TableBar(
                              //     title1: "Duration",
                              //     title2: "Absoulute chg",
                              //     title3: "chg%"),
                              // SizedBox(height: 12),
                              // TableItem(
                              //   title: "1 Week",
                              //   value: summary
                              //           ?.priceGainLoss?.oneWeek?.absoluteChg ??
                              //       "",
                              //   remarks: summary.priceGainLoss?.oneWeek
                              //           ?.chgPercentage ??
                              //       "" + " %",
                              //   valueColor: Utils.determineColorfromValue(
                              //       summary?.priceGainLoss?.oneWeek
                              //               ?.absoluteChg ??
                              //           ""),
                              //   remarksColor: Utils.determineColorfromValue(
                              //       summary?.priceGainLoss?.oneWeek
                              //               ?.absoluteChg ??
                              //           ""),
                              // ),
                              // TableItem(
                              //   title: "2 Weeks",
                              //   value: summary?.priceGainLoss?.twoWeeks
                              //           ?.absoluteChg ??
                              //       "",
                              //   remarks: summary?.priceGainLoss?.twoWeeks
                              //           ?.chgPercentage ??
                              //       "" + " %",
                              //   valueColor: Utils.determineColorfromValue(
                              //       summary?.priceGainLoss?.twoWeeks
                              //               ?.absoluteChg ??
                              //           ""),
                              //   remarksColor: Utils.determineColorfromValue(
                              //       summary?.priceGainLoss?.twoWeeks
                              //               ?.absoluteChg ??
                              //           ""),
                              // ),
                              // TableItem(
                              //   title: "1 Month",
                              //   value: summary?.priceGainLoss?.oneMonth
                              //           ?.absoluteChg ??
                              //       "",
                              //   remarks: summary?.priceGainLoss?.oneMonth
                              //           ?.chgPercentage ??
                              //       "" + " %",
                              //   valueColor: Utils.determineColorfromValue(
                              //       summary?.priceGainLoss?.oneMonth
                              //               ?.absoluteChg ??
                              //           ""),
                              //   remarksColor: Utils.determineColorfromValue(
                              //       summary.priceGainLoss.oneMonth.absoluteChg),
                              // ),
                              // TableItem(
                              //     title: "3 Months",
                              //     value: summary?.priceGainLoss?.threeMonths
                              //             ?.absoluteChg ??
                              //         "",
                              //     remarks: summary?.priceGainLoss?.threeMonths
                              //             ?.chgPercentage ??
                              //         "" + " %",
                              //     valueColor: Utils.determineColorfromValue(
                              //         summary?.priceGainLoss?.threeMonths
                              //                 ?.absoluteChg ??
                              //             ""),
                              //     remarksColor: Utils.determineColorfromValue(
                              //         summary?.priceGainLoss?.threeMonths
                              //                 ?.absoluteChg ??
                              //             "")),
                              // TableItem(
                              //     title: "6 Months",
                              //     value: summary?.priceGainLoss?.sixMonths
                              //             ?.absoluteChg ??
                              //         "",
                              //     remarks: summary?.priceGainLoss?.sixMonths
                              //             ?.chgPercentage ??
                              //         "" + " %",
                              //     valueColor: Utils.determineColorfromValue(
                              //         summary?.priceGainLoss?.sixMonths
                              //                 ?.absoluteChg ??
                              //             ""),
                              //     remarksColor: Utils.determineColorfromValue(
                              //         summary?.priceGainLoss?.sixMonths
                              //                 ?.absoluteChg ??
                              //             "")),
                              // TableItem(
                              //     title: "1 Year",
                              //     value: summary?.priceGainLoss?.oneYear
                              //             ?.absoluteChg ??
                              //         "",
                              //     remarks: summary?.priceGainLoss?.oneYear
                              //             ?.chgPercentage ??
                              //         "" + " %",
                              //     valueColor: Utils.determineColorfromValue(
                              //         summary?.priceGainLoss?.oneYear
                              //                 ?.absoluteChg ??
                              //             ""),
                              //     remarksColor: Utils.determineColorfromValue(
                              //         summary?.priceGainLoss?.oneYear
                              //                 ?.absoluteChg ??
                              //             "")),
                              // TableItem(
                              //     title: "2 Years",
                              //     value: summary?.priceGainLoss?.twoYear
                              //             ?.absoluteChg ??
                              //         "",
                              //     remarks: summary?.priceGainLoss?.twoYear
                              //             ?.chgPercentage ??
                              //         "" + " %",
                              //     valueColor: Utils.determineColorfromValue(
                              //         summary?.priceGainLoss?.twoYear
                              //                 ?.absoluteChg ??
                              //             ""),
                              //     remarksColor: Utils.determineColorfromValue(
                              //         summary?.priceGainLoss?.twoYear
                              //                 ?.absoluteChg ??
                              //             "")),
                              // TableItem(
                              //     title: "5 Years",
                              //     value: summary?.priceGainLoss?.fiveYear
                              //             ?.absoluteChg ??
                              //         "",
                              //     remarks: summary?.priceGainLoss?.fiveYear
                              //             ?.chgPercentage ??
                              //         "" + " %",
                              //     valueColor: Utils.determineColorfromValue(
                              //         summary?.priceGainLoss?.fiveYear
                              //                 ?.absoluteChg ??
                              //             ""),
                              //     remarksColor: Utils.determineColorfromValue(
                              //         summary?.priceGainLoss?.fiveYear
                              //                 ?.absoluteChg ??
                              //             "")),
                              // TableItem(
                              //     title: "10 Years",
                              //     value: summary?.priceGainLoss?.tenYear
                              //             ?.absoluteChg ??
                              //         "",
                              //     remarks: summary?.priceGainLoss?.tenYear
                              //             ?.chgPercentage ??
                              //         "" + " %",
                              //     valueColor: Utils.determineColorfromValue(
                              //         summary?.priceGainLoss?.tenYear
                              //                 ?.absoluteChg ??
                              //             ""),
                              //     remarksColor: Utils.determineColorfromValue(
                              //         summary?.priceGainLoss?.tenYear
                              //                 ?.absoluteChg ??
                              //             "")),
                              // SizedBox(height: 32),
                              // new Text("High / Lows", style: subtitle1White),
                              // SizedBox(height: 30),
                              // TableBar(
                              //     title1: "Duration",
                              //     title2: "High",
                              //     title3: "Low"),
                              // SizedBox(height: 12),
                              // TableItem(
                              //     title: "1 Week",
                              //     value:
                              //         summary?.highsLows?.oneWeek?.high ?? "",
                              //     remarks:
                              //         summary?.highsLows?.oneWeek?.low ?? ""),
                              // TableItem(
                              //     title: "2 Weeks",
                              //     value:
                              //         summary?.highsLows?.twoWeeks?.high ?? "",
                              //     remarks:
                              //         summary?.highsLows?.twoWeeks?.low ?? ""),
                              // TableItem(
                              //     title: "1 Month",
                              //     value:
                              //         summary?.highsLows?.oneMonth?.high ?? "",
                              //     remarks:
                              //         summary?.highsLows?.oneMonth?.low ?? ""),
                              // TableItem(
                              //     title: "3 Months",
                              //     value:
                              //         summary?.highsLows?.threeMonths?.high ??
                              //             "",
                              //     remarks:
                              //         summary?.highsLows?.threeMonths?.low ??
                              //             ""),
                              // TableItem(
                              //     title: "6 Months",
                              //     value:
                              //         summary?.highsLows?.sixMonths?.high ?? "",
                              //     remarks:
                              //         summary?.highsLows?.sixMonths?.low ?? ""),
                              // TableItem(
                              //     title: "1 Year",
                              //     value:
                              //         summary?.highsLows?.oneYear?.high ?? "",
                              //     remarks:
                              //         summary?.highsLows?.oneYear?.low ?? ""),
                              // TableItem(
                              //     title: "2 Years",
                              //     value:
                              //         summary?.highsLows?.twoYear?.high ?? "",
                              //     remarks:
                              //         summary?.highsLows?.twoYear?.low ?? ""),
                              // TableItem(
                              //     title: "5 Years",
                              //     value:
                              //         summary?.highsLows?.fiveYear?.high ?? "",
                              //     remarks:
                              //         summary?.highsLows?.fiveYear?.low ?? ""),
                              // TableItem(
                              //     title: "10 Years",
                              //     value:
                              //         summary?.highsLows?.tenYear?.high ?? "",
                              //     remarks:
                              //         summary?.highsLows?.tenYear?.low ?? ""),
                              // SizedBox(height: 32),
                              // Text("Key Moving Averages",
                              //     style: subtitle1White),
                              // SizedBox(height: 30),
                              // TableBar(
                              //     title1: "MA", title2: "SMA", title3: "EMA"),
                              // SizedBox(height: 12),
                              // TableItem(
                              //     title: "5 Days",
                              //     value: summary
                              //             ?.keyMovingAverage?.the5Days?.sma ??
                              //         "",
                              //     remarks: summary
                              //             ?.keyMovingAverage?.the5Days?.ema ??
                              //         ""),
                              // TableItem(
                              //     title: "15 Days",
                              //     value: summary
                              //             ?.keyMovingAverage?.the15Days?.sma ??
                              //         "",
                              //     remarks: summary
                              //             ?.keyMovingAverage?.the15Days?.ema ??
                              //         ""),
                              // TableItem(
                              //     title: "20 Days",
                              //     value: summary
                              //             ?.keyMovingAverage?.the20Days?.sma ??
                              //         "",
                              //     remarks: summary
                              //             ?.keyMovingAverage?.the20Days?.ema ??
                              //         ""),
                              // TableItem(
                              //     title: "50 Days",
                              //     value: summary
                              //             ?.keyMovingAverage?.the50Days?.sma ??
                              //         "",
                              //     remarks: summary
                              //             ?.keyMovingAverage?.the50Days?.ema ??
                              //         ""),
                              // TableItem(
                              //     title: "100 Days",
                              //     value: summary
                              //             ?.keyMovingAverage?.the100Days?.sma ??
                              //         "",
                              //     remarks: summary
                              //             ?.keyMovingAverage?.the100Days?.ema ??
                              //         ""),
                              // TableItem(
                              //     title: "200 Days",
                              //     value: summary
                              //             ?.keyMovingAverage?.the200Days?.sma ??
                              //         "",
                              //     remarks: summary
                              //             ?.keyMovingAverage?.the200Days?.ema ??
                              //         ""),
                              // SizedBox(height: 32),
                              // Text("Key Technical Indicators",
                              //     style: subtitle1White),
                              // SizedBox(height: 20),
                              // CustomRow(
                              //     "MACD",
                              //     summary?.technicalIndicators?.macd ?? "",
                              //     "RSI",
                              //     summary?.technicalIndicators?.rsi ?? ""),
                              // CustomRow(
                              //     "RSI (Smooth)",
                              //     summary?.technicalIndicators?.rsiSmooth ?? "",
                              //     "ADX",
                              //     summary?.technicalIndicators?.adx ?? ""),
                              // CustomRow(
                              //     "Chaikin Money Flow",
                              //     summary?.technicalIndicators
                              //             ?.chaikinMoneyFlow ??
                              //         "",
                              //     "Williams %R",
                              //     summary?.technicalIndicators
                              //             ?.williamsPercentR ??
                              //         ""),
                              // CustomRow(
                              //     "PSAR",
                              //     summary?.technicalIndicators?.psar ?? "",
                              //     "",
                              //     ""),
                              // SizedBox(height: 32),
                              // Text("Financial Data Highlights",
                              //     style: subtitle1White),
                              // SizedBox(height: 20),
                              // CustomRow(
                              //     "Market Cap",
                              //     summary?.financialDataHighlights?.marketCap ??
                              //         "",
                              //     "Book Value / Share",
                              //     summary?.financialDataHighlights
                              //             ?.bookValueShare ??
                              //         ""),
                              // CustomRow(
                              //     "Enterprise Value",
                              //     summary?.financialDataHighlights
                              //             ?.enterpriseValue ??
                              //         "",
                              //     "Revenue TTM",
                              //     summary?.financialDataHighlights
                              //             ?.revenueTtm ??
                              //         ""),
                              // CustomRow(
                              //     "Gross Profit TTM",
                              //     summary?.financialDataHighlights
                              //             ?.grossProfitTtm ??
                              //         "",
                              //     "Revenue / Share TTM",
                              //     summary?.financialDataHighlights
                              //             ?.revenueShareTtm ??
                              //         ""),
                              // CustomRow(
                              //     "Consensus Target",
                              //     summary?.financialDataHighlights
                              //             ?.consensusTarget ??
                              //         "",
                              //     "",
                              //     ""),
                              // SizedBox(height: 32),
                              // Text("Financial Ratios", style: subtitle1White),
                              // SizedBox(height: 20),
                              // CustomRow(
                              //     "EPS",
                              //     summary?.financialRatios?.eps ?? "",
                              //     "PE",
                              //     summary?.financialRatios?.pe ?? ""),
                              // CustomRow(
                              //     "Div Yield",
                              //     summary?.financialRatios?.divYield ?? "",
                              //     "Div/Share",
                              //     summary?.financialRatios?.divShare ?? ""),
                              // CustomRow(
                              //     "Trailing PE",
                              //     summary?.financialRatios?.trailingPe ?? "",
                              //     "Forward PE",
                              //     summary?.financialRatios?.forwardPe ?? ""),
                              // CustomRow("Price / Book", "204.93", "", ""),
                              // SizedBox(height: 32),
                              // Text("Key Profit & Loss Data",
                              //     style: subtitle1White),
                              // SizedBox(height: 30),
                              // TableBar(
                              //     title1: "Period",
                              //     title2: "31 Mar 2020",
                              //     title3: "Growth"),
                              // SizedBox(height: 12),
                              // TableItem(
                              //     title: "Net Inc",
                              //     value: summary
                              //             ?.keyProfitLossData?.netInc?.amount ??
                              //         "",
                              //     remarks: summary
                              //             ?.keyProfitLossData?.netInc?.growth ??
                              //         ""),
                              // TableItem(
                              //     title: "Ops Income",
                              //     value: summary?.keyProfitLossData?.opsIncome
                              //             ?.amount ??
                              //         "",
                              //     remarks: summary?.keyProfitLossData?.opsIncome
                              //             ?.growth ??
                              //         ""),
                              // TableItem(
                              //     title: "Revenue",
                              //     value: summary?.keyProfitLossData?.revenue
                              //             ?.amount ??
                              //         "",
                              //     remarks: summary?.keyProfitLossData?.revenue
                              //             ?.growth ??
                              //         ""),
                              // TableItem(
                              //     title: "Ops Expense",
                              //     value: summary?.keyProfitLossData?.opsExpense
                              //             ?.amount ??
                              //         "",
                              //     remarks: summary?.keyProfitLossData
                              //             ?.opsExpense?.growth ??
                              //         ""),
                              // TableItem(
                              //     title: "PBT",
                              //     value:
                              //         summary?.keyProfitLossData?.pbt?.amount ??
                              //             "",
                              //     remarks:
                              //         summary?.keyProfitLossData?.pbt?.growth ??
                              //             ""),
                              // TableItem(
                              //     title: "Gross Profit",
                              //     value: summary?.keyProfitLossData?.grossProfit
                              //             ?.amount ??
                              //         "",
                              //     remarks: summary?.keyProfitLossData
                              //             ?.grossProfit?.growth ??
                              //         ""),
                              // TableItem(
                              //     title: "Div Paid",
                              //     value: summary?.keyProfitLossData?.divPaid
                              //             ?.amount ??
                              //         "",
                              //     remarks: summary?.keyProfitLossData?.divPaid
                              //             ?.growth ??
                              //         ""),
                              // SizedBox(height: 34),
                              // Text("Price Range/Volatility",
                              //     style: subtitle1White),
                              // SizedBox(height: 22),
                              // TableBar(
                              //     title1: "Period",
                              //     title2: "Avg PR",
                              //     title3: "Range %"),
                              // SizedBox(height: 12),
                              // TableItem(
                              //     title: "LBD PR",
                              //     value: summary?.priceRangeVolatility?.lbdPr
                              //             ?.avgPr ??
                              //         "",
                              //     remarks: summary?.priceRangeVolatility?.lbdPr
                              //             ?.rangePercentage ??
                              //         ""),
                              // TableItem(
                              //     title: "Week PR",
                              //     value: summary?.priceRangeVolatility?.weekPr
                              //             ?.avgPr ??
                              //         "",
                              //     remarks: summary?.priceRangeVolatility?.weekPr
                              //             ?.rangePercentage ??
                              //         ""),
                              // TableItem(
                              //     title: "Month PR",
                              //     value: summary?.priceRangeVolatility?.monthPr
                              //             ?.avgPr ??
                              //         "",
                              //     remarks: summary?.priceRangeVolatility
                              //             ?.monthPr?.rangePercentage ??
                              //         ""),
                              // TableItem(
                              //     title: "5 Days",
                              //     value: summary?.priceRangeVolatility
                              //             ?.the5DayPeriod?.avgPr ??
                              //         "",
                              //     remarks: summary?.priceRangeVolatility
                              //             ?.the5DayPeriod?.rangePercentage ??
                              //         ""),
                              // TableItem(
                              //     title: "10 Days",
                              //     value: summary?.priceRangeVolatility
                              //             ?.the10DayPeriod?.avgPr ??
                              //         "",
                              //     remarks: summary?.priceRangeVolatility
                              //             ?.the10DayPeriod?.rangePercentage ??
                              //         ""),
                              // TableItem(
                              //     title: "5 Weeks",
                              //     value: summary?.priceRangeVolatility
                              //             ?.the5WeekPeriod?.avgPr ??
                              //         "",
                              //     remarks: summary?.priceRangeVolatility
                              //             ?.the5WeekPeriod?.rangePercentage ??
                              //         ""),
                              // TableItem(
                              //     title: "3 Months",
                              //     value: summary?.priceRangeVolatility
                              //             ?.the3MonthsPeriod?.avgPr ??
                              //         "",
                              //     remarks: summary?.priceRangeVolatility
                              //             ?.the3MonthsPeriod?.rangePercentage ??
                              //         ""),
                            ],
                          ),
                        ),
                      )
                    : NoDataAvailablePage(),
              );
  }
}
