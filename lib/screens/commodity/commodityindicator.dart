import 'package:bubble/bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
//import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:technical_ind/widgets/chart.dart';
import 'package:technical_ind/widgets/item.dart';
import 'package:technical_ind/widgets/miss.dart';
import 'package:technical_ind/widgets/roundedButtons.dart';
import 'package:technical_ind/widgets/tableItem.dart';
import 'business/commodity_overview_model.dart';
import '../../components/slidePanel.dart';
import '../../styles.dart';
import '../../widgets/bulletText.dart';

class CustomDropDown extends StatelessWidget {
  final List<String> list;

  const CustomDropDown({
    Key key,
    this.list,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: darkGrey, borderRadius: BorderRadius.circular(8)),
      child: DropdownButtonFormField(
        decoration: InputDecoration.collapsed(hintText: ""),
        elevation: 8,
        //isDense: false,
        dropdownColor: darkGrey,
        iconSize: 18,
        icon: Icon(CupertinoIcons.chevron_down),
        hint: Text(
          list[0],
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 12,
            color: almostWhite,
          ),
        ),
        items: List.generate(
          list.length,
          (index) => DropdownMenuItem(
            value: list[index],
            child: new Text(
              list[index],
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: almostWhite,
              ),
            ),
          ),
        ),
        onChanged: (value) {},
      ),
    );
  }
}

class IndicatorPageCommodity extends StatefulWidget {
  final bool stocks;
  final CommodityOverviewModelTechnicalIndicator indicator;
  IndicatorPageCommodity({Key key, this.stocks = false, this.indicator})
      : super(key: key);

  @override
  _IndicatorPageState createState() => _IndicatorPageState();
}

class Ref {
  final Color color;
  final String text;

  const Ref(this.color, this.text);

  Color getColor() => color;

  String getText() => text;
}

class _IndicatorPageState extends State<IndicatorPageCommodity> {
  // TextStyle _headStyle = TextStyle(
  //   fontSize: 12,
  //   color: darkGrey.withOpacity(0.60),
  // );
  //
  CommodityOverviewModelTechnicalIndicator indicator;
  List<String> menu1 = ["Exponential", "Simple"];
  List<String> menu = [];
  String defaultWidget = "";
  List<String> menu2 = [
    "Classic",
    "Fibonacci",
    "Camarilla",
    "Woodie's",
    "DeMark's"
  ];
  int _s1 = 0;
  int _s2 = 0;
  bool isTopDropDown = true;
  PanelController _panelController = PanelController();
  String _selected = "1 HR";
  int _index = 0;
  List<Ref> refList = [
    Ref(blue, "Strong Buy"),
    Ref(blue.withOpacity(0.6), "Buy"),
    Ref(yellow, "Neutral"),
    Ref(red.withOpacity(0.6), "Sell"),
    Ref(red, "Strong Sell"),
  ];
  List<String> buttonList = [
    "1 MIN",
    "5 MIN",
    "15 MIN",
    "30 MIN",
    "1 HR",
    "5 HR",
    "1 DAY",
    "1 WK",
    "1 MON"
  ];
  // List<String> inds = [
  //   "RSI(14)",
  //   'STOCH(9,6)',
  //   'STOCHRSI(14)',
  //   'MACD(12,26)',
  //   'ADX(14)',
  //   'Williams %R',
  //   'CCI(14)',
  //   'ATR(14)',
  //   'Highs/Lows(14)',
  //   'Ultimate\nOscillator',
  //   'ROC',
  //   'Bull/Bear\nPower(13)'
  // ];
  List<String> pPoints = ['S3', 'S2', 'S1', 'PIVOT POINTS', 'R1', 'R2', 'R3'];
  The15Min selectedTimeObject;
  @override
  void initState() {
    super.initState();
    menu = menu1;
    defaultWidget = menu1[_s1];
    selectedTimeObject =
        getTimeObject(buttonList.indexOf(_selected), widget.indicator);
  }

