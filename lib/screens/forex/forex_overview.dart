// import 'package:flutter/material.dart';

// import '../../styles.dart';

// class ForexOverview extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//         padding: EdgeInsets.symmetric(horizontal: 16),
//         child: Column(
//           children: [
//             SizedBox(height: 24),
//             Center(child: Text("11,686.59", style: headline5White)),
//             Center(
//                 child: Text("+6.59(+0.59%)",
//                     style: subtitle2.copyWith(color: blue))),
//             SizedBox(height: 102),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 rowItem('11,679.25', 'Previous Close'),
//                 rowItem('11,679.25', 'Open')
//               ],
//             ),
//             SizedBox(height: 22),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 rowItem('11,679.25', 'Bid'),
//                 rowItem('11,679.25', 'Ask')
//               ],
//             ),
//             SizedBox(height: 22),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 rowItem('0 - 1.1781', 'Day\'s Range'),
//                 rowItem('0 - 1.1781', '52 Week Range')
//               ],
//             ),
//           ],
//         ));
//   }

//   Widget rowItem(String head, String text) {
//     return Expanded(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(head, style: subtitle1White),
//           Text(text, style: captionWhite60)
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:technical_ind/components/LoadingPage.dart';
import 'package:technical_ind/components/noDataAvailable.dart';
import 'package:technical_ind/screens/forex/business/services.dart';
//import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:technical_ind/widgets/item.dart';

import '../../styles.dart';
import 'business/forexExplore.dart';

class ForexOverviewPage extends StatefulWidget {
  final String query, price, chng, chngPercentage;
  ForexOverviewPage(
      {Key key, this.query, this.price, this.chng, this.chngPercentage})
      : super(key: key);

  @override
  _ForexOverviewPageState createState() => _ForexOverviewPageState();
}

class _ForexOverviewPageState extends State<ForexOverviewPage> {
  List<String> _list = [
    "Previous Close",
    "Open",
    'Bid',
    'Ask',
    "Day's Range",
    "52 Week Range",
  ];
  Overview overview;
  bool loading = true;
  fetchApi() async {
    overview = await ForexServices.getForexOverview(widget.query);
    setState(() {
      loading = false;
    });
    _refreshController.refreshCompleted();
  }

  @override
  void initState() {
    fetchApi();
    super.initState();
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void dispose() {
    // TODO: implement dispose

    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? LoadingPage()
        : overview != null
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: false,
                  controller: _refreshController,
                  onRefresh: fetchApi,
                  header: ClassicHeader(
                    completeIcon: Icon(Icons.done, color: Colors.white60),
                    refreshingIcon: SizedBox(
                      width: 25,
                      height: 25,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.0,
                        color: Colors.white60,
                      ),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 32),
                        Center(
                            child: Text(
                                // overview.price,
                                widget.price,
                                style: headline5White)),
                        Center(
                            child: Text(
                                // "${overview.change} (${overview.changePercent})",
                                widget.chng + widget.chngPercentage,
                                style: subtitle2.copyWith(
                                    color:
                                        // double.parse(overview.change) > 0
                                        !widget.chng.contains("-")
                                            ? blue
                                            : red))),
                        SizedBox(
                          height: 22,
                        ),
                        Container(
                          height: 475,
                          child: ListView(
                            physics: NeverScrollableScrollPhysics(),
                            children: [
                              RowItem(_list[0], overview.previousClose ?? "",
                                  pad: 10),
                              RowItem(_list[1], overview.open ?? "", pad: 10),
                              RowItem(_list[2], overview.bid ?? "", pad: 10),
                              RowItem(_list[3], overview.ask ?? "", pad: 10),
                              RowItem(_list[4], overview.daysRange ?? "",
                                  pad: 10),
                              RowItem(_list[5], overview.the52WeekRange ?? "",
                                  pad: 10),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            : NoDataAvailablePage();
  }
}
