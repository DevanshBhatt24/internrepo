import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marquee_text/marquee_text.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:technical_ind/components/LoadingPage.dart';
import 'package:technical_ind/components/codeSearch.dart';
import 'package:technical_ind/components/utils.dart';
import 'package:technical_ind/screens/stocks/explore/home.dart';

import '../../styles.dart';
import '../../widgets/appbar_with_back_and_search.dart';
import 'sectorSense.dart';
import 'business/sectorSense/sectorSenseCodeModel.dart';
import 'business/sectorSense/sectorSenseServices.dart';

class SectorSenseIndividual extends StatefulWidget {
  final String code;
  final String title;
  SectorSenseIndividual({Key key, this.code, this.title}) : super(key: key);

  @override
  _SectorSenseIndividualState createState() => _SectorSenseIndividualState();
}

class _SectorSenseIndividualState extends State<SectorSenseIndividual> {
  List<SectorSenseCodeModel> sectorSenseIndiList;
  bool _loading = true;

  void getSectorSenseIndividual() async {
    sectorSenseIndiList =
        await SectorSenseServices.getSectorSenseIndividual(widget.code);
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getSectorSenseIndividual();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithBack(
        text: widget.title,
      ),
      body: _loading
          ? LoadingPage()
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: ListView(children: [
                SizedBox(height: 24),
                buildHeading('Trend'),
                Text(sectorSenseIndiList[0].trendText,
                    textAlign: TextAlign.center, style: captionWhite60),
                SizedBox(height: 35),
                buildHeading('Growthcard'),
                SizedBox(height: 22),
                Container(
                  //height: 305,
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    runAlignment: WrapAlignment.center,
                    alignment: WrapAlignment.center,
                    children: [
                      GrowthCardTile(
                        title: "Positive Profit Growth",
                        value: sectorSenseIndiList[1]
                            .growthcard[0]
                            .positiveProfitGrowth,
                        color: blue,
                      ),
                      GrowthCardTile(
                        title: "Negative Profit Growth",
                        value: sectorSenseIndiList[1]
                            .growthcard[1]
                            .negativeProfitGrowth,
                        color: red,
                      ),
                      GrowthCardTile(
                        title: "Neutral Profit Growth",
                        value: sectorSenseIndiList[1]
                            .growthcard[2]
                            .neutralProfitGrowth,
                        color: Color(0xfff9bf13),
                      ),
                      GrowthCardTile(
                        title: "Total Revenue Growth",
                        value: sectorSenseIndiList[1]
                            .growthcard[3]
                            .totalRevenueGrowth
                            .replaceAll(new RegExp(r"\s+"), " "),
                        color: sectorSenseIndiList[1]
                                    .growthcard[3]
                                    .totalRevenueGrowth[0] ==
                                '-'
                            ? red
                            : blue,
                      ),
                      GrowthCardTile(
                        title: "Total EBIT Growth",
                        value: sectorSenseIndiList[1]
                            .growthcard[4]
                            .totalEbidtGrowth
                            .replaceAll(new RegExp(r"\s+"), " "),
                        color: blue,
                      ),
                      GrowthCardTile(
                        title: "Total Oper. Profit Growth",
                        value: sectorSenseIndiList[1]
                            .growthcard[5]
                            .totalOperProfitGrowth
                            .replaceAll(new RegExp(r"\s+"), " "),
                        color: blue,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 34),
                buildHeading("Company Results"),
                SizedBox(height: 30),
                ...List.generate(sectorSenseIndiList[2].tabularData.length,
                    (i) {
                  return buildCard(
                      sectorSenseIndiList[2].tabularData[i].stock,
                      sectorSenseIndiList[2].tabularData[i].lastResultUpdated,
                      sectorSenseIndiList[2]
                          .tabularData[i]
                          .marketCapitalizationCr,
                      sectorSenseIndiList[2]
                          .tabularData[i]
                          .operatingRevenuesQtrCr,
                      sectorSenseIndiList[2].tabularData[i].revenueGrowthQtrYoY,
                      sectorSenseIndiList[2].tabularData[i].netProfitQtrCr,
                      sectorSenseIndiList[2]
                          .tabularData[i]
                          .netProfitQtrGrowthYoY,
                      sectorSenseIndiList[2]
                          .tabularData[i]
                          .operatingProfitGrowthQtrYoY,
                      sectorSenseIndiList[2].tabularData[i].ebitGrowthYoY,
                      sectorSenseIndiList[2]
                          .tabularData[i]
                          .operatingProfitMarginGrowthYoY,
                      sectorSenseIndiList[2].tabularData[i].stockCode);
                })
              ]),
            ),
    );
  }

  Widget buildCard(
      String title,
      String date,
      String mktcap,
      String operrev,
      String revgrowth,
      String netprof,
      String netprofyoy,
      String operp,
      String ebid,
      String operyoy,
      String stockCode) {
    List<String> menu = [
      'Market Capitalization (Cr)',
      'Operating Revenues Qtr (Cr)',
      'Revenue Growth Qtr YoY %',
      'Net Profit Qtr (Cr)',
      'Net Profit Qtr Growth YoY %',
      'Operating Profit Growth Qtr Yoy %',
      'EBIDT Growth Yoy %',
      'Operating Profit Margin Growth Yoy %'
    ];
    List<String> values = [
      mktcap,
      operrev,
      revgrowth,
      netprof,
      netprofyoy,
      operp,
      ebid,
      operyoy
    ];
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: darkGrey,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        children: [
          // Text(title, textAlign: TextAlign.center, style: subtitle1White),
          MarqueeText(
            text: TextSpan(text: title),
            style: subtitle1White,
            speed: 10,
          ),
          Text(date, textAlign: TextAlign.center, style: captionWhite),
          SizedBox(
            height: 14,
          ),
          ...List.generate(menu.length, (i) {
            return InkWell(
              onTap: () async {
                CodeSearch codeSearch =
                    await Utils.getStockCodes('trendlyne_id', stockCode);
                pushNewScreen(
                  context,
                  withNavBar: false,
                  screen: Homepage(
                    name: title,
                    isin: codeSearch.isin,
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      menu[i],
                      style: bodyText2White60,
                    ),
                    Text(
                      values[i],
                      style: bodyText2White,
                    )
                  ],
                ),
              ),
            );
          })
        ],
      ),
    );
  }

  Text buildHeading(String title) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w500,
        color: Color(0xffffffff),
      ),
    );
  }
}
