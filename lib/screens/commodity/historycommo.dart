import 'package:flutter/material.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:technical_ind/components/LoadingPage.dart';
import 'package:technical_ind/components/noDataAvailable.dart';
import 'package:technical_ind/screens/indices/business/indices_services.dart';
import 'package:technical_ind/widgets/miss.dart';
import 'business/commodity_overview_model.dart';
import '../../styles.dart';
import '../../widgets/datagrid.dart';

class HistoryPageCommodity extends StatefulWidget {
  // final HistoricalData historicalData;
  final String query;
  bool isGlobalIndices;
  bool isIndianIndices;
  HistoryPageCommodity(
      {Key key,
      this.query,
      this.isGlobalIndices = false,
      this.isIndianIndices = false})
      : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPageCommodity> {
  HistoricalData arr;
  ScrollController horizontalScrollcontroller1 = ScrollController();
  ScrollController horizontalScrollcontroller2 = ScrollController();
  ScrollController horizontalScrollcontroller3 = ScrollController();
  HistoricalData historicalData;
  bool loading = true;
  fetchApi() async {
    if (widget.isGlobalIndices) {
      historicalData =
          await IndicesServices.getGolbalIndicesHistoricalData(widget.query);
    }
    if (widget.isIndianIndices) {
      historicalData =
          await IndicesServices.getIndianIndicesHistoricalData(widget.query);
    }
    arr = historicalData;

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
        : historicalData != null
            ? DefaultTabController(
                length: 3,
                child: Scaffold(
                  appBar: TabBar(
                    labelStyle: buttonWhite,
                    unselectedLabelColor: Colors.white38,
                    //indicatorSize: TabBarIndicatorSize.label,
                    indicator: MaterialIndicator(
                      horizontalPadding: 24,
                      bottomLeftRadius: 8,
                      bottomRightRadius: 8,
                      color: almostWhite,
                      paintingStyle: PaintingStyle.fill,
                    ),
                    tabs: [
                      Tab(
                        text: "Daily",
                      ),
                      Tab(
                        text: "Weekly",
                        //child: NSEtab(),
                      ),
                      Tab(
                        text: "Monthly",
                        //child: NSEtab(),
                      ),
                    ],
                  ),
                  body: TabBarView(
                    children: [
                      _historyBuilder2(arr?.daily),
                      _historyBuilder2(
                        arr?.weekly,
                      ),
                      _historyBuilder2(arr?.monthly),
                    ],
                  ),
                ),
              )
            : NoDataAvailablePage();
  }

  Padding _historyBuilder(List<Daily> list, ScrollController scrollController) {
    return Padding(
      padding: const EdgeInsets.only(right: 16, left: 16, top: 24),
      child: CustomTable(
        horizontalScrollController: scrollController,
        headersTitle: ["DATE", "PRICE", "OPEN", "HIGH", "LOW", "VOL", "CHG %"],
        fixedColumnWidth: 112,
        columnwidth: 150,
        totalColumns: 7,
        itemCount: list.length,
        leftSideItemBuilder: (c, i) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(list[i].date,
                textAlign: TextAlign.left, style: subtitle2White),
          );
        },
        rightSideItemBuilder: (c, i) => DataTableItem(
          data: [
            list[i]?.price ?? "",
            list[i]?.open ?? "",
            list[i]?.high ?? "",
            list[i]?.low ?? "",
            list[i]?.volume ?? "",
            // list[i].adjClose,
            list[i]?.chgPercent ?? "",
          ],
          color: list[i]?.chgPercent[0] == '-' ? red : blue,
        ),
      ),
    );
  }

  _historyBuilder2(List<Daily> list) {
    return ListView.builder(
      itemBuilder: (context, i) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          child: Column(
            children: [
              TableBarv2(
                title1: list[i]?.date ?? '-',
                title2: '',
                color: Colors.white,
              ),
              SizedBox(height: 12),
              TableItemv2(
                title: 'PRICE',
                value: list[i]?.price ?? '-',
              ),
              TableItemv2(
                title: 'OPEN',
                value: list[i]?.open ?? '-',
              ),
              TableItemv2(
                title: 'HIGH',
                value: list[i]?.high ?? '-',
              ),
              TableItemv2(
                title: 'LOW',
                value: list[i]?.low ?? '-',
              ),
              TableItemv2(
                title: 'VOL',
                value: list[i]?.volume ?? '-',
              ),
              TableItemv2(
                title: 'CHG %',
                value: list[i]?.chgPercent[0] == '-'
                    ? list[i]?.chgPercent
                    : '+' + list[i]?.chgPercent ?? '-',
                valueColor: list[i]?.chgPercent[0] == '-' ? red : blue,
              ),
              // SizedBox(height: 26),
            ],
          ),
        );
      },
      itemCount: list?.length ?? 0,
    );
  }
}
