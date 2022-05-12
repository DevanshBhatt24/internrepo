import 'package:flutter/material.dart';
import 'package:technical_ind/components/LoadingPage.dart';
import 'package:technical_ind/components/noDataAvailable.dart';
import 'package:technical_ind/screens/stocks/business/models/StockDetailsModel.dart';
import 'package:technical_ind/screens/stocks/business/stockServices.dart';
import '../../../styles.dart';

class SwotPage extends StatefulWidget {
  final String isin;
  SwotPage({this.isin});
  @override
  _SwotPageState createState() => _SwotPageState();
}

class _SwotPageState extends State<SwotPage> {
  Swot swot;
  bool loading = true;
  fetchApi() async {
    swot = await StockServices.stockSwotDetails(widget.isin);
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
        : swot == null
            ? NoDataAvailablePage()
            : Scaffold(
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 12),
                        head('Strengths', blue),
                        ...List.generate(
                          swot.strengths.length,
                          (i) => _text(swot.strengths[i]),
                        ),
                        swot.strengths.isEmpty
                            ? _text("No data available")
                            : SizedBox(),
                        // _text('Rising Net Cash Flow & Cash from Operating activity'),
                        // _text('Growth in Net Profit with increasing Profit Margin'),
                        // _text('Annual Net Profits improving for last 2 years'),
                        // _text('Company with Zero Promoter Pledge'),
                        // _text('Near 52 Week High'),
                        // _text(
                        //     'Strong Momentum: Price above short, medium and long term moving averages'),
                        // _text(
                        //     'Effectively using its capital to generate profit- RoCE improving in last 2 years'),
                        // _text('Increasing profits every quarter for past 2 quarters'),
                        // _text('Book Value per share Improving for last 2 years'),
                        // _text('FII/FPI or Institutions increasing their shareholding'),
                        SizedBox(height: 12),
                        head('Weakness', red),
                        ...List.generate(
                          swot.weaknesses.length,
                          (i) => _text(swot.weaknesses[i]),
                        ),

                        swot.weaknesses.isEmpty
                            ? _text("No data available")
                            : SizedBox(),
                        // _text(
                        //     'Strong Momentum: Price above short, medium and long term moving averages'),
                        // _text(
                        //     'Effectively using its capital to generate profit- RoCE improving in last 2 years'),
                        // _text('Increasing profits every quarter for past 2 quarters'),
                        // _text('Book Value per share Improving for last 2 years'),
                        SizedBox(height: 12),
                        head('Opportunities', Colors.green),
                        ...List.generate(
                          swot.opportunities.length,
                          (i) => _text(swot.opportunities[i]),
                        ),
                        swot.opportunities.isEmpty
                            ? _text("No data available")
                            : SizedBox(),
                        // _text(
                        //     'Strong Momentum: Price above short, medium and long term moving averages'),
                        // _text(
                        //     'Effectively using its capital to generate profit- RoCE improving in last 2 years'),
                        // _text('Increasing profits every quarter for past 2 quarters'),
                        SizedBox(height: 12),
                        head('Threat', yellow),
                        ...List.generate(
                          swot.threats.length,
                          (i) => _text(swot.threats[i]),
                        ),
                        swot.threats.isEmpty
                            ? _text("No data available")
                            : SizedBox()
                        // _text(
                        //     'Strong Momentum: Price above short, medium and long term moving averages'),
                        // _text(
                        //     'Effectively using its capital to generate profit- RoCE improving in last 2 years'),
                      ],
                    ),
                  ),
                ),
              );
  }

  Widget head(String s, Color c) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(backgroundColor: c, radius: 3),
          SizedBox(width: 8),
          Text(s, style: subtitle1White)
        ],
      ),
    );
  }

  Widget _text(String s) {
    return Padding(
        padding: EdgeInsets.only(left: 14, top: 6, bottom: 6),
        child: Text(s, style: bodyText2White60));
  }
}
