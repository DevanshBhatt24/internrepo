import 'package:flutter/material.dart';

import '../styles.dart';

class TableItem extends StatelessWidget {
  final String title, value, remarks, total;
  final bool isextended, isProfitLoss, isTitle, isFinancial;
  final Color valueColor, remarksColor;
  final double fontSize;

  const TableItem(
      {Key key,
      this.isFinancial = false,
      this.isTitle = false,
      this.isProfitLoss = false,
      this.title,
      this.value,
      this.remarks,
      this.fontSize,
      this.valueColor,
      this.remarksColor,
      this.total,
      this.isextended = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: isProfitLoss? 2:1,
            child: Text(
              title,
              textAlign: TextAlign.left,
              style: isTitle
                  ? subtitle1White
                  : isFinancial
                      ? captionWhite60
                      : bodyText2.copyWith(
                          fontSize: fontSize != null ? fontSize : 14,
                          color: isextended ? Colors.white60 : almostWhite),
            ),
          ),
          Expanded(
            flex: 1,
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
                  child: Text(
                    total,
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
