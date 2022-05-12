import 'package:flutter/material.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:technical_ind/components/LoadingPage.dart';
import 'package:technical_ind/components/noDataAvailable.dart';
import 'package:technical_ind/screens/indices/business/indices_services.dart';
import 'package:technical_ind/widgets/customSlider.dart';

import '../../../styles.dart';
import '../../../widgets/miss.dart';
import '../business/global_overview_model.dart';

class GlobalOverview extends StatefulWidget {
  // final Overview overview;
  final String query, price, chng, chngPercentage;
  GlobalOverview({Key key, this.query, this.price, this.chng, this.chngPercentage}) : super(key: key);

  @override
  _GlobalOverviewState createState() => _GlobalOverviewState();
}

class _GlobalOverviewState extends State<GlobalOverview> {
  Overview overview;
  bool loading = true;
  List<Widget> list;
  fetchApi() async {
    overview = await IndicesServices.getGolbalIndicesOverview(widget.query);
    list = [
      CoupleText(title: overview.open, value: "Open"),
      CoupleText(title: overview.prevClose, value: "Previous Close"),
      CoupleText(title: overview.volume, value: "Volume"),
      CoupleText(title: overview.averageVol3M, value: "Average Vol (3M)"),
      CoupleText(title: overview.daySRange, value: "Day's Range"),
      CoupleText(title: overview.the52WkRange, value: "52 Week Range"),
    ];
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
                  child: CustomScrollView(
                    slivers: [
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            SizedBox(height: 48),
                            Center(
                                child: Text(
                                  // overview.price,
                                  widget.price, 
                                    style: headline5White)),
                            Center(
                              child: Text(
                                // overview.priceChange +
                                //     ' (' +
                                //     overview.priceChangePercentage +
                                //     ')',
                                widget.chng,
                                style: bodyText2.copyWith(
                                  color: 
                                  // overview.priceChange[0] == '+'
                                  //     ? blue
                                  //     : red,
                                  widget.chng.contains("-")?red: blue
                                ),
                              ),
                            ),
                            SizedBox(height: 42),
                            CustomSlider(
                              title: "Day Range",
                              minValue: overview?.daySRange?.substring(
                                      0, overview?.daySRange?.indexOf('-')) ??
                                  "",
                              maxValue: overview?.daySRange?.substring(
                                  overview.daySRange.indexOf('-') + 1),
                              value: ((double.parse(overview?.price
                                          ?.replaceAll(',', '')) -
                                      double.parse(overview?.daySRange
                                          ?.substring(
                                            0,
                                            overview?.daySRange?.indexOf('-'),
                                          )
                                          ?.replaceAll(',', ''))) /
                                  (double.parse(overview?.daySRange
                                          ?.substring(
                                              overview.daySRange.indexOf('-') +
                                                  1)
                                          ?.replaceAll(',', '')) -
                                      double.parse(overview?.daySRange
                                          ?.substring(
                                            0,
                                            overview?.daySRange?.indexOf('-'),
                                          )
                                          ?.replaceAll(',', '')))),
                            ),
                            SizedBox(height: 32),
                            CustomSlider(
                              title: "52 Week Range",
                              minValue: overview?.the52WkRange?.substring(
                                  0, overview?.the52WkRange?.indexOf('-')),
                              maxValue: overview?.the52WkRange?.substring(
                                  overview.the52WkRange.indexOf('-') + 1),
                              value: ((double.parse(overview?.price
                                          ?.replaceAll(',', '')) -
                                      double.parse(overview?.the52WkRange
                                          ?.substring(
                                            0,
                                            overview?.the52WkRange
                                                ?.indexOf('-'),
                                          )
                                          ?.replaceAll(',', ''))) /
                                  (double.parse(overview?.the52WkRange
                                          ?.substring(overview.the52WkRange
                                                  .indexOf('-') +
                                              1)
                                          ?.replaceAll(',', '')) -
                                      double.parse(overview?.the52WkRange
                                          ?.substring(
                                            0,
                                            overview.the52WkRange.indexOf('-'),
                                          )
                                          ?.replaceAll(',', '')))),
                            ),
                            SizedBox(height: 54),
                          ],
                        ),
                      ),
                      // SliverGrid(
                      //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      //       crossAxisCount: 1, childAspectRatio: 4),
                      //   delegate: SliverChildListDelegate(list),
                      // ),
                      SliverList(
                        delegate: SliverChildListDelegate(list),
                      )
                    ],
                  ),
                ),
              )
            : NoDataAvailablePage();
  }
}
