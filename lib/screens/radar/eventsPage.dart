import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:technical_ind/components/LoadingPage.dart';
import 'package:technical_ind/screens/radar/business/events.dart';
import 'package:technical_ind/screens/radar/business/radarServices.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:technical_ind/screens/stocks/explore/home.dart';
import '../../components/slidePanel.dart';
import '../../styles.dart';
import '../../widgets/appbar_with_back_and_search.dart';
import 'package:date_time_format/date_time_format.dart';

class EventsPage extends StatefulWidget {
  EventsPage({Key key}) : super(key: key);

  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  bool isLoading = true;
  List<String> menu = [
    "All",
    "Bonus/Split",
    "Dividend",
    "Board Meetings",
    "Results"
  ];
  int _selected = 0;
  PanelController _panelController = new PanelController();
  List<List<EventsModel>> events = [];
  List<List<EventsModel>> sortedEvents = [[], [], [], [], []];
  _fetchApi() async {
    events.add(await RadarServices.events("ALL"));
    events.add(await RadarServices.events("BONUS_SPLIT"));
    events.add(await RadarServices.events("DIVIDENDS"));
    events.add(await RadarServices.events("BOARD_MEETINGS"));
    events.add(await RadarServices.events("RESULTS"));
    // <=
    for (int i = 0; i < events.length; i++) {
      for (int j = 0; j < events[i].length; j++) {
        if (DateTime.now().month.compareTo(events[i][j].date.month) <= 0 &&
            DateTime.now().day.compareTo(events[i][j].date.day) <= 0) {
          sortedEvents[i].add(events[i][j]);
        }
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchApi();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? LoadingPage()
        : sortedEvents.isNotEmpty && sortedEvents.length == 5
            ? SlidePanel(
                menu: menu,
                defaultWidget: menu[_selected],
                panelController: _panelController,
                onChange: (val) {
                  setState(() {
                    _selected = val;
                  });
                },
                child: Scaffold(
                    appBar: PreferredSize(
                      preferredSize: Size.fromHeight(106),
                      child: Column(
                        children: [
                          AppBarWithBack(
                            text: "Events",
                          ),
                          InkWell(
                            onTap: () {
                              _panelController.open();
                            },
                            child: Hero(
                              tag: "explore",
                              child: Material(
                                color: Colors.transparent,
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 2),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 18, vertical: 11),
                                  //height: 40.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: Color(0xff1c1c1e),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(menu[_selected],
                                          style: subtitle2White),
                                      Icon(
                                        Icons.expand_more,
                                        color: almostWhite,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    body: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: GroupedListView<EventsModel, DateTime>(
                          elements: sortedEvents[_selected],
                          groupBy: (e) => e.date,
                          groupSeparatorBuilder: (d) =>
                              buildText(d.format("d F Y")),
                          itemBuilder: (context, element) => buildContainer(
                              element.stock, element.type, element.tredlineId),
                          itemComparator: (a, b) => a.date.compareTo(b.date),
                          // useStickyGroupSeparators: true, // optional
                          stickyHeaderBackgroundColor: Colors.black,

                          order: GroupedListOrder.ASC, // optional
                        )

                        // ListView(
                        //   children: [
                        //     buildText("09 February 2021"),
                        //     buildContainer('Panasonic Energy India Company Ltd.',
                        //         'Quarterly Results & Interim Dividend'),
                        //     buildContainer('Panasonic Energy India Company Ltd.',
                        //         'Quarterly Results & Interim Dividend'),
                        //     buildText("10 February 2021"),
                        //     buildContainer('Panasonic Energy India Company Ltd.',
                        //         'Quarterly Results & Interim Dividend'),
                        //     buildContainer('Panasonic Energy India Company Ltd.',
                        //         'Quarterly Results & Interim Dividend'),
                        //     buildContainer('Panasonic Energy India Company Ltd.',
                        //         'Quarterly Results & Interim Dividend'),
                        //     buildText("11 February 2021"),
                        //     buildContainer('Panasonic Energy India Company Ltd.',
                        //         'Quarterly Results & Interim Dividend'),
                        //     buildContainer('Panasonic Energy India Company Ltd.',
                        //         'Quarterly Results & Interim Dividend'),
                        //     buildContainer('Panasonic Energy India Company Ltd.',
                        //         'Quarterly Results & Interim Dividend'),
                        //   ],
                        // ),
                        )),
              )
            : LoadingPage();
  }

  Widget buildContainer(String title, String desc, String code) {
    return InkWell(
      onTap: () {
        pushNewScreen(
          context,
          withNavBar: false,
          screen: Homepage(
            name: title,
            stockCode: code,
            isEvents: true,
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        margin: EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: darkGrey,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(title ?? "", style: subtitle2White),
            Text(desc ?? "", style: captionWhite60)
          ],
        ),
      ),
    );
  }

  Widget buildText(String t) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Text(t, style: subtitle2White),
    );
  }
}
