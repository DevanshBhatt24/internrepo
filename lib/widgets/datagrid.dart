import 'package:flutter/material.dart';

import '../styles.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';

class CustomTable extends StatefulWidget {
  final List<String> headersTitle;
  final ScrollPhysics scrollPhysics;
  final List<Widget> leftSideChildren, rightSideChildren;
  final Widget Function(BuildContext, int) rightSideItemBuilder,
      leftSideItemBuilder;
  final double fixedColumnWidth, columnwidth;
  final int totalColumns, itemCount;
  final ScrollController horizontalScrollController;
  final ScrollController verticalScrollController;
  final ScrollbarStyle verticalScrollbarStyle;
  final ScrollbarStyle horizontalScrollbarStyle;

  CustomTable(
      {Key key,
      this.headersTitle,
      this.fixedColumnWidth,
      this.columnwidth,
      this.totalColumns,
      this.itemCount,
      this.rightSideItemBuilder,
      this.leftSideItemBuilder,
      this.scrollPhysics = const ClampingScrollPhysics(),
      this.leftSideChildren,
      this.rightSideChildren,
      this.horizontalScrollController,
      this.verticalScrollController,
      this.horizontalScrollbarStyle,
      this.verticalScrollbarStyle})
      : super(key: key);

  @override
  _CustomTable2State createState() => _CustomTable2State();
}

class _CustomTable2State extends State<CustomTable> {
  bool indicator = true;
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.offset ==
          scrollController.position.minScrollExtent) {
        setState(() {
          indicator = true;
        });
      } else {
        setState(() {
          indicator = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    TextStyle _headStyle = captionWhite60;

    return Stack(
      children: [
        Positioned.fill(
          child: HorizontalDataTable(
            scrollPhysics: NeverScrollableScrollPhysics(),
            horizontalScrollController: scrollController,
            horizontalScrollbarStyle: widget.horizontalScrollbarStyle,
            verticalScrollController: widget.verticalScrollController,
            verticalScrollbarStyle: widget.verticalScrollbarStyle,
            leftHandSideColumnWidth: widget.fixedColumnWidth,
            rightHandSideColumnWidth:
                (widget.totalColumns - 1) * widget.columnwidth,
            isFixedHeader: true,
            elevationColor: Colors.white,
            leftSideChildren: widget.leftSideChildren,
            rightSideChildren: widget.rightSideChildren,
            headerWidgets: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4),
                    bottomLeft: Radius.circular(4)),
                child: Container(
                  width: widget.fixedColumnWidth,
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: darkGrey,
                  ),
                  child: Text(
                    widget.headersTitle[0],
                    style: _headStyle,
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              ...List.generate(
                widget.headersTitle.length - 1,
                (index) => Container(
                  width: widget.columnwidth,
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: darkGrey,
                    borderRadius: index != widget.headersTitle.length - 2
                        ? BorderRadius.zero
                        : BorderRadius.only(
                            bottomRight: Radius.circular(4),
                            topRight: Radius.circular(4)),
                  ),
                  child: Text(
                    widget.headersTitle[index + 1],
                    style: _headStyle,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
            leftSideItemBuilder: widget.leftSideItemBuilder,
            rightSideItemBuilder: widget.rightSideItemBuilder,
            itemCount: widget.itemCount,
            rowSeparatorWidget: Container(),
            leftHandSideColBackgroundColor: Colors.black,
            rightHandSideColBackgroundColor: Colors.black,
          ),
        ),
        Positioned(
            top: 0,
            bottom: 0,
            left: MediaQuery.of(context).size.width - 50,
            right: 0,
            child: indicator && widget.headersTitle.length > 3
                ? Container(
                    width: 20,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          black.withOpacity(0.4),
                          grey,
                        ],
                      ),
                    ),
                    child: Center(child: Icon(Icons.chevron_right)),
                  )
                : Container()),
      ],
    );
  }
}

class DataTableItem extends StatelessWidget {
  final List<String> data;
  final double upperPadding, height;
  final Color color;

