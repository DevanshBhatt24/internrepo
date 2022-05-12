// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import '../../styles.dart';
// import 'business/search_model.dart';
// import 'business/search_services.dart';
// import '../../widgets/appbar_with_back_and_search.dart';
//
// class SearchResultsPage2 extends StatefulWidget {
//   final String title;
//   SearchResultsPage2({this.title});
//   @override
//   _SearchResultsPage2State createState() => _SearchResultsPage2State();
// }
//
// const String searchIcon = "assets/icons/search.svg";
//
// class _SearchResultsPage2State extends State<SearchResultsPage2> {
//   List<SearchModel> results = [];
//   String stock1 = '',
//       stock2 = '',
//       mutual1 = '',
//       mutual2 = '',
//       crypto1 = '',
//       crypto2 = '',
//       commo1 = '',
//       commo2 = '',
//       indices1 = '',
//       indices2 = '',
//       currency1 = '',
//       currency2 = '';
//   bool _loading = true;
//   void getresults() async {
//     results =
//         await SearchServices.getSearchListFromQuery(widget.title.toString())
//             .whenComplete(() {
//       setState(() {});
//     });
//
//     setState(() {
//       if (results[0].stockSearchIndex.isNotEmpty) {
//         if (results[0].stockSearchIndex.length == 1)
//           stock1 = results[0].stockSearchIndex[0].stockName;
//         else {
//           stock1 = results[0].stockSearchIndex[0].stockName;
//           stock2 = results[0].stockSearchIndex[1].stockName;
//         }
//       }
//       if (results[1].mutualSearchIndex.isNotEmpty) {
//         if (results[1].mutualSearchIndex.length == 1)
//           mutual1 = results[1].mutualSearchIndex[0].fundName;
//         else {
//           mutual1 = results[1].mutualSearchIndex[0].fundName;
//           mutual2 = results[1].mutualSearchIndex[1].fundName;
//         }
//       }
//       if (results[2].cryptoSearchIndex.isNotEmpty) {
//         if (results[2].cryptoSearchIndex.length == 1)
//           crypto1 = results[2].cryptoSearchIndex[0].fullName;
//         else {
//           crypto1 = results[2].cryptoSearchIndex[0].fullName;
//           crypto2 = results[2].cryptoSearchIndex[1].fullName;
//         }
//       }
//       if (results[3].commoditySearchIndex.isNotEmpty) {
//         if (results[3].commoditySearchIndex.length == 1)
//           commo1 = results[3].commoditySearchIndex[0].commodityName;
//         else {
//           commo1 = results[3].commoditySearchIndex[0].commodityName;
//           commo2 = results[3].commoditySearchIndex[1].commodityName;
//         }
//       }
//       if (results[4].indicesSearchIndex.isNotEmpty) {
//         if (results[4].indicesSearchIndex.length == 1)
//           indices1 = results[4].indicesSearchIndex[0].indiceName;
//         else {
//           indices1 = results[4].indicesSearchIndex[0].indiceName;
//           indices2 = results[4].indicesSearchIndex[1].indiceName;
//         }
//       }
//       if (results[5].currencySearchIndex.isNotEmpty) {
//         if (results[5].currencySearchIndex.length == 1)
//           currency1 = results[5].currencySearchIndex[0].currencyName;
//         else {
//           currency1 = results[5].currencySearchIndex[0].currencyName;
//           currency2 = results[5].currencySearchIndex[1].currencyName;
//         }
//       }
//       _loading = false;
//     });
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     getresults();
//     // _getres(widget.title);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBarWithBack(
//           text: "Search results for ${widget.title}",
//         ),
//         body: _loading
//             ? Center(child: CircularProgressIndicator(color: Colors.white))
//             : SingleChildScrollView(
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                   child: Column(
//                     children: [
//                       stock1 != ''
//                           ? _listItem(searchIcon, stock1, 'STOCK')
//                           : SizedBox.shrink(),
//                       stock2 != ''
//                           ? _listItem(searchIcon, stock2, 'STOCK')
//                           : SizedBox.shrink(),
//                       mutual1 != ''
//                           ? _listItem(searchIcon, mutual1, 'MF')
//                           : SizedBox.shrink(),
//                       mutual2 != ''
//                           ? _listItem(searchIcon, mutual2, 'MF')
//                           : SizedBox.shrink(),
//                       crypto1 != ''
//                           ? _listItem(searchIcon, crypto1, 'CRYPTO')
//                           : SizedBox.shrink(),
//                       crypto2 != ''
//                           ? _listItem(searchIcon, crypto2, 'CRYPTO')
//                           : SizedBox.shrink(),
//                       commo1 != ''
//                           ? _listItem(searchIcon, commo1, 'COMMO')
//                           : SizedBox.shrink(),
//                       commo2 != ''
//                           ? _listItem(searchIcon, commo2, 'COMMO')
//                           : SizedBox.shrink(),
//                       indices1 != ''
//                           ? _listItem(searchIcon, indices1, 'INDICE')
//                           : SizedBox.shrink(),
//                       indices2 != ''
//                           ? _listItem(searchIcon, indices2, 'INDICE')
//                           : SizedBox.shrink(),
//                       currency1 != ''
//                           ? _listItem(searchIcon, currency1, 'CUR')
//                           : SizedBox.shrink(),
//                       currency2 != ''
//                           ? _listItem(searchIcon, currency2, 'CUR')
//                           : SizedBox.shrink(),
//                     ],
//                   ),
//                 ),
//               ),
//       ),
//     );
//   }
//
//   _listItem(String assetName, String title, String type) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 12),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Row(children: [
//             SvgPicture.asset(
//               assetName,
//             ),
//             SizedBox(
//               width: 12,
//             ),
//             Container(
//               width: MediaQuery.of(context).size.width / 1.5,
//               child: Text(
//                 capitalize(title),
//                 style: bodyText2White,
//                 overflow: TextOverflow.visible,
//               ),
//             )
//           ]),
//           Container(
//             decoration: BoxDecoration(
//               border: Border.all(color: blue),
//               borderRadius: BorderRadius.circular(2),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(4.0),
//               child: Text(
//                 type,
//                 style: TextStyle(color: blue, fontSize: 12),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   String capitalize(String string) {
//     if (string.isEmpty) {
//       return string;
//     }
//     return string[0].toUpperCase() + string.substring(1);
//   }
// }
