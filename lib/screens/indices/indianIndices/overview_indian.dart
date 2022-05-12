import 'package:flutter/material.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:technical_ind/components/LoadingPage.dart';
import 'package:technical_ind/components/noDataAvailable.dart';
import 'package:technical_ind/components/slidePanel.dart';
import 'package:technical_ind/screens/indices/business/indices_services.dart';

import '../../../styles.dart';
import '../../../widgets/customSlider.dart';
import '../business/indian_overview_model.dart';

class OverviewIndianIndices extends StatefulWidget {
  // final Overview overview;
  final String query, price, chng;
  OverviewIndianIndices({this.query, this.price, this.chng});
  @override
  _OverviewIndianIndicesState createState() => _OverviewIndianIndicesState();
}

class _OverviewIndianIndicesState extends State<OverviewIndianIndices> {
  Overview arr;
  bool loading = true;
  int idx52, idxdays;
  List<String> itemdays = [
    "1 Week",
    "1 Month",
    "3 Months",
    "6 Months",
    "1 Year",
    "3 Years",
    "5 Years"
  ];
  Overview overview;
  List<String> values = [];
  int _selected = 0;
  fetchApi() async {
    overview = await IndicesServices.getIndianIndicesOverview(widget.query);
    arr = overview;
    idx52 = overview.the52WeekRange.indexOf('-');
    idxdays = overview.daysRange.indexOf('-');
    values.add(overview.returns.the1Week);
    values.add(overview.returns.the1Month);
    values.add(overview.returns.the3Month);
    values.add(overview.returns.the6Month);
    values.add(overview.returns.the1Year);
    values.add(overview.returns.the3Year);
    values.add(overview.returns.the5Year);
    setState(() {
      loading = false;
    });
    _refreshController.refreshCompleted();
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  void initState() {
    super.initState();
    fetchApi();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    _refreshController.dispose();
    super.dispose();
  }

  PanelController _panelController = PanelController();

  @override
  Widget build(BuildContext context) {
    return loading
        ? LoadingPage()
        : overview != null
            ? SlidePanel(
                defaultHeight: itemdays.length.toDouble() * 9,
                menu: itemdays,
                defaultWidget: itemdays[_selected],
                panelController: _panelController,
                onChange: (val) {
                  setState(() {
                    _selected = val;
                  });
                },
                child: Scaffold(
                  body: SmartRefresher(
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
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: 32),
                            Center(
                                child: Text(
                                    // arr?.price ?? "",
                                    widget.price,
                                    style: headline5White)),
                            SizedBox(height: 2),
                            Center(
                              child: Text(
                                // !arr.chgChgPercent.contains('-')
                                //     ? '+' +
                                //             arr.chgChgPercent.split('(')[0] +
                                //             '(+' +
                                //             arr.chgChgPercent.split('(')[1] ??
                                //         ""
                                //     : arr?.chgChgPercent ?? "",
                                widget.chng,
                                style: bodyText2.copyWith(
                                    color:
                                        // arr?.chgChgPercent[0] != '-'
                                        widget.chng.contains('-') ? red : blue),
                              ),
                            ),
                            SizedBox(height: 32),
                            CustomSlider(
                              title: "Day Range",
                              minValue:
                                  arr?.daysRange?.substring(0, idxdays) ?? "",
                              maxValue:
                                  arr?.daysRange?.substring(idxdays + 1) ?? "",
                              value: ((double.parse(
                                          arr?.price?.replaceAll(',', '')) -
                                      double.parse(arr?.daysRange
                                          ?.substring(
                                            0,
                                            arr?.daysRange?.indexOf('-'),
                                          )
                                          ?.replaceAll(',', ''))) /
                                  (double.parse(arr?.daysRange
                                          ?.substring(
                                              arr.daysRange.indexOf('-') + 1)
                                          ?.replaceAll(',', '')) -
                                      double.parse(arr?.daysRange
                                          ?.substring(
                                            0,
                                            arr.daysRange.indexOf('-'),
                                          )
                                          ?.replaceAll(',', '')))),
                            ),
                            SizedBox(height: 32),
                            CustomSlider(
                                title: "52 Week Range",
                                minValue:
                                    arr?.the52WeekRange?.substring(0, idx52) ??
                                        "",
                                maxValue:
                                    arr?.the52WeekRange?.substring(idx52 + 1) ??
                                        "",
                                value: ((double.parse(
                                            arr?.price?.replaceAll(',', '')) -
                                        double.parse(arr?.the52WeekRange
                                            ?.substring(
                                              0,
                                              arr?.the52WeekRange?.indexOf('-'),
                                            )
                                            ?.replaceAll(',', ''))) /
                                    (double.parse(arr?.the52WeekRange
                                            ?.substring(arr.the52WeekRange
                                                    .indexOf('-') +
                                                1)
                                            ?.replaceAll(',', '')) -
                                        double.parse(arr?.the52WeekRange
                                            ?.substring(
                                              0,
                                              arr?.the52WeekRange?.indexOf('-'),
                                            )
                                            ?.replaceAll(',', ''))))),
                            SizedBox(height: 54),
                            Center(
                                child: Text("Returns", style: subtitle1White)),
                            SizedBox(height: 26),
                            buildInkWell(),
                            SizedBox(height: 12),
                            Text(
                              values[_selected][0] == '-'
                                  ? values[_selected]
                                  : '+' + values[_selected],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: values[_selected][0] == '-' ? red : blue,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 28),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      rowItem(arr?.open ?? "", 'Open'),
                                      SizedBox(),
                                      rowItem(arr?.previousClose ?? "",
                                          'Previous Close')
                                    ],
                                  ),
                                  SizedBox(height: 22),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      rowItem(arr?.dayHigh ?? "", 'Day High'),
                                      SizedBox(),
                                      rowItem(arr?.dayLow ?? "", 'Day Low')
                                    ],
                                  ),
                                  SizedBox(height: 22),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      rowItem(arr?.the52WeekHigh ?? "",
                                          '52 Week High'),
                                      SizedBox(),
                                      rowItem(arr?.the52WeekLow ?? "",
                                          '52 Week Low')
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 120),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : NoDataAvailablePage();
  }

  Widget rowItem(String head, String text) {
    return Column(
      children: [
        Text(head, style: subtitle1White),
        SizedBox(height: 2),
        Text(text, style: captionWhite60)
      ],
      crossAxisAlignment: CrossAxisAlignment.center,
    );
  }

  InkWell buildInkWell() {
    return InkWell(
      onTap: () {
        _panelController.open();
      },
      child: Container(
        //width: 150.w,
        padding: EdgeInsets.symmetric(vertical: 9, horizontal: 12),
        decoration: BoxDecoration(
            color: darkGrey, borderRadius: BorderRadius.circular(6)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(itemdays[_selected], style: button.copyWith(color: white60)),
            Icon(
              Icons.keyboard_arrow_down_outlined,
              color: white60,
            )
          ],
        ),
      ),
    );
  }
}
