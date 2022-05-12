// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
// import 'package:tab_indicator_styler/tab_indicator_styler.dart';
// import 'package:technical_ind/components/LoadingPage.dart';

// import '../../components/customcard.dart';
// import '../../styles.dart';
// import '../../widgets/appbar_with_back_and_search.dart';
// import '../../widgets/item.dart';
// import 'business/models/gainerLoserModel.dart';
// import 'business/stockServices.dart';
// import 'explore/home.dart';

// class GainLosePage extends StatefulWidget {
//   GainLosePage({Key key}) : super(key: key);

//   @override
//   _GainLosePageState createState() => _GainLosePageState();
// }

// class _GainLosePageState extends State<GainLosePage> {
//   int _selected = 0;

//   int crossAxisCount;
//   List<GainerLoser> nsegainer, nseloser, bsegainer, bseloser;
//   _fetchApi() async {
//     nsegainer = await StockServices.gainerLosers("nsegainer");
//     setState(() {});
//     nseloser = await StockServices.gainerLosers("nseloser");
//     setState(() {});
//     bsegainer = await StockServices.gainerLosers("bsegainer");
//     setState(() {});
//     bseloser = await StockServices.gainerLosers("bseloser");
//     setState(() {});
//   }

//   @override
//   void initState() {
//     super.initState();
//     _fetchApi();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//         length: 2,
//         initialIndex: 0,
//         child: Scaffold(
//           //backgroundColor: Colors.black,
//           appBar: PreferredSize(
//               preferredSize: Size.fromHeight(168),
//               child: Column(
//                 children: [
//                   AppBarWithBack(
//                     text: 'Gainers/Losers',
//                   ),
//                   TabBar(
//                     labelStyle: buttonWhite,
//                     unselectedLabelColor: white38,
//                     //indicatorSize: TabBarIndicatorSize.label,
//                     indicator: MaterialIndicator(
//                       horizontalPadding: 30,
//                       bottomLeftRadius: 8,
//                       bottomRightRadius: 8,
//                       color: Colors.white,
//                       paintingStyle: PaintingStyle.fill,
//                     ),
//                     tabs: [
//                       Tab(
//                         text: "BSE",
//                       ),
//                       Tab(
//                         text: "NSE",
//                         //child: NSEtab(),
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 18,
//                   ),
//                   Row(
//                     children: [
//                       _button(0, 'Top Gainers'),
//                       _button(1, 'Top Losers')
//                     ],
//                   )
//                 ],
//               )),
//           body: Padding(
//             padding: EdgeInsets.only(top: 18, left: 16, right: 16),
//             child: LayoutBuilder(
//               builder: (context, constraints) {
//                 if (constraints.maxWidth < 600)
//                   crossAxisCount = 2;
//                 else {
//                   crossAxisCount = 4;
//                 }
//                 return TabBarView(children: [
//                   bsegainer != null && bseloser != null
//                       ? section(context, bsegainer, bseloser)
//                       : LoadingPage(),
//                   nsegainer != null && nseloser != null
//                       ? section(context, nsegainer, nseloser)
//                       : LoadingPage(),
//                 ]);
//               },
//             ),
//           ),
//         ));
//   }

//   Widget section(
//       BuildContext context, List<GainerLoser> a, List<GainerLoser> b) {
//     List<GainerLoser> data = _selected == 0 ? a : b;
//     return GridView.count(
//       childAspectRatio: 0.89,
//       crossAxisCount: crossAxisCount,
//       crossAxisSpacing: 8,
//       mainAxisSpacing: 8,
//       children: List.generate(
//           data.length,
//           (index) => InkWell(
//                 onTap: () {
//                   pushNewScreen(
//                     context,
//                     withNavBar: false,
//                     screen: Homepage(),
//                   );
//                 },
//                 child: CustomCardStock(
//                   title: data[index].companyName,
//                   price: data[index].price,
//                   highlight: double.parse(data[index].change) > 0
//                       ? "+${data[index].change} (+${data[index].chg} %)"
//                       : "${data[index].change} (${data[index].chg} %)",
//                   color: double.parse(data[index].change) > 0 ? blue : red,
//                   list: [
//                     RowItem(
//                       "High",
//                       data[index].high,
//                       fontsize: 14,
//                       pad: 3,
//                     ),
//                     RowItem(
//                       "Low",
//                       data[index].low,
//                       fontsize: 14,
//                       pad: 3,
//                     ),
//                     RowItem(
//                       "Prev Close",
//                       data[index].prevClose,
//                       fontsize: 14,
//                       pad: 3,
//                     ),
//                   ],
//                 ),
//               )),
//     );
//   }

//   Expanded _button(int index, String title) {
//     return Expanded(
//         child: Center(
//       child: InkWell(
//         onTap: () {
//           setState(() {
//             _selected = index;
//           });
//         },
//         child: Container(
//           width: 150,
//           height: 40,
//           padding: EdgeInsets.symmetric(vertical: 9),
//           decoration: BoxDecoration(
//               color: _selected == index ? almostWhite : Colors.transparent,
//               borderRadius: BorderRadius.circular(6)),
//           child: Center(
//               child: Text(
//             title,
//             style:
//                 button.copyWith(color: _selected == index ? darkGrey : white38),
//           )),
//         ),
//       ),
//     ));
//   }

//   Padding _row(String title, String val) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 3),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             title,
//             style: captionWhite60,
//           ),
//           Text(
//             val,
//             style: captionWhite,
//           )
//         ],
//       ),
//     );
//   }
// }
