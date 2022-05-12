//import 'package:flutter_screenutil/size_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:technical_ind/widgets/item.dart';
import 'business/commodity_overview_model.dart';
import 'business/commodity_services.dart';
import '../../components/slidePanel.dart';
import '../../styles.dart';

class OverviewCommodity extends StatefulWidget {
  final Overview overview;
  OverviewCommodity({this.overview});
  @override
  _OverviewCommodityState createState() => _OverviewCommodityState();
}

class _OverviewCommodityState extends State<OverviewCommodity> {
  int _selected = 0;
  List<String> menu;
  List<Value> values;
  PanelController _panelController = new PanelController();

  @override
  void initState() {
    super.initState();
    menu = widget.overview.dates;
    values = widget.overview.values;
  }

  @override
  Widget build(BuildContext context) {
    return SlidePanel(
      menu: menu,
      defaultWidget: menu[_selected],
      panelController: _panelController,
      onChange: (val) {
        setState(() {
          _selected = val;
        });
      },
      child: Scaffold(
        body: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                SizedBox(height: 24),
                buildInkWell(),
                SizedBox(height: 24),
                Text(values[_selected].price, style: headline5White),
                SizedBox(height: 2),
                Text(
                  values[_selected].chgChgpercent[0] == '-'
                      ? values[_selected].chgChgpercent
                      : '+' +
                          values[_selected].chgChgpercent.substring(
                              0,
                              values[_selected].chgChgpercent.indexOf('(') +
                                  1) +
                          '+' +
                          values[_selected].chgChgpercent.substring(
                              values[_selected].chgChgpercent.indexOf('(') + 1),
                  style: bodyText2.copyWith(
                    color:
                        values[_selected].chgChgpercent[0] == '-' ? red : blue,
                  ),
                ),
                SizedBox(height: 22),
                RowItem("Open", values[_selected].open),
                RowItem('Average Price', values[_selected].averagePrice),
                RowItem('High', values[_selected].high),
                RowItem('Low', values[_selected].low),
                RowItem('Volume', values[_selected].volume),
                RowItem('Market Lot', values[_selected].marketLot),
                RowItem('Bid Price', values[_selected].bidPrice),
                RowItem('Bid Quantity', values[_selected].bidQuantity),
                RowItem('Offer Price', values[_selected].offerPrice),
                RowItem('Offer Quantity', values[_selected].offerQuantity),
                RowItem('Open Interest', values[_selected].openInterest),
                RowItem('Change in OI', values[_selected].changeInOi),
              ],
            )),
      ),
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
            children: <Widget>[
              Text(menu[_selected], style: button.copyWith(color: white60)),
              Icon(
                Icons.keyboard_arrow_down_outlined,
                color: white60,
              )
            ],
          )),
    );
  }
}
