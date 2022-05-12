import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:technical_ind/components/CircularSFindicator.dart';
import 'package:technical_ind/components/LoadingPage.dart';
import 'package:technical_ind/components/noDataAvailable.dart';
import 'package:technical_ind/screens/stocks/business/models/StockDetailsModel.dart';
import 'package:technical_ind/screens/stocks/business/stockServices.dart';

// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:technical_ind/widgets/item.dart';

import '../../../styles.dart';

class SustainPage extends StatefulWidget {
  final String isin;
  SustainPage({Key key, this.isin}) : super(key: key);

  @override
  _SustainPageState createState() => _SustainPageState();
}

class _SustainPageState extends State<SustainPage> {
  var rand = new Random();
  double _current = 0.91;
  Esg esg;
  bool loading = true;

  fetchApi() async {
    esg = await StockServices.stockEsgDetails(widget.isin);
    _current = esg?.rating?.toUpperCase() == "NEGLIGIBLE"
        ? 25.0
        : esg?.rating?.toUpperCase() == "LOW"
            ? 50.0
            : esg?.rating?.toUpperCase() == "MEDIUM"
                ? 50.0
                : 100;
    setState(() {
      loading = false;
    });
    print(esg.rating);
  }

  @override
  void initState() {
    fetchApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ScreenUtil.init(context,
    //     designSize: Size(360, 640), allowFontScaling: true);
    return loading
        ? LoadingPage()
        : esg?.rating == "no data" &&
                esg.environmentRiskScore == "no data" &&
                esg.socialRiskScore == "no data" &&
                esg.governanceRiskScore == "no data" &&
                esg.totalEsgRiskScore == "no data"
            ? NoDataAvailablePage()
            : Scaffold(
                //backgroundColor: kindaWhite,
                body: SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        SizedBox(height: 30),
                        CircularSFindicator(
                          radius: 200,
                          thickness: 30,
                          value: _current ?? "",
                          center: Text(esg?.rating ?? "", style: subtitle18),
                          color: esg?.rating?.toUpperCase() == "MEDIUM"
                              ? yellow
                              : esg.rating.toUpperCase() == "LOW" ||
                                      esg.rating.toUpperCase() == "NEGLIGIBLE"
                                  ? red
                                  : blue,
                          backgroundColor: grey,
                        ),
                        SizedBox(height: 25),
                        Center(
                          child: Text("ESG Risk Rating", style: subtitle1White),
                        ),
                        SizedBox(height: 26),
                        RowItem(
                            "Environment risk score", esg.environmentRiskScore,
                            pad: 10),
                        RowItem("Social risk score", esg.socialRiskScore,
                            pad: 10),
                        RowItem(
                            "Governance risk score", esg.governanceRiskScore,
                            pad: 10),
                        RowItem("Total ESG risk score", esg.totalEsgRiskScore,
                            pad: 10),
                      ],
                    ),
                  ),
                ),
              );
  }
}
