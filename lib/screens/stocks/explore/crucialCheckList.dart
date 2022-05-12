import 'package:flutter/material.dart';
import 'package:technical_ind/components/LoadingPage.dart';
import 'package:technical_ind/components/noDataAvailable.dart';
import 'package:technical_ind/screens/stocks/business/models/StockDetailsModel.dart';
import 'package:technical_ind/screens/stocks/business/stockServices.dart';
import '../../../styles.dart';

class CrucialChecklistPage extends StatefulWidget {
  final String isin;
  CrucialChecklistPage({this.isin});
  @override
  _CrucialChecklistPageState createState() => _CrucialChecklistPageState();
}

class _CrucialChecklistPageState extends State<CrucialChecklistPage> {
  CrucialChecklist arr;
  bool loading = true;
  fetchApi() async {
    arr = await StockServices.stockCrucialChecklistDetails(widget.isin);
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
        : arr == null
            ? NoDataAvailablePage()
            : Scaffold(
                body: arr.financials.length != 0 ||
                        arr.ownerships.length != 0 ||
                        arr.industryComparisons.length != 0 ||
                        arr.others.length != 0
                    ? SingleChildScrollView(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            children: [
                              if (arr.financials.length != 0)
                                SizedBox(height: 38),
                              if (arr.financials.length != 0)
                                Text("Financials", style: subtitle1White),
                              if (arr.financials.length != 0)
                                SizedBox(height: 21),
                              ...List.generate(
                                arr.financials.length,
                                (i) => _row(
                                    arr.financials[i].answer == 'true'
                                        ? true
                                        : false,
                                    arr.financials[i].question ?? ""),
                              ),
                              if (arr.ownerships.length != 0)
                                SizedBox(height: 38),
                              if (arr.ownerships.length != 0)
                                Text("Ownerships", style: subtitle1White),
                              if (arr.ownerships.length != 0)
                                SizedBox(height: 21),
                              ...List.generate(
                                arr.ownerships.length,
                                (i) => _row(
                                    arr.ownerships[i].answer == 'true'
                                        ? true
                                        : false,
                                    arr.ownerships[i].question),
                              ),
                              if (arr.industryComparisons.length != 0)
                                SizedBox(height: 38),
                              if (arr.industryComparisons.length != 0)
                                Text("Industry Comparison",
                                    style: subtitle1White),
                              if (arr.industryComparisons.length != 0)
                                SizedBox(height: 21),
                              ...List.generate(
                                arr.industryComparisons.length,
                                (i) => _row(
                                    arr.industryComparisons[i].answer == 'true'
                                        ? true
                                        : false,
                                    arr.industryComparisons[i].question ?? ""),
                              ),
                              if (arr.others.length != 0) SizedBox(height: 38),
                              if (arr.others.length != 0)
                                Text("Others", style: subtitle1White),
                              if (arr.others.length != 0) SizedBox(height: 21),
                              ...List.generate(
                                arr.others.length,
                                (i) => _row(
                                    arr.others[i].answer == 'true'
                                        ? true
                                        : false,
                                    arr.others[i].question),
                              ),
                            ],
                            crossAxisAlignment: CrossAxisAlignment.center,
                          ),
                        ),
                      )
                    : NoDataAvailablePage(),
              );
  }

  Widget _row(bool check, String s) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 9),
        child: Row(children: [
          check
              ? Icon(Icons.check_circle, color: blue, size: 20)
              : Icon(Icons.cancel_rounded, color: red, size: 20),
          SizedBox(width: 16),
          Expanded(
            child: Container(
                margin: EdgeInsets.only(right: 5),
                child: Text(s, style: bodyText2White)),
          )
        ]));
  }
}
