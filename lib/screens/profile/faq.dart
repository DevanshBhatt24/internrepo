import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import '../../styles.dart';
import '../../widgets/appbar_with_back_and_search.dart';
import 'account/activeSubcription.dart';
import 'account/cancel.dart';

class Faq extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(120),
            child: Column(
              children: [
                AppBarWithBack(
                  text: "FAQ's",
                  height: 40,
                ),
                TabBar(
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: almostWhite,
                  ),
                  unselectedLabelColor: Colors.white38,
                  //indicatorSize: TabBarIndicatorSize.label,
                  indicator: MaterialIndicator(
                    horizontalPadding: 24,
                    bottomLeftRadius: 8,
                    bottomRightRadius: 8,
                    color: almostWhite,
                    paintingStyle: PaintingStyle.fill,
                  ),
                  tabs: [
                    Tab(
                      text: "General",
                    ),
                    Tab(
                      text: "Subscription",
                    ),
                  ],
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Container(
                  child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _data('What type of data available in the app ?',
                          'Stocks, Indices, Forex, Cryptocurrency, Mutual funds, ETF, Commodities and Bonds are covered by Bottom Street.'),
                      _data(
                          'Which financial  instruments are covered by the app?',
                          'Bottom Street covers data of various financial instruments like Stocks, Indices, Forex, Cryptocurrency, Mutual funds ,ETF, Commodities and Bonds ranging from technical to fundamental data all in one place .'),
                      _data('When do data gets update ?',
                          'Most of the data in Bottom street gets real time update .'),
                      _data('Where is data sourced from ?',
                          'Bottom Street works with various data providers across globe and use own custom based analytics neural engine to represent data .'),
                      _data('How do we analyse data ?',
                          'Bottom Street uses custom based analysis tool to inject the data which helps in providing unbiased results.'),
                    ]),
              )),
              Container(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _data('What mode of payment is available ?',
                          'Credit cards, Debit cards, Nach e-mandate, UPI Auto pay all are supported by Bottom Street .'),
                      _data('Why there are two types of plans ?',
                          'Bottom Street supports both monthly and yearly plan to support user preference however, yearly plan provides more value as compared to monthly plan .'),
                      _data('What is the period of free trial ?',
                          'Bottom Street offers 22 days free trial .'),
                      _data(
                          'What are the benefits of yearly plan over monthly ?',
                          'Yearly plan provides both more value and convenience as compared to monthly plan .'),
                      _dataWithLink('Where can I check purchased plan ?',
                          'link', ActiveSubscription(), context),
                      _dataWithLink('How can I cancel my subscription?', 'link',
                          CancelConfirm(), context)
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }

  Widget _data(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: subtitle1White, textAlign: TextAlign.left),
          SizedBox(height: 5),
          Text(subtitle, style: bodyText2White60, textAlign: TextAlign.left)
        ],
      ),
    );
  }

  Widget _dataWithLink(
      String title, String link, Widget screen, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: subtitle1White, textAlign: TextAlign.left),
          SizedBox(height: 5),
          InkWell(
              onTap: () {
                pushNewScreen(context, screen: screen, withNavBar: false);
              },
              child: Text('Here',
                  style: TextStyle(
                      fontSize: 14,
                      color: blue,
                      decoration: TextDecoration.underline),
                  textAlign: TextAlign.left))
        ],
      ),
    );
  }
}
