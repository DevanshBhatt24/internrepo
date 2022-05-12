import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marquee_text/marquee_text.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:technical_ind/components/LoadingPage.dart';

import '../../styles.dart';
import '../../widgets/appbar_with_back_and_search.dart';
import 'sectorSenseIndividual.dart';
import 'business/sectorSense/sectorSenseServices.dart';
import 'business/sectorSense/sectorSenseModel.dart';

class GrowthCardTile extends StatelessWidget {
  final String value, title;
  final Color color;

  const GrowthCardTile({Key key, this.value, this.title, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.symmetric(vertical: 6),
      height: 90,
      width: 0.438 * MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 16, top: 23, right: 9, bottom: 20),
      decoration: BoxDecoration(
        color: darkGrey,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(value, style: subtitle18.copyWith(color: color)),
              Container(
                margin: EdgeInsets.only(left: 8),
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  color: Color(0xff1c1c1e),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  color == blue
                      ? Icons.arrow_upward
                      : color == red
                          ? Icons.arrow_downward
                          : Icons.arrow_forward,
                  color: color,
                  size: 12,
                ),
              )
            ],
          ),
          SizedBox(height: 5),
          Text(title, style: caption.copyWith(color: color))
        ],
      ),
    );
  }
}

class SectorSense extends StatefulWidget {
  SectorSense({Key key}) : super(key: key);

  @override
  _SectorSenseState createState() => _SectorSenseState();
}

class _SectorSenseState extends State<SectorSense> {
  List<SectorSenseModel> sectorSenseList;
  bool _loading = true;
  void getSectorSenseList() async {
    sectorSenseList =
        await SectorSenseServices.getSectorSenseList().whenComplete(() {
      setState(() {
        _loading = false;
      });
    });
  }

  @override
  void initState() {
    getSectorSenseList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithBack(text: "Sector Sense"),
      body: _loading
          ? LoadingPage()
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: ListView(
                children: [
                  SizedBox(height: 24),
                  buildHeading('Trend'),
                  Text(sectorSenseList[0].data[0].trendText,
                      textAlign: TextAlign.center, style: captionWhite60),
                  SizedBox(height: 35),
                  buildHeading('Growthcard'),
                  SizedBox(height: 22),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [GrowthCardTile(
                  //         title: "Positive Profit Growth",
                  //         value: "1636",
                  //         color: blue,
                  //       ),
                  //       GrowthCardTile(
                  //         title: "Negative Profit Growth",
                  //         value: "1499",
                  //         color: red,
                  //       ),],),
                  Container(
                    // height: 305,
                    child: Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      runAlignment: WrapAlignment.center,
                      alignment: WrapAlignment.center,
                      children: [
                        GrowthCardTile(
                          title: "Positive Profit Growth",
                          value: sectorSenseList[0]
                              .data[1]
                              .growthcard[0]
                              .positiveProfitGrowth,
                          color: blue,
                        ),
                        GrowthCardTile(
                          title: "Negative Profit Growth",
                          value: sectorSenseList[0]
                              .data[1]
                              .growthcard[1]
                              .negativeProfitGrowth,
                          color: red,
                        ),
                        GrowthCardTile(
                          title: "Neutral Profit Growth",
                          value: sectorSenseList[0]
                              .data[1]
                              .growthcard[2]
                              .neutralProfitGrowth,
                          color: Color(0xfff9bf13),
                        ),
                        GrowthCardTile(
                          title: "Total Revenue Growth",
                          value: sectorSenseList[0]
                              .data[1]
                              .growthcard[3]
                              .totalRevenueGrowth
                              .replaceAll(new RegExp(r"\s+"), " "),
                          color: sectorSenseList[0]
                                      .data[1]
                                      .growthcard[3]
                                      .totalRevenueGrowth ==
                                  '-'
                              ? red
                              : blue,
                        ),
                        GrowthCardTile(
                          title: "Total EBIT Growth",
                          value: sectorSenseList[0]
                              .data[1]
                              .growthcard[4]
                              .totalEbidtGrowth
                              .replaceAll(new RegExp(r"\s+"), " "),
                          color: blue,
                        ),
                        GrowthCardTile(
                          title: "Total Oper. Profit Growth",
                          value: sectorSenseList[0]
                              .data[1]
                              .growthcard[5]
                              .totalOperProfitGrowth
                              .replaceAll(new RegExp(r"\s+"), " "),
                          color: blue,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 34),
                  buildHeading("Sectors"),
                  SizedBox(height: 30),
                  ...List.generate(
                      sectorSenseList[0].data[2].tabularData.length, (i) {
                    return InkWell(
                      onTap: () {
                        pushNewScreen(
                          context,
                          screen: SectorSenseIndividual(
                            title: sectorSenseList[0]
                                .data[2]
                                .tabularData[i]
                                .industry,
                            code:
                                sectorSenseList[0].data[2].tabularData[i].code,
                          ),
                        );
                      },
                      child: buildCard(
                          sectorSenseList[0].data[2].tabularData[i].industry,
                          sectorSenseList[0]
                              .data[2]
                              .tabularData[i]
                              .revenueGrowthYoY,
                          sectorSenseList[0]
                              .data[2]
                              .tabularData[i]
                              .netProfitGrowthYoY,
                          sectorSenseList[0]
                              .data[2]
                              .tabularData[i]
                              .operProfitGrowthYoY,
                          sectorSenseList[0]
                              .data[2]
                              .tabularData[i]
                              .ebitGrowthYoY,
                          sectorSenseList[0]
                              .data[2]
                              .tabularData[i]
                              .operProfitMarginGrowthYoY),
                    );
                  })
                ],
              ),
            ),
    );
  }

  Widget buildCard(String title, String rev, String net, String oper,
      String ebit, String operp) {
    List<String> menu = [
      "Revenue Growth YoY %",
      "Net Profit Growth YoY %",
      "Oper Profit Growth YoY %",
      "EBIT Growth YoY %",
      "Oper Profit Margin Growth YoY %"
    ];
    List<String> values = [
      rev,
      net,
      oper,
      ebit,
      operp,
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
          SizedBox(
            height: 14,
          ),
          ...List.generate(menu.length, (i) {
            return Padding(
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
            );
          })
        ],
      ),
    );
  }

