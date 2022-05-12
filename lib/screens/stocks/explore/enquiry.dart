import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:technical_ind/components/CircularSFindicator.dart';
import 'package:technical_ind/components/LoadingPage.dart';
import 'package:technical_ind/components/noDataAvailable.dart';
import 'package:technical_ind/screens/stocks/business/models/StockDetailsModel.dart';
import 'package:technical_ind/screens/stocks/business/stockServices.dart';
import '../../../components/bullet_colored.dart';
import '../../../styles.dart';

class Enquiry extends StatefulWidget {
  final String isin;
  Enquiry({this.isin});
  @override
  _EnquiryState createState() => _EnquiryState();
}

class _EnquiryState extends State<Enquiry> {
  Scrutiny scrutiny;
  bool loading = true;

  fetchApi() async {
    scrutiny = await StockServices.stockScrutinyDetails(widget.isin);
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
        : scrutiny == null ||
                (scrutiny.financials.piotroskiScore == "no data" &&
                    scrutiny?.financials?.text == "no data" &&
                    scrutiny?.financials?.cagrText == "no data")
            ? NoDataAvailablePage()
            : Scaffold(
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 26),
                        Text('Price', style: subtitle1White),
                        SizedBox(height: 12),
                        ...List.generate(
                          scrutiny.price.length,
                          (i) => BulletColored(
                            scrutiny.price[i].text ?? "",
                            scrutiny.price[i].status == 'nutral'
                                ? yellow
                                : scrutiny.price[i].status == 'red'
                                    ? red
                                    : blue,
                          ),
                        ),
                        // BulletColored(
                        //     'Mid Range Momentum - Stock is Mid Range compared to Short, Medium and Long Term Moving Averages',
                        //     blue),
                        // BulletColored('127.73 % away from 52 week low', red),
                        // BulletColored('15.84 % away from 52 week high', red),
                        // BulletColored(
                        //     'Underperformer - Reliance Industries up by 1.53 % v/s NIFTY 50 up by 5.32 % in last 1 month',
                        //     red),
                        // BulletColored('F&O data suggests Long Buildup today', blue),
                        // BulletColored('Stock saw 187 number of Large Deals today.', blue),
                        SizedBox(height: 22),
                        Text('Financials', style: subtitle1White),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Piotroski Score', style: captionWhite),
                            SizedBox(width: 8),
                            GestureDetector(
                              onTap: () => BotToast.showText(
                                contentColor: almostWhite,
                                duration: Duration(seconds: 3),
                                text:
                                    "The Piotroski Score is used to determine the best value stocks, with nine being the best and zero being the worst.",
                                textStyle: bodyText2White.copyWith(
                                    fontSize: 16, color: black),
                              ),
                              child: Icon(Icons.info_outline, color: white60),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        Container(
                          // height: 234,
                          width: 1 * MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          color: darkGrey,
                          child: Column(
                            children: [
                              CircularSFindicator(
                                radius: 56,
                                thickness: 6,
                                value: scrutiny?.financials?.piotroskiScore ==
                                        "no data"
                                    ? 0.0
                                    : double.parse(scrutiny
                                                ?.financials?.piotroskiScore ??
                                            "") *
                                        10,
                                center: scrutiny?.financials?.piotroskiScore ==
                                        "no data"
                                    ? Text("-")
                                    : Text(
                                        scrutiny?.financials?.piotroskiScore ??
                                            "",
                                        style: subtitle18),
                                color: scrutiny?.financials?.piotroskiScore ==
                                        "no data"
                                    ? yellow
                                    : [1, 2, 3, 4].contains(int.parse(scrutiny
                                                ?.financials?.piotroskiScore ??
                                            ""))
                                        ? red
                                        : int.parse(scrutiny?.financials
                                                        ?.piotroskiScore ??
                                                    "") ==
                                                5
                                            ? yellow
                                            : blue,
                              ),
                              SizedBox(height: 12),
                              Text(scrutiny?.financials?.text,
                                  style: subtitle18),
                              SizedBox(height: 18),
                              // Text(scrutiny?.financials?.cagrText ?? "",
                              //     style: subtitle1White),
                              // SizedBox(height: 12),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text('Revenue', style: captionWhite60),
                                        SizedBox(height: 4),
                                        Text(
                                            scrutiny?.financials?.revenue ?? "",
                                            style: bodyText2White)
                                      ]),
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text('Net Profit',
                                            style: captionWhite60),
                                        SizedBox(height: 4),
                                        Text(
                                            scrutiny?.financials?.netProfit ??
                                                "",
                                            style: bodyText2White)
                                      ]),
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text('OperationProfit',
                                            style: captionWhite60),
                                        SizedBox(height: 4),
                                        Text(
                                            scrutiny?.financials
                                                    ?.operatingProfit ??
                                                "",
                                            style: bodyText2White)
                                      ]),
                                ],
                              )
                            ],
                            crossAxisAlignment: CrossAxisAlignment.center,
                          ),
                        ),
                        SizedBox(height: 38),
                        Text('Industry Comparison', style: subtitle1White),
                        SizedBox(height: 14),
                        ...List.generate(
                          scrutiny?.industryComparison?.length ?? "",
                          (i) => BulletColored(
                            scrutiny?.industryComparison[i]?.text ?? "",
                            scrutiny?.industryComparison[i]?.status == 'nutral'
                                ? yellow
                                : scrutiny.industryComparison[i].status == 'red'
                                    ? red
                                    : blue,
                            status: i == 0
                                ? "TTM PE Ratio"
                                : i == 1
                                    ? "Market Cap"
                                    : i == 2
                                        ? "Price to Book Ratio"
                                        : "TTM PEG Ratio",
                          ),
                        ),
                        // BulletColored('TTM PE Ratio - Below industry Median', red),
                        // BulletColored('Market Cap - Market Leader', blue),
                        // BulletColored(
                        //     'Operating Profit Margin (TTM) - Company\'s Operating Profit Margin growth at -1.96 % v/s Industry growth of 2.01 %',
                        //     red),
                        // BulletColored('Price to Book Ratio - Below industry Median', red),
                        // BulletColored(
                        //     'Revenue Growth (TTM) - Company\'s Revenue growth at -17.89 % v/s Industry growth of -17.69 %',
                        //     red),
                        // BulletColored(
                        //     'Profit Growth (TTM) - Company\'s Profit growth at -2.84 % v/s Industry growth of -2.74 %',
                        //     red),
                        // BulletColored(
                        //     'TTM PEG Ratio - Negative PEG TTM Price to Earnings Growth',
                        //     red),
                        SizedBox(height: 28),
                        Text('Shareholding Pattern', style: subtitle1White),
                        SizedBox(height: 16),
                        ...List.generate(
                          scrutiny.shareholdingPattern.length,
                          (i) => BulletColored(
                            scrutiny?.shareholdingPattern[i]?.text ?? "",
                            scrutiny?.shareholdingPattern[i]?.status == 'nutral'
                                ? yellow
                                : scrutiny.shareholdingPattern[i].status ==
                                        'red'
                                    ? red
                                    : blue,
                          ),
                        ),
                        // BulletColored(
                        //     'Promoters have increased holdings from 50.37 % to 50.49 % in Sep 2020 qtr.',
                        //     blue),
                        // BulletColored(
                        //     'Mutual Funds have decreased holdings from 5.44 % to 5.12 % in Sep 2020 qtr.',
                        //     red),
                        // BulletColored(
                        //     'Number of Mutual Funds increased from 85 to 87  in Sep 2020 qtr.',
                        //     blue),
                        // BulletColored(
                        //     'FII/FPI have increased holdings from 24.72 % to 25.2 % in Sep 2020 qtr.',
                        //     blue),
                        // BulletColored(
                        //     'Number of FIIs/FPIs increased from 1976 to 2155 in Sep 2020 qtr.',
                        //     blue),
                        // BulletColored(
                        //     'Institutional Investors have increased holdings from 38.55 % to 38.59 % in Sep 2020 qtr.',
                        //     blue),
                      ],
                      crossAxisAlignment: CrossAxisAlignment.center,
                    ),
                  ),
                ),
              );
  }
}
