import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:technical_ind/components/CircularSFindicator.dart';
import 'package:technical_ind/components/LoadingPage.dart';
import 'package:technical_ind/components/noDataAvailable.dart';
import 'package:technical_ind/screens/stocks/business/stockServices.dart';
import '../../../styles.dart';
import '../../../widgets/item.dart';
import 'package:technical_ind/screens/stocks/business/models/StockDetailsModel.dart';

class QualityPage extends StatefulWidget {
  final String isin;
  QualityPage({Key key, this.isin}) : super(key: key);

  @override
  _QualityPageState createState() => _QualityPageState();
}

class _QualityPageState extends State<QualityPage> {
  var rand = new Random();
  double _current = 70;
  Quality quality;
  bool loading = true;
  fetchApi() async {
    quality = await StockServices.stockQualityDetail(widget.isin);
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    fetchApi();
    super.initState();
  }

  _ValuationRef colorFromText(String s) {
    print(s);
    switch (s) {
      case "Below Average":
        return _ValuationRef(red, 0.25);
      case "Average":
        return _ValuationRef(yellow, 0.50);
      case "Good":
        return _ValuationRef(blue2, 0.75);
      case "Excellent":
        return _ValuationRef(blue, 1);
      default:
        return _ValuationRef(yellow, 0.1);
    }
  }

  @override
  Widget build(BuildContext context) {
    _ValuationRef v = quality != null
        ? colorFromText(quality.quality)
        : _ValuationRef(yellow, 0.0);
    return loading
        ? LoadingPage()
        : quality == null
            ? NoDataAvailablePage()
            : Scaffold(
                // backgroundColor: kindaWhite,
                body: SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 42),
                        CircularSFindicator(
                          radius: 196,
                          thickness: 30,
                          value: v?.percent != null ? v.percent * 100 : 0.0,
                          center: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(quality.quality ?? "", style: subtitle18),
                              Text("Quality Grade", style: captionWhite38),
                            ],
                          ),
                          color: v?.color ?? yellow,
                        ),
                        SizedBox(height: 22),
                        new Text("Factors",
                            textAlign: TextAlign.center, style: captionWhite60),
                        SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            new Text("Management Risk", style: bodyText2White),
                            new Text("Growth", style: bodyText2White),
                            new Text("Capital Structure", style: bodyText2White)
                          ],
                        ),
                        SizedBox(height: 38),
                        Text("Key Factors", style: subtitle1White),
                        SizedBox(height: 26),
                        RowItem(
                            "Sales Growth (5 Years)", quality.salesGrowth ?? "",
                            pad: 10),
                        RowItem(
                            "EBIT Growth (5 Years)", quality.ebitGrowth ?? "",
                            pad: 10),
                        RowItem("Net debt to Equity (Avg)",
                            quality.netDebtToEquityAvg ?? "",
                            pad: 10),
                        RowItem("Institutional Holding",
                            quality.institutionalHolding ?? "",
                            pad: 10),
                        RowItem("ROE (Avg)", quality.roeAvg ?? "", pad: 10),
                        RowItem("Debt to EBITDA (Avg)",
                            quality.debtToEbitdaAvg ?? "",
                            pad: 10),
                        RowItem("EBIT to Interest (Avg)",
                            quality.ebitToInterestAvg ?? "",
                            pad: 10),
                        RowItem("Sales to Capital Employed (Avg)",
                            quality.salesToCapitalEmployedAvg ?? "",
                            pad: 10),
                        RowItem("Tax Ratio", quality.taxRatio ?? "", pad: 10),
                        RowItem("Dividend Payout Ratio",
                            quality.dividendPayoutRatio ?? "",
                            pad: 10),
                        RowItem("Pledged Shares", quality.pledgedShares ?? "",
                            pad: 10),
                        RowItem("Related Party Transactions to Sales",
                            quality.relatedPartyTransactionsToSales ?? "",
                            pad: 10),
                        RowItem("ROCE (Avg)", quality.roceAvg ?? "", pad: 10),
                      ],
                    ),
                  ),
                ),
              );
  }
}

class _ValuationRef {
  final Color color;
  final double percent;

  _ValuationRef(this.color, this.percent);
}