  Text buildHeading(String title) {
    return Text(title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
          color: Color(0xffffffff),
        ));
  }
}

//-----------------------------------------------------------------------------//
//
//Just for mistakes to reverse
//
//
//import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

// import '../../styles.dart';
// import '../../widgets/appbar_with_back_and_search.dart';
// import 'sectorSenseIndividual.dart';

// class GrowthCardTile extends StatelessWidget {
//   final String value, title;
//   final Color color;

//   const GrowthCardTile({Key key, this.value, this.title, this.color})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       // margin: EdgeInsets.symmetric(vertical: 6),
//       height: 90,
//       width: 0.438 * MediaQuery.of(context).size.width,
//       padding: EdgeInsets.only(left: 16, top: 23, right: 9, bottom: 20),
//       decoration: BoxDecoration(
//         color: darkGrey,
//         borderRadius: BorderRadius.circular(6),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Row(
//             children: <Widget>[
//               Text(value, style: subtitle18.copyWith(color: color)),
//               Container(
//                 margin: EdgeInsets.only(left: 8),
//                 width: 18,
//                 height: 18,
//                 decoration: BoxDecoration(
//                   color: Color(0xff1c1c1e),
//                   shape: BoxShape.circle,
//                 ),
//                 child: Icon(
//                   color == blue
//                       ? Icons.arrow_upward
//                       : color == red
//                           ? Icons.arrow_downward
//                           : Icons.arrow_forward,
//                   color: color,
//                   size: 12,
//                 ),
//               )
//             ],
//           ),
//           SizedBox(height: 5),
//           Text(title, style: caption.copyWith(color: color))
//         ],
//       ),
//     );
//   }
// }

// class SectorSense extends StatefulWidget {
//   SectorSense({Key key}) : super(key: key);

//   @override
//   _SectorSenseState createState() => _SectorSenseState();
// }

// class _SectorSenseState extends State<SectorSense> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBarWithBack(text: "Sector Sense"),
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 16),
//         child: ListView(
//           children: [
//             SizedBox(height: 24),
//             buildHeading('Trend'),
//             Text('For Quarter ending Sep 30, 2020, by industry',
//                 textAlign: TextAlign.center, style: captionWhite60),
//             SizedBox(height: 35),
//             buildHeading('Growthcard'),
//             SizedBox(height: 22),
//             // Row(
//             //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             //   children: [GrowthCardTile(
//             //         title: "Positive Profit Growth",
//             //         value: "1636",
//             //         color: blue,
//             //       ),
//             //       GrowthCardTile(
//             //         title: "Negative Profit Growth",
//             //         value: "1499",
//             //         color: red,
//             //       ),],),
//             Container(
//               // height: 305,
//               child: Wrap(
//                 spacing: 12,
//                 runSpacing: 12,
//                 runAlignment: WrapAlignment.center,
//                 alignment: WrapAlignment.center,
//                 children: [
//                   GrowthCardTile(
//                     title: "Positive Profit Growth",
//                     value: "1636",
//                     color: blue,
//                   ),
//                   GrowthCardTile(
//                     title: "Negative Profit Growth",
//                     value: "1499",
//                     color: red,
//                   ),
//                   GrowthCardTile(
//                     title: "Neutral Profit Growth",
//                     value: "93",
//                     color: Color(0xfff9bf13),
//                   ),
//                   GrowthCardTile(
//                     title: "Total Revenue Growth",
//                     value: "-3.3 %",
//                     color: red,
//                   ),
//                   GrowthCardTile(
//                     title: "Total EBIT Growth",
//                     value: "31 %",
//                     color: blue,
//                   ),
//                   GrowthCardTile(
//                     title: "Total Oper. Profit Growth",
//                     value: "12 %",
//                     color: blue,
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 34),
//             buildHeading("Sectors"),
//             SizedBox(height: 30),
//             ...List.generate(5, (i) {
//               return InkWell(
//                   onTap: () {
//                     pushNewScreen(context, screen: SectorSenseIndividual());
//                   },
//                   child: buildCard('Heavy Electrical Equipment'));
//             })
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildCard(String title) {
//     List<String> menu = [
//       "Revenue Growth YoY %",
//       "Net Profit Growth YoY %",
//       "Oper Profit Growth YoY %",
//       "EBIT Growth YoY %",
//       "Oper Profit Margin Growth YoY %"
//     ];
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 4),
//       padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
//       decoration: BoxDecoration(
//         color: darkGrey,
//         borderRadius: BorderRadius.circular(6),
//       ),
//       child: Column(
//         children: [
//           Text(title, textAlign: TextAlign.center, style: subtitle1White),
//           SizedBox(
//             height: 14,
//           ),
//           ...List.generate(menu.length, (i) {
//             return Padding(
//               padding: const EdgeInsets.symmetric(vertical: 4),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     menu[i],
//                     style: bodyText2White60,
//                   ),
//                   Text(
//                     '9.44%',
//                     style: bodyText2White,
//                   )
//                 ],
//               ),
//             );
//           })
//         ],
//       ),
//     );
//   }

//   Text buildHeading(String title) {
//     return Text(title, textAlign: TextAlign.center, style: subtitle1White);
//   }
// }
