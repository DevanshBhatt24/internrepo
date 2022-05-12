import 'package:flutter/material.dart';

import '../styles.dart';

class FlatTile extends StatelessWidget {
  final String title;
  final Widget midWidget;
  bool isMf;
  final List<String> titleRow, valueRow;

  FlatTile(
      {Key key,
      this.title,
      this.midWidget,
      this.titleRow,
      this.valueRow,
      this.isMf = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> titleSplitted = [];
    if (title.contains('-')) titleSplitted = title.split('-');
    return Container(
      // width: 328,
      // height: titleRow.length == 3 ? 165 : 235,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: darkGrey,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            titleSplitted.length == 0
                ? Text(title,
                    textAlign: TextAlign.center, style: subtitle1White)
                : Text(titleSplitted[0] + "\n -" + titleSplitted[1] ?? "",
                    textAlign: TextAlign.center, style: subtitle1White),
            SizedBox(
              height: 8,
            ),
            midWidget,
            titleRow.length == 3
                ? SizedBox(
                    height: 18,
                  )
                : SizedBox(
                    height: 10,
                  ),
            titleRow.length == 3
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(titleRow[0],
                              textAlign: TextAlign.start,
                              style: captionWhite38),
                          Text(valueRow[0],
                              textAlign: TextAlign.start,
                              style: isMf ? bodyText2Blue : bodyText2White),
                        ],
                      ),
                      Column(
                        children: [
                          Text(titleRow[1],
                              textAlign: TextAlign.center,
                              style: captionWhite38),
                          Text(valueRow[1],
                              textAlign: TextAlign.center,
                              style: bodyText2White),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(titleRow[2],
                              textAlign: TextAlign.end, style: captionWhite38),
                          Text(valueRow[2],
                              textAlign: TextAlign.end, style: bodyText2White),
                        ],
                      ),
                    ],
                  )
                : Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Text("Latest Nav", style: captionWhite),
                        Text(valueRow[4], style: bodyText1white),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(titleRow[0],
                                textAlign: TextAlign.start,
                                style: captionWhite38),
                            Text(valueRow[0],
                                textAlign: TextAlign.center,
                                style: bodyText2White),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(titleRow[1],
                                textAlign: TextAlign.start,
                                style: captionWhite38),
                            Text(valueRow[1],
                                textAlign: TextAlign.center,
                                style: bodyText2White),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(titleRow[2],
                                textAlign: TextAlign.start,
                                style: captionWhite38),
                            Text(valueRow[2],
                                textAlign: TextAlign.center,
                                style: bodyText2White),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(titleRow[3],
                                textAlign: TextAlign.start,
                                style: captionWhite38),
                            Text(valueRow[3],
                                textAlign: TextAlign.start,
                                style: bodyText2red),
                          ],
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
