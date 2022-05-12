import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:technical_ind/components/CircularSFindicator.dart';
import 'package:technical_ind/components/LoadingPage.dart';
import 'package:technical_ind/components/noDataAvailable.dart';
import 'package:technical_ind/screens/stocks/business/models/StockDetailsModel.dart';
import 'package:technical_ind/screens/stocks/business/stockServices.dart';

import '../../../styles.dart';
import '../../../widgets/item.dart';

class ValuationPage extends StatefulWidget {
  final String isin;
  ValuationPage({
    Key key,
    this.isin,
  }) : super(key: key);

  @override
  _ValuationPageState createState() => _ValuationPageState();
}

class _ValuationPageState extends State<ValuationPage> {
  Valuation valuation;
  bool loading = true;

  fetchApi() async {
    valuation = await StockServices.stockValuationDetail(widget.isin);
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
    switch (s) {
      case "Very Risky":
        return _ValuationRef(red, 1.0);
      case "Risky":
        return _ValuationRef(red2, 0.75);
      case "Very Expensive":
        return _ValuationRef(red, 1.0);
      case "Expensive":
        return _ValuationRef(red2, 0.75);
      case "Very Attractive":
        return _ValuationRef(blue, 1.0);
      case "Attractive":
        return _ValuationRef(blue2, 0.75);
      case "Fair":
        return _ValuationRef(yellow, 0.75);
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    _ValuationRef v = valuation != null
        ? colorFromText(valuation.valuationGradeMeter)
        : _ValuationRef(yellow, 0.0);
    return loading
        ? LoadingPage()
        : valuation == null
            ? NoDataAvailablePage()
            : Scaffold(
                // backgroundColor: kindaWhite,
                body: SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        SizedBox(height: 40),
                        CircularSFindicator(
                          radius: 200,
                          thickness: 30,
                          value: v?.percent != null ? v.percent * 100 : 0.0,
                          center: new Text(valuation.valuationGradeMeter ?? "",
                              style: subtitle18),
                          color: v?.color ?? yellow,
                          backgroundColor: grey,
                        ),
                        SizedBox(height: 38),
                        new Text("Key Factors", style: subtitle1White),
                        SizedBox(height: 26),
                        RowItem("PE Ratio", valuation.peRatio ?? ""),
                        RowItem("Price to book value",
                            valuation.priceToBookValue ?? ""),
                        RowItem("EV to EBIT", valuation.evToEbit ?? ""),
                        RowItem("EV to EBITDA", valuation.evToEbitda ?? ""),
                        RowItem("EV to Capital Employed",
                            valuation.evToCapitalEmployed ?? ""),
                        RowItem("EV to Sales", valuation.evToSales ?? ""),
                        RowItem("PEG Ratio", valuation.pegRatio ?? ""),
                        RowItem(
                            "Dividend Yield", valuation.dividendYield ?? ""),
                        RowItem("ROCE (Latest)", valuation.roceLatest ?? ""),
                        RowItem("ROE (Latest)", valuation.roeLatest ?? ""),
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
