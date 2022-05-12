// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
// import '../../styles.dart';
// import 'searchResultsPageTrial_unused.dart';
//
// class SearchPageTrial extends StatefulWidget {
//   SearchPageTrial({Key key}) : super(key: key);
//
//   @override
//   _SearchPageState createState() => _SearchPageState();
// }
//
// class _SearchPageState extends State<SearchPageTrial> {
//   final String searchIcon = "assets/icons/search.svg";
//   // var results = [
//   //   'Igor Minar',
//   //   'Brad Green',
//   //   'Dave Geddes',
//   //   'Naomi Black',
//   //   'Greg Weber',
//   //   'Dean Sofer',
//   //   'Wes Alvaro',
//   //   'John Scott',
//   //   'Daniel Nadasi',
//   // ];
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: PreferredSize(
//           child: Container(
//             height: 58,
//             color: grey,
//             child: Container(
//               margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               // height: 40,
//               child: CupertinoTextField(
//                 clearButtonMode: OverlayVisibilityMode.editing,
//                 decoration: BoxDecoration(
//                   color: Colors.black,
//                   borderRadius: BorderRadius.circular(6),
//                 ),
//                 padding: EdgeInsets.symmetric(horizontal: 10, vertical: 9),
//                 prefix: Padding(
//                   padding: const EdgeInsets.only(left: 18),
//                   child: ImageIcon(
//                     AssetImage("assets/nav/search.png"),
//                     color: white60,
//                   ),
//                 ),
//                 onSubmitted: (val) {
//                   pushNewScreen(
//                     context,
//                     screen: SearchResultsPage2(
//                       title: val,
//                     ),
//                   );
//                 },
//                 // onChanged: (val) {},
//                 style: subtitle2White,
//               ),
//             ),
//           ),
//           preferredSize: Size.fromHeight(58),
//         ),
//         // body:
//       ),
//     );
//   }
// }
