import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../styles.dart';

//RATIOBAR
class CoupleText extends StatelessWidget {
  final String title, value;

  const CoupleText({Key key, this.title, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          new Text(value, textAlign: TextAlign.center, style: captionWhite60),
          new Text(title, textAlign: TextAlign.center, style: subtitle1White),
        ],
      ),
    );
  }
}

class RatioBar extends StatelessWidget {
  final double redValue;

  const RatioBar({Key key, this.redValue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 1 * MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(horizontal: 40.h),
        height: 6.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: blue,
        ),
        child: Row(children: [
          Container(
            width: (1 * MediaQuery.of(context).size.width - 80.h - 32) *
                redValue /
                100, //val
            //margin: EdgeInsets.only(right: 40.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: red,
            ),
          )
        ]));
  }
}

class TableBarWithDropDownTitle extends StatefulWidget {
  final List<String> menu;
  final int currentLeftIndex, currentRightIndex;
  final String title1, title2, title3, title4;
  final bool isextended, isProfitLoss;
  final Function openRight, openLeft;
  const TableBarWithDropDownTitle(
      {Key key,
      this.isProfitLoss = false,
      this.currentLeftIndex,
      this.currentRightIndex,
      this.title1,
      this.menu,
      this.openRight,
      this.openLeft,
      this.title2,
      this.title3,
      this.title4,
      this.isextended = false})
      : super(key: key);

  @override
  _TableBarWithDropDownTitleState createState() =>
      _TableBarWithDropDownTitleState();
}

class _TableBarWithDropDownTitleState extends State<TableBarWithDropDownTitle> {
  List<String> menu = [];
  @override
  void initState() {
    menu = widget.menu;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle _headStyle = captionWhite60;
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
            color: darkGrey, borderRadius: BorderRadius.circular(4)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                flex: widget.isProfitLoss ? 2 : 1,
                child: Text(
                  widget.title1,
                  style: _headStyle,
                  textAlign: TextAlign.left,
                )),
            Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    widget.openLeft(menu, widget.currentLeftIndex);
                  },
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(widget.title2,
                            style: _headStyle,
                            textAlign: widget.title3 == null
                                ? TextAlign.right
                                : TextAlign.center),
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: almostWhite,
                        )
                      ]),
                )),
            widget.title3 != null
                ? Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        widget.openRight(menu, widget.currentRightIndex);
                      },
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(widget.title3,
                                style: _headStyle,
                                textAlign: widget.title4 == null
                                    ? TextAlign.right
                                    : TextAlign.center),
                            Icon(
                              Icons.keyboard_arrow_down,
                              color: almostWhite,
                            )
                          ]),
                    ))
                : Container(),
            widget.title4 != null
                ? Expanded(
                    child: Text(widget.title4,
                        style: _headStyle,
                        textAlign: widget.isextended
                            ? TextAlign.center
                            : TextAlign.right))
                : Container(),
          ],
        ));
  }
}

class TableBar extends StatelessWidget {
  final String title1, title2, title3, title4;
  final bool isextended;

  const TableBar(
      {Key key,
      this.title1,
      this.title2,
      this.title3,
      this.title4,
      this.isextended = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle _headStyle = captionWhite60;
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
            color: darkGrey, borderRadius: BorderRadius.circular(4)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Text(
              title1,
              style: _headStyle,
              textAlign: TextAlign.left,
            )),
            Expanded(
                child: Text(title2,
                    style: _headStyle,
                    textAlign:
                        title3 == null ? TextAlign.right : TextAlign.center)),
            title3 != null
                ? Expanded(
                    child: Text(title3,
                        style: _headStyle,
                        textAlign: title4 == null
                            ? TextAlign.right
                            : TextAlign.center))
                : Container(),
            title4 != null
                ? Expanded(
                    child: Text(title4,
                        style: _headStyle,
                        textAlign:
                            isextended ? TextAlign.center : TextAlign.right))
                : Container(),
          ],
        ));
  }
}

class TableBarv2 extends StatelessWidget {
  final String title1, title2, title3, title4, title5;
  final bool isextended;
  final Color color;

  const TableBarv2(
      {Key key,
      this.title1,
      this.title2,
      this.title3,
      this.title4,
      this.title5,
      this.color,
      this.isextended = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle _headStyle = captionWhite60;
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
            color: darkGrey, borderRadius: BorderRadius.circular(4)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                flex: 4,
                child: Text(
                  title1,
                  style: _headStyle.copyWith(color: color ?? white60),
                  textAlign: TextAlign.left,
                )),
            Expanded(
                flex: 3,
                child: Text(title2,
                    style: _headStyle,
                    textAlign:
                        title3 == null ? TextAlign.right : TextAlign.center)),
            title3 != null
                ? Expanded(
                    flex: 3,
                    child: Text(title3,
                        style: _headStyle,
                        textAlign: title4 == null
                            ? TextAlign.right
                            : TextAlign.center))
                : Container(),
            title4 != null
                ? Expanded(
                    flex: 3,
                    child: Text(title4,
                        style: _headStyle,
                        textAlign:
                            isextended ? TextAlign.center : TextAlign.right))
                : Container(),
            title5 != null
                ? Expanded(
                    flex: 3,
                    child: Text(title5,
                        style: _headStyle,
                        textAlign:
                            isextended ? TextAlign.center : TextAlign.right))
                : Container(),
          ],
        ));
  }
}

class TableItemv2 extends StatelessWidget {
  final String title, value, remarks, total, day3;
  final bool isextended;
  final Color valueColor, remarksColor, titleColor;
  final double fontSize;

  const TableItemv2(
      {Key key,
      this.title,
      this.value,
      this.day3,
      this.remarks,
      this.fontSize,
      this.valueColor,
      this.remarksColor,
      this.total,
      this.isextended = false,
      this.titleColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 4,
            child: Text(
              title,
              textAlign: TextAlign.left,
              style: bodyText2.copyWith(
                  fontSize: fontSize != null ? fontSize : 14,
                  color: titleColor != null
                      ? titleColor
                      : Colors.white.withOpacity(0.6)),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              textAlign: remarks != null ? TextAlign.center : TextAlign.right,
              style: bodyText2.copyWith(
                  fontSize: fontSize != null ? fontSize : 14,
                  color: valueColor ?? almostWhite),
            ),
          ),
          remarks != null
              ? Expanded(
                  flex: 3,
                  child: Text(
                    remarks,
                    textAlign:
                        total != null ? TextAlign.center : TextAlign.right,
                    style: bodyText2.copyWith(
                        fontSize: fontSize != null ? fontSize : 14,
                        color: remarksColor ?? almostWhite),
                  ),
                )
              : Container(),
          total != null
              ? Expanded(
                  flex: 3,
                  child: Text(
                    total,
                    textAlign: isextended ? TextAlign.center : TextAlign.right,
                    style: bodyText2.copyWith(
                        fontSize: fontSize != null ? fontSize : 14,
                        color: remarksColor ?? almostWhite),
                  ),
                )
              : Container(),
          day3 != null
              ? Expanded(
                  flex: 3,
                  child: Text(
                    day3,
                    textAlign: isextended ? TextAlign.center : TextAlign.right,
                    style: bodyText2.copyWith(
                        fontSize: fontSize != null ? fontSize : 14,
                        color: remarksColor ?? almostWhite),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