  The15Min getTimeObject(
      int index, CommodityOverviewModelTechnicalIndicator i) {
    switch (index) {
      case 0:
        return i.the1Min;
      case 1:
        return i.the5Min;
      case 2:
        return i.the15Min;
      case 3:
        return i.the30Min;
      case 4:
        return i.the1Hour;
      case 5:
        return i.the5Hour;
      case 6:
        return i.daily;
      case 7:
        return i.weekly;
      case 8:
        return i.monthly;
      default:
        return i.the5Min;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SlidePanel(
      menu: menu,
      defaultWidget: defaultWidget,
      panelController: _panelController,
      onChange: (val) {
        setState(() {
          isTopDropDown ? _s1 = val : _s2 = val;
        });
      },
      child: Scaffold(
        //backgroundColor: kindaWhite,
        body: SingleChildScrollView(
          child: Container(
            //color: blue,
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                widget.stocks
                    ? Column(children: [
                        SizedBox(height: 38),
                        new Text("Analysis", style: subtitle1White),
                        SizedBox(height: 20),
                        BulletText(
                            "Share has hit Six Months high on 12 Nov 2020"),
                        BulletText(
                            "Stock has jumped by more than 15% in last one month from its lowest level of 5511.05 on 30 Oct 2020"),
                        BulletText(
                            "Share has hit Six Months high on 12 Nov 2020"),
                        BulletText(
                            "Stock has jumped by more than 15% in last one month from its lowest level of 5511.05 on 30 Oct 2020"),
                      ])
                    : Container(),
                SizedBox(height: 30),
                Center(
                  child: new Text("Summary",
                      textAlign: TextAlign.center, style: subtitle1White),
                ),
                //SizedBox(height: 30),
                Container(
                  height: 390,
                  //width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(left: 32),
                  child: Row(
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SummaryChart(
                        index: _index,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Container(
                          child: Stack(
                            children: [
                              AnimatedPositioned(
                                curve: Curves.easeIn,
                                duration: Duration(milliseconds: 500),
                                left: 0,
                                top: 300 / 5 * _index + 50,
                                child: Bubble(
                                  color: refList[_index].getColor(),
                                  nip: BubbleNip.leftBottom,
                                  nipHeight: 10,
                                  nipWidth: 10,
                                  child: Text(
                                    refList[_index].getText().toUpperCase(),
                                    style:
                                        subtitle2.copyWith(color: Colors.black),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: List.generate(
                          buttonList.length,
                          (index) => RoundedButton(
                            value: buttonList[index],
                            groupValue: _selected,
                            onpress: () {
                              setState(() {
                                _selected = buttonList[index];

                                var i = buttonList.indexOf(_selected);

                                selectedTimeObject =
                                    getTimeObject(i, widget.indicator);
                                _index = refList.indexWhere((element) =>
                                    element.text.toLowerCase() ==
                                    selectedTimeObject.summary.summaryText
                                        .toLowerCase());
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 14,
                ),
                new Text("Moving Averages",
                    textAlign: TextAlign.center, style: subtitle1White),
                SizedBox(height: 30),
                FlatButton(
                  color: determineColor(selectedTimeObject.movingAverages.text),
                  onPressed: () {},
                  minWidth: 48,
                  height: 28,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                  child: Text(selectedTimeObject.movingAverages.text,
                      style: buttonWhite),
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    buildColumnText(
                        selectedTimeObject.movingAverages.buy, "Buy"),
                    buildColumnText("-", "Neutral"),
                    buildColumnText(
                        selectedTimeObject.movingAverages.sell, "Sell")
                  ],
                ),
                SizedBox(height: 16),
                buildInkWell(true),
                // CustomDropDown(list:["EXPONENTIAL"]),
                SizedBox(
                  height: 16,
                ),
                TableBar(
                  title1: "TITLE",
                  title2: "VALUE",
                  title3: "TYPE",
                ),
                SizedBox(height: 2),
                Column(
                    children: List.generate(
                  _s1 == 0
                      ? selectedTimeObject
                          .movingAverages.tableData.exponential.length
                      : selectedTimeObject
                          .movingAverages.tableData.simple.length,
                  (index) {
                    var data = _s1 == 0
                        ? selectedTimeObject
                            .movingAverages.tableData.exponential
                        : selectedTimeObject.movingAverages.tableData.simple;
                    return TableItem(
                      title: data[index].title,
                      value: data[index].value,
                      remarks: data[index].type,
                      remarksColor: determineColor(data[index].type),
                    );
                  },
                )),
                SizedBox(
                  height: 48,
                ),
                new Text("Oscillators",
                    textAlign: TextAlign.center, style: subtitle1White),
                SizedBox(height: 30),
                FlatButton(
                  color: determineColor(
                      selectedTimeObject.technicalIndicator.text),
                  onPressed: () {},
                  minWidth: 48,
                  height: 28,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                  child: Text(selectedTimeObject.technicalIndicator.text,
                      style: buttonWhite),
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    buildColumnText(
                        selectedTimeObject.technicalIndicator.buy, "Buy"),
                    buildColumnText(
                        selectedTimeObject.technicalIndicator.neutral,
                        "Neutral"),
                    buildColumnText(
                        selectedTimeObject.technicalIndicator.sell, "Sell")
                  ],
                ),
                SizedBox(
                  height: 24,
                ),
                TableBar(
                  title1: "NAME",
                  title2: "ACTION",
                  title3: "VALUE",
                ),
                SizedBox(height: 2),
                Column(
                    children: List.generate(
                  selectedTimeObject.technicalIndicator.tableData.length,
                  (index) {
                    var data = selectedTimeObject.technicalIndicator.tableData;
                    return TableItem(
                      title: data[index].name,
                      value: data[index].value,
                      remarks: data[index].action,
                      remarksColor: determineColor(data[index].action),
                    );
                  },
                )),
                SizedBox(
                  height: 46,
                ),
                new Text("Pivot Points",
                    textAlign: TextAlign.center, style: subtitle1White),
                SizedBox(height: 30),
                buildInkWell(false),
                // CustomDropDown(list: ["Classic"],),
                SizedBox(
                  height: 22,
                ),

                Builder(builder: (context) {
                  var d = _s2 == 0
                      ? selectedTimeObject.pivotPoints.classic
                      : _s2 == 1
                          ? selectedTimeObject.pivotPoints.fibonacci
                          : _s2 == 2
                              ? selectedTimeObject.pivotPoints.camarilla
                              : _s2 == 3
                                  ? selectedTimeObject.pivotPoints.woodie
                                  : selectedTimeObject.pivotPoints.demark;
                  return Column(
                    children: [
                      RowItem(pPoints[0], d.s3),
                      RowItem(pPoints[1], d.s2),
                      RowItem(pPoints[2], d.s1),
                      RowItem(pPoints[3], d.pivotPoints),
                      RowItem(pPoints[4], d.r1),
                      RowItem(pPoints[5], d.r2),
                      RowItem(pPoints[6], d.r3)
                    ],
                  );
                }),
                SizedBox(
                  height: 150,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column buildColumnText(String val, String subtitle) {
    return Column(
      children: [
        Text(val,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18,
              color: almostWhite,
            )),
        Text(subtitle, style: captionWhite60)
      ],
    );
  }

  InkWell buildInkWell(bool istop) {
    return InkWell(
      onTap: () {
        setState(() {
          isTopDropDown = istop;
          istop ? menu = menu1 : menu = menu2;
          istop ? defaultWidget = menu1[_s1] : defaultWidget = menu2[_s2];
        });

        _panelController.open();
      },
      child: Container(
          //width: 150.w,
          // margin: EdgeInsets.symmetric(vertical: 8),
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
              color: darkGrey, borderRadius: BorderRadius.circular(8)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                  istop
                      ? menu1[_s1].toUpperCase()
                      : menu2[_s2].toUpperCase() + '  ',
                  style: bodyText2White60),
              Icon(
                Icons.keyboard_arrow_down,
                color: almostWhite,
              )
            ],
          )),
    );
  }
}

Color determineColor(String text) {
  if (text.toLowerCase().contains("buy"))
    return blue;
  else if (text.toLowerCase().contains("sell"))
    return red;
  else
    return yellow;
}
