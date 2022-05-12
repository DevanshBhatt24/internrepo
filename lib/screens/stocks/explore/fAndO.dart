import 'package:flutter/material.dart';
import 'package:technical_ind/components/LoadingPage.dart';
import 'package:technical_ind/components/noDataAvailable.dart';
import 'package:technical_ind/screens/indices/business/indices_services.dart';
import 'package:technical_ind/screens/stocks/business/models/StockDetailsModel.dart';
import 'package:technical_ind/screens/stocks/business/stockServices.dart';

import '../../../styles.dart';

class FandO extends StatefulWidget {
  final String query;
  final String isin;
  FandO({this.query, this.isin});

  @override
  _FandOState createState() => _FandOState();
}

class _FandOState extends State<FandO> {
  FutureAndOptions futureAndOptions;
  bool loading;
  fetchApi() async {
    if (widget.query != null) {
      futureAndOptions =
          await IndicesServices.getFandO(widget.query.replaceAll(' ', '_'));
    } else if (widget.isin != null) {
      futureAndOptions =
          await StockServices.stockFutureandOptionsDetails(widget.isin);
    }
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    loading = true;
    fetchApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? LoadingPage()
        : (futureAndOptions.summary == null ||
                futureAndOptions.callSummary == null ||
                futureAndOptions.futureSummary == null)
            ? NoDataAvailablePage()
            : Scaffold(
                body: SingleChildScrollView(
                  child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          SizedBox(height: 38),
                          Text("Summary", style: subtitle1White),
                          SizedBox(height: 16),
                          CustomRow(
                              'Near Expiry date',
                              futureAndOptions?.summary?.nearExpiry != 'no data'
                                  ? '${futureAndOptions?.summary?.nearExpiry}'
                                  : '-',
                              'Lot Size',
                              futureAndOptions?.summary?.lotSize != 'no data'
                                  ? '${futureAndOptions?.summary?.lotSize??""}'
                                  : '-'),
                          CustomRow(
                              'Stock Close Price',
                              futureAndOptions?.summary?.stockClosePrice !=
                                      'no data'
                                  ? '${futureAndOptions?.summary?.stockClosePrice}'
                                  : '-',
                              'Trade Date',
                              futureAndOptions?.summary?.tradeDate != 'no data'
                                  ? '${futureAndOptions?.summary?.tradeDate}'
                                  : '-'),
                          SizedBox(height: 34),
                          Text("Futures Summary", style: subtitle1White),
                          SizedBox(height: 16),
                          _row(
                              'Closing Price',
                              futureAndOptions?.futureSummary?.closingPrice !=
                                      'no data'
                                  ? '${futureAndOptions?.futureSummary?.closingPrice}'
                                  : '-',
                              '',
                              ''),
                          _row(
                              'Premium / Discount',
                              futureAndOptions?.futureSummary?.premiumDiscount !=
                                      'no data'
                                  ? '${futureAndOptions?.futureSummary?.premiumDiscount}'
                                  : '-',
                              '',
                              ''),
                          _row(
                              'Previous Close',
                              futureAndOptions?.futureSummary?.previousClose !=
                                      'no data'
                                  ? '${futureAndOptions?.futureSummary?.previousClose}'
                                  : '-',
                              '(Chg %)',
                              futureAndOptions
                                          ?.futureSummary?.previousCloseChange !=
                                      'no data'
                                  ? '(${futureAndOptions?.futureSummary?.previousCloseChange} %)'
                                  : '-'),
                          _row(
                              'Future OI',
                              futureAndOptions?.futureSummary?.futureOi !=
                                      'no data'
                                  ? '${futureAndOptions?.futureSummary?.futureOi}'
                                  : '-',
                              '(Chg %)',
                              futureAndOptions?.futureSummary?.futureOiChange !=
                                      'no data'
                                  ? '(${futureAndOptions?.futureSummary?.futureOiChange} %)'
                                  : '-'),
                          _row(
                              'Futures Contracts',
                              futureAndOptions?.futureSummary?.futureContracts !=
                                      'no data'
                                  ? '${futureAndOptions?.futureSummary?.futureContracts}'
                                  : '-',
                              '(Chg %)',
                              futureAndOptions?.futureSummary
                                          ?.futureContractsChange !=
                                      'no data'
                                  ? '(${futureAndOptions?.futureSummary?.futureContractsChange} %)'
                                  : '-'),
                          SizedBox(height: 34),
                          Text("Call & Put Summary", style: subtitle1White),
                          SizedBox(height: 16),
                          TableBar('', 'CALL', 'PUT'),
                          SizedBox(height: 12),
                          TableItemv2(
                              'Max Traded Strike Price',
                              futureAndOptions
                                          ?.callSummary?.maxTradedStrikePrice !=
                                      'no data'
                                  ? '${futureAndOptions?.callSummary?.maxTradedStrikePrice}'
                                  : '-',
                              futureAndOptions
                                          ?.putSummary?.maxTradedStrikePrice !=
                                      'no data'
                                  ? '${futureAndOptions?.putSummary?.maxTradedStrikePrice}'
                                  : '-'),
                          TableItemv2(
                              'Contracts',
                              futureAndOptions?.callSummary?.contracts !=
                                      'no data'
                                  ? '${futureAndOptions?.callSummary?.contracts}'
                                  : '-',
                              futureAndOptions?.putSummary?.contracts != 'no data'
                                  ? '${futureAndOptions?.putSummary?.contracts}'
                                  : '-'),
                          TableItemv2(
                              'Cumulative Call OI (Chg %)',
                              futureAndOptions?.callSummary?.cumulativeCallOi !=
                                      'no data'
                                  ? '${futureAndOptions?.callSummary?.cumulativeCallOi}\n(${futureAndOptions?.callSummary?.cumulativeCallOiChange} %)'
                                  : '-',
                              futureAndOptions?.putSummary?.cumulativeCallOi !=
                                      'no data'
                                  ? '${futureAndOptions?.putSummary?.cumulativeCallOi}\n(${futureAndOptions?.putSummary?.cumulativeCallOiChange} %)'
                                  : '-')
                        ],
                        crossAxisAlignment: CrossAxisAlignment.center,
                      )),
                ),
              );
  }

  Widget CustomRow(
    String a,
    String b,
    String c,
    String d,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(a, style: bodyText2White60),
                SizedBox(height: 4),
                Text(b, style: bodyText2White)
              ],
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(c, textAlign: TextAlign.end, style: bodyText2White60),
                SizedBox(height: 4),
                Text(d, textAlign: TextAlign.right, style: bodyText2White),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget TableBar(String title1, String title2, String title3) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
            color: darkGrey, borderRadius: BorderRadius.circular(4)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Text(
              title1,
              style: captionWhite60,
              textAlign: TextAlign.center,
            )),
            Expanded(
                child: Text(title2,
                    style: captionWhite60, textAlign: TextAlign.center)),
            Expanded(
                child: Text(title3,
                    style: captionWhite60, textAlign: TextAlign.center)),
          ],
        ));
  }

  Widget TableItemv2(String title, String value, String remarks) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Expanded(
            flex: 3,
            child: Text(
              title,
              textAlign: TextAlign.left,
              style: bodyText2White60,
            ),
          ),
          Expanded(
            flex: 3,
            child:
                Text(value, textAlign: TextAlign.center, style: bodyText2White),
          ),
          Expanded(
            flex: 3,
            child: Text(remarks,
                textAlign: TextAlign.center, style: bodyText2White),
          )
        ]));
  }

  Widget _row(String a, String b, String c, String d) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(a, style: bodyText2White60),
            (c != '') ? Text(c, style: bodyText2White60) : Container()
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(b, style: bodyText2White),
            (d != '') ? Text(d, style: bodyText2White) : Container()
          ],
        )
      ]),
    );
  }
}