  const DataTableItem(
      {Key key, this.data, this.upperPadding = 10, this.height, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int reducedLength = data.length > 0 ? data.length - 1 : 0;
    return Container(
      height: height,
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: upperPadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ...List.generate(
            reducedLength,
            (index) => Expanded(
              child: Text(data[index],
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  style: bodyText2White),
            ),
          ),
          Expanded(
            child: Text(data.length > 0 ? data[reducedLength] : "",
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.fade,
                softWrap: false,
                style: color != null
                    ? bodyText2.copyWith(color: color)
                    : bodyText2White),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// import '../styles.dart';
// import 'dataTable/horizental_data_table.dart';

// class CustomTable extends StatelessWidget {
//   final List<String> headersTitle;
//   final ScrollPhysics scrollPhysics;
//   final List<Widget> leftSideChildren, rightSideChildren;
//   final Widget Function(BuildContext, int) rightSideItemBuilder,
//       leftSideItemBuilder;
//   final double fixedColumnWidth, columnwidth;
//   final int totalColumns, itemCount;

//   CustomTable(
//       {Key key,
//       this.headersTitle,
//       this.fixedColumnWidth,
//       this.columnwidth,
//       this.totalColumns,
//       this.itemCount,
//       this.rightSideItemBuilder,
//       this.leftSideItemBuilder,
//       this.scrollPhysics = const ClampingScrollPhysics(),
//       this.leftSideChildren,
//       this.rightSideChildren})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     TextStyle _headStyle = captionWhite60;
//     return HorizontalDataTable(
//       scrollPhysics: scrollPhysics,
//       leftHandSideColumnWidth: fixedColumnWidth,
//       rightHandSideColumnWidth: (totalColumns - 1) * columnwidth,
//       isFixedHeader: true,
//       elevationColor: Colors.white,
//       leftSideChildren: leftSideChildren,
//       rightSideChildren: rightSideChildren,
//       headerWidgets: [
//         ClipRRect(
//           borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(4), bottomLeft: Radius.circular(4)),
//           child: Container(
//             width: fixedColumnWidth,
//             padding: EdgeInsets.all(4),
//             decoration: BoxDecoration(
//               color: darkGrey,
//             ),
//             child: Text(
//               headersTitle[0],
//               style: _headStyle,
//               textAlign: TextAlign.left,
//             ),
//           ),
//         ),
//         ...List.generate(
//             headersTitle.length - 1,
//             (index) => Container(
//                   width: columnwidth,
//                   padding: EdgeInsets.all(4),
//                   decoration: BoxDecoration(
//                     color: darkGrey,
//                     borderRadius: index != headersTitle.length - 2
//                         ? BorderRadius.zero
//                         : BorderRadius.only(
//                             bottomRight: Radius.circular(4),
//                             topRight: Radius.circular(4)),
//                   ),
//                   child: Text(
//                     headersTitle[index + 1],
//                     style: _headStyle,
//                     textAlign: TextAlign.center,
//                   ),
//                 ))
//       ],
//       leftSideItemBuilder: leftSideItemBuilder,
//       rightSideItemBuilder: rightSideItemBuilder,
//       itemCount: itemCount,
//       rowSeparatorWidget: Container(),
//       leftHandSideColBackgroundColor: Colors.black,
//       rightHandSideColBackgroundColor: Colors.black,
//     );
//   }
// }

// class DataTableItem extends StatelessWidget {
//   final List<String> data;
//   final double upperPadding, height;
//   final Color color;

//   const DataTableItem(
//       {Key key, this.data, this.upperPadding = 10, this.height, this.color})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: height,
//       padding: EdgeInsets.symmetric(horizontal: 0, vertical: upperPadding),
//       child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
//         ...List.generate(
//             data.length - 1,
//             (index) => Expanded(
//                   child: Text(data[index],
//                       textAlign: TextAlign.center, style: bodyText2White),
//                 )),
//         Expanded(
//           child: Text(data[data.length - 1],
//               textAlign: TextAlign.center,
//               style: color != null
//                   ? bodyText2.copyWith(color: color)
//                   : bodyText2White),
//         ),
//       ]),
//     );
//   }
// }
