import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../etf/business/models/etf_explore_model.dart';
import '../../components/heading.dart';
import '../../styles.dart';

class FundsInformation extends StatefulWidget {
  final Standalone standalone;
  final About about;
  final Widget end;
  final Factsheet factsheet;
  final String latestNav, title;
  final MutualPriceDetails mutualFundPriceDetails;
  FundsInformation(
      {Key key,
      this.latestNav,
      this.end,
      this.title,
      this.mutualFundPriceDetails,
      this.about,
      this.standalone,
      this.factsheet})
      : super(key: key);

  @override
  _FundsInformationState createState() => _FundsInformationState();
}

class RepresentationChart extends StatelessWidget {
  final String title;
  final List<RepresentationData> list;

  RepresentationChart({Key key, this.title, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double p = 0, c = 0;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: darkGrey,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(title, textAlign: TextAlign.center, style: subtitle1White),
          Container(
            margin: EdgeInsets.symmetric(vertical: 12),
            width: 300,
            height: 6,
            decoration: BoxDecoration(
              color: darkGrey,
              borderRadius: BorderRadius.circular(4),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Stack(
                children: List.generate(
                  list.length,
                  (i) {
                    c = p;
                    p += (list[i].value / 100) * 300;
                    return Positioned(
                      top: 0,
                      bottom: 0,
                      left: c,
                      child: TweenAnimationBuilder<double>(
                        tween: Tween<double>(
                            begin: 0, end: (list[i].value / 100) * 300),
                        duration: Duration(milliseconds: 800),
                        builder:
                            (BuildContext context, double l, Widget child) =>
                                Container(
                          width: l,
                          color: list[i].color,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              list.length,
              (i) => Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      SizedBox(height: 6.5),
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: list[i].color,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(list[i].value.toString() + '%',
                          style: subtitle1White),
                      Text(list[i].title, style: captionWhite60)
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class RepresentationData {
  String title;
  double value;
  Color color;

  RepresentationData({this.title, this.value, this.color});
}

class _FundsInformationState extends State<FundsInformation> {
  @override
  Widget build(BuildContext context) {
    List<String> titleSplitted = [];

    final List<String> keys = [
      "Number of Fund Managers",
      "Longest Tenure(in Yrs)",
      "Average Tenure(in Yrs)",
      "AMC"
    ];
    final List<String> keysvalue = [
      widget.about.fundManager[0].numberOfFundManager,
      widget.about.fundManager[0].longestTenure,
      widget.about.fundManager[0].averageTenure,
      widget.about.fundManager[0].amc,
    ];

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            // SizedBox(height: 24),
            // Text('Parag Parikh Long Term Equity Fund\nDirect - Growth',
            //     textAlign: TextAlign.center, style: headline6),

            // Container(
            //   width: double.infinity,
            //   margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
            //   padding: EdgeInsets.symmetric(horizontal: 14, vertical: 20),
            //   decoration: BoxDecoration(
            //     // color: darkGrey,
            //     borderRadius: BorderRadius.circular(6),
            //   ),
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       titleSplitted.length == 0
            //           ? Text(widget.title,
            //               textAlign: TextAlign.center, style: subtitle1White)
            //           : Text(titleSplitted[0] + "\n -" + titleSplitted[1] ?? "",
            //               textAlign: TextAlign.center, style: subtitle1White),
            //       SizedBox(
            //         height: 8,
            //       ),
            //       if (widget.latestNav != null) ...[
            //         Text("UNRATED"),
            //         SizedBox(
            //           height: 5,
            //         ),
            //         Text("Latest Nav", style: captionWhite),
            //         Text('${widget.latestNav}', style: bodyText1white),
            //       ],
            //       if (widget.end != null) widget.end,
            //       SizedBox(
            //         height: 5,
            //       ),
            //       if (widget.mutualFundPriceDetails != null)
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             Text(widget.mutualFundPriceDetails.chng),
            //             Text(
            //                 '(${widget.mutualFundPriceDetails.chngPercentage})')
            //           ],
            //         )
            //     ],
            //   ),
            // ),
            // Heading(text: 'Overview'),
            // Center(
            //     child: Text(
            //   'as on 09 Oct 2020',
            //   style: captionWhite60,
            // )),
            // SizedBox(height: 20),
            // column('Benchmark', widget.attribute.basicAttribute[5].benchmark,
            //     'Category', widget.attribute.basicAttribute[1].fundCategory),

            // column('Asset Under Management',
            //     widget.factsheet.assetUnderManagment, 'Exit Ratio', '1.05%'),
            // SizedBox(height: 20),
            // Heading(text: 'Fund Asset Allocation'),
            // Center(
            //   child: Text(
            //     '(Value in %)',
            //     style: captionWhite60,
            //   ),
            // ),
            // SizedBox(height: 20),
            // RepresentationChart(
            //   title: widget.standalone.fundAssetAllocation[0].assetClass,
            //   list: [
            //     RepresentationData(
            //       color: const Color(0xfffd7897),
            //       title: "Equity",
            //       value: double.parse(
            //           widget.standalone.fundAssetAllocation[0].equity),
            //     ),
            //     RepresentationData(
            //       color: const Color(0xfff9bf13),
            //       title: "Debt",
            //       value: double.parse(
            //           widget.standalone.fundAssetAllocation[0].debt),
            //     ),
            //     RepresentationData(
            //       color: const Color(0xff06ce90),
            //       title: "Cash",
            //       value: double.parse(
            //           widget.standalone.fundAssetAllocation[0].cash),
            //     ),
            //   ],
            // ),
            // RepresentationChart(
            //   title: widget.standalone.fundAssetAllocation[1].assetClass,
            //   list: [
            //     RepresentationData(
            //       color: const Color(0xfffd7897),
            //       title: "Equity",
            //       value: double.parse(
            //           widget.standalone.fundAssetAllocation[1].equity),
            //     ),
            //     RepresentationData(
            //       color: const Color(0xfff9bf13),
            //       title: "Debt",
            //       value: double.parse(
            //           widget.standalone.fundAssetAllocation[1].debt),
            //     ),
            //     RepresentationData(
            //       color: const Color(0xff06ce90),
            //       title: "Cash",
            //       value: double.parse(
            //           widget.standalone.fundAssetAllocation[1].cash),
            //     ),
            //   ],
            // ),
            SizedBox(
              height: 5,
            ),

            _headertext("Fund Manager"),

            ...List.generate(
                4,
                (index) => Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                              child: Text(
                            keys[index],
                            style: subtitle1White60,
                          )),
                          Flexible(
                              child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  child: Text(
                                    keysvalue[index],
                                    textAlign: TextAlign.right,
                                    style: subtitle1White,
                                  )))
                        ],
                      ),
                    )),
            SizedBox(height: 10),
            ...List.generate(
                widget.about.fundManager[0].managers.length,
                (index) => Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                              child: Row(children: [
                            Icon(Icons.person_outline),
                            SizedBox(
                              width: 6,
                            ),
                            Text(
                              widget.about.fundManager[0].managers[index].name,
                              style: subtitle1White,
                            ),
                          ])),
                          Flexible(
                              child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  child: Text(
                                    widget.about.fundManager[0].managers[index]
                                        .duration,
                                    textAlign: TextAlign.right,
                                    style: subtitle1White60,
                                  )))
                        ],
                      ),
                    )),
            SizedBox(height: 20),

            _headertext("Basic Attributes"),

            SizedBox(height: 15),
            ...List.generate(
              widget.about.basicAttribute.length,
              (index) => column(widget.about.basicAttribute[index].text,
                  widget.about.basicAttribute[index].value),
            ),

            SizedBox(height: 20),
            _headertext("Concentration Analysis"),

            SizedBox(height: 15),
            ...List.generate(
              widget.about.concentrationAnalysis.length,
              (index) => column(widget.about.concentrationAnalysis[index].title,
                  widget.about.concentrationAnalysis[index].value),
            ),
          ],
        ),
      ),
    );
  }

  Widget column(String a, String b) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              width: MediaQuery.of(context).size.width * 0.4,
              child: Text(a, style: bodyText2White60)),
          Container(
              width: MediaQuery.of(context).size.width * 0.4,
              child: Text(
                b,
                style: bodyText2White,
                textAlign: TextAlign.right,
              )),
        ],
      ),
    );
  }

  Widget _headertext(String text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        // color: darkGrey,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(text, style: subtitle1White, textAlign: TextAlign.center)
        ],
      ),
    );
  }

  Column columnCouple(String a, String b) {
    return Column(
      children: [
        Text(
          a,
          style: bodyText1white,
        ),
        Text(
          b,
          style: captionWhite60,
        ),
      ],
    );
  }
}
