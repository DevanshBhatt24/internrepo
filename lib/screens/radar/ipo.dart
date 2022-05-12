import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:horizontal_data_table/refresh/pull_to_refresh/pull_to_refresh.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:technical_ind/components/LoadingPage.dart';
import 'package:technical_ind/components/noDataAvailable.dart';
import 'package:technical_ind/widgets/appbar_with_back_and_search.dart';
import 'package:technical_ind/widgets/datagrid.dart';
import 'package:url_launcher/url_launcher.dart';
import 'business/IPO/ipo_model.dart';
import 'business/IPO/ipo_services.dart';
import '../../styles.dart';
import 'business/IPO/ipo_indi_model.dart';
import 'package:numeral/numeral.dart';

class IPO extends StatefulWidget {
  @override
  _IPOState createState() => _IPOState();
}

class _IPOState extends State<IPO> {
  bool _loading = true;
  List<IpoModel> ipolist;
  // IpoIndividualModel ipoIndividualresults;
  void getIpoList() async {
    ipolist = await IpoServices.getIpoList();
    // ipoIndividualresults = await IpoServices.getIpoIndiResults(query);
    setState(() {
      _loading = false;
    });
    _refreshController.refreshCompleted();
  }

  @override
  void initState() {
    super.initState();
    getIpoList();
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        initialIndex: 1,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(106),
            child: Column(
              children: [
                AppBarWithBack(
                  text: 'IPO',
                ),
                TabBar(
                  labelStyle: buttonWhite,
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
                      text: "Past",
                    ),
                    Tab(
                      text: "Current",
                    ),
                    Tab(
                      text: "Upcoming",
                    ),
                  ],
                ),
              ],
            ),
          ),
          body: _loading
              ? LoadingPage()
              : ipolist == null
                  ? NoDataAvailablePage()
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                      child: TabBarView(
                        children: [
                          SmartRefresher(
                            controller: _refreshController,
                            enablePullDown: true,
                            enablePullUp: false,
                            header: ClassicHeader(
                              completeIcon:
                                  Icon(Icons.done, color: Colors.white60),
                              refreshingIcon: SizedBox(
                                width: 25,
                                height: 25,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.0,
                                  color: Colors.white60,
                                ),
                              ),
                            ),
                            onRefresh: () => getIpoList(),
                            child: ListView.builder(
                                itemBuilder: (c, i) => ipo(
                                      context,
                                      ipolist[0]?.data?.past[i].companyName ??
                                          "",
                                      ipolist[0]
                                              ?.data
                                              ?.past[i]
                                              .issueOpeningDate ??
                                          "",
                                      ipolist[0]
                                              ?.data
                                              ?.past[i]
                                              .issueClosingDate ??
                                          "",
                                      ipolist[0]?.data?.past[i].priceBand ?? "",
                                      ipolist[0]?.data?.past[i].minLotSize ??
                                          "",
                                      ipolist[0]?.data?.past[i].ipoSizeApprox ??
                                          "",
                                    ),
                                itemCount: ipolist[0].data?.past?.length ?? 0),
                          ),
                          SmartRefresher(
                            controller: _refreshController,
                            enablePullDown: true,
                            enablePullUp: false,
                            header: ClassicHeader(
                              completeIcon:
                                  Icon(Icons.done, color: Colors.white60),
                              refreshingIcon: SizedBox(
                                width: 25,
                                height: 25,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.0,
                                  color: Colors.white60,
                                ),
                              ),
                            ),
                            onRefresh: () => getIpoList(),
                            child: ListView.builder(
                                itemBuilder: (c, i) => ipo(
                                      context,
                                      ipolist[0]
                                              ?.data
                                              ?.current[i]
                                              ?.companyName ??
                                          "",
                                      ipolist[0]
                                              ?.data
                                              ?.current[i]
                                              ?.issueOpeningDate ??
                                          "",
                                      ipolist[0]
                                              ?.data
                                              ?.current[i]
                                              ?.issueClosingDate ??
                                          "",
                                      ipolist[0]?.data?.current[i].priceBand ??
                                          "",
                                      ipolist[0]?.data?.current[i].minLotSize ??
                                          "",
                                      ipolist[0]
                                              ?.data
                                              ?.current[i]
                                              .ipoSizeApprox ??
                                          "",
                                    ),
                                itemCount:
                                    ipolist[0].data?.current?.length ?? 0),
                          ),
                          SmartRefresher(
                            controller: _refreshController,
                            enablePullDown: true,
                            enablePullUp: false,
                            header: ClassicHeader(
                              completeIcon:
                                  Icon(Icons.done, color: Colors.white60),
                              refreshingIcon: SizedBox(
                                width: 25,
                                height: 25,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.0,
                                  color: Colors.white60,
                                ),
                              ),
                            ),
                            onRefresh: () => getIpoList(),
                            child: ListView.builder(
                                itemBuilder: (c, i) => ipoUpcoming(
                                      context,
                                      ipolist[0]
                                              ?.data
                                              ?.upcoming[i]
                                              .companyName ??
                                          "",
                                      ipolist[0].data.upcoming[i].ipoSize ?? "",
                                      ipolist[0]
                                              .data
                                              .upcoming[i]
                                              .tentativeDates ??
                                          "",
                                    ),
                                itemCount:
                                    ipolist[0].data.upcoming.length ?? 0),
                          ),
                        ],
                      ),
                    ),
        ));
  }

  Widget ipo(BuildContext context, String name, String opendate,
      String closedate, String priceband, String lotsize, String iposize) {
    return InkWell(
      onTap: () {
        pushNewScreen(context, screen: IPOIndividual(title: name));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: darkGrey,
        ),
        child: Column(
          children: [
            Text(name ?? "", style: subtitle1White),
            SizedBox(height: 10),
            opendate == null || closedate == null
                ? Text("-", style: subtitle2White)
                : Text(opendate + ' - ' + closedate, style: subtitle2White),
            Text('(Issue Date)', style: captionWhite60),
            SizedBox(height: 13),
            rows('Price Band', '₹ ' + priceband ?? ""),
            rows('Min Lot Size', lotsize ?? ""),
            rows('IPO Size (approx)', '₹ ' + iposize ?? ""),
          ],
          crossAxisAlignment: CrossAxisAlignment.center,
        ),
      ),
    );
  }

  Widget ipoUpcoming(
      BuildContext context, String name, String iposize, String date) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: darkGrey,
      ),
      child: Column(
        children: [
          Text(name ?? "", style: subtitle1White),
          SizedBox(height: 10),
          Text(date ?? "", style: subtitle2White),
          Text('(tentative date)', style: captionWhite60),
          SizedBox(height: 13),
          rows('IPO Size (approx)', '₹ ' + iposize ?? ""),
        ],
        crossAxisAlignment: CrossAxisAlignment.center,
      ),
    );
  }

  Widget rows(String s, String d) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(s, textAlign: TextAlign.left, style: captionWhite60),
          Text(d, textAlign: TextAlign.right, style: captionWhite)
        ],
      ),
    );
  }
}

class IPOIndividual extends StatefulWidget {
  final String title;

  IPOIndividual({Key key, this.title}) : super(key: key);

  @override
  _IPOIndividualState createState() => _IPOIndividualState();
}

class _IPOIndividualState extends State<IPOIndividual> {
  final List<String> _category = ['QIB', 'NII', 'Retail', 'Employee', 'TOTAL'];

  final List<String> head = [
    "Category",
    "Shares",
    "10 Nov",
    "10 Nov",
  ];
  bool _loading = true;
  IpoIndividualModel arr;
  void _getData() async {
    try {
      arr = await IpoServices.getIpoIndiResults(widget.title);
    } catch (e) {}
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithBack(
        text: "",
      ),
      body: _loading
          ? LoadingPage()
          : arr == null
              ? NoDataAvailablePage()
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 24,
                        ),
                        Center(
                          child: Text(
                            widget.title,
                            style: headline6,
                          ),
                        ),
                        SizedBox(
                          height: 38,
                        ),
                        Center(child: Text('Profile', style: subtitle1White)),
                        SizedBox(height: 40),
                        text('About'),
                        SizedBox(height: 15),
                        // text2(
                        //   'Angel Broking is one of the largest retail broking houses in India in terms of active clients on NSE asof June 30, 2020 Company is a technology-ledfinancial services company providing broking andadvisory services, margin funding, loans against shares (through one of our Subsidiaries, AFPL) and financial products distribution to our clients under the brand “Angel Broking”.',
                        // ),
                        text2(
                          arr.message ?? '-',
                        ),
                        SizedBox(height: 38),
                        //Management team API fix
                        text('Management Team'),
                        SizedBox(height: 27),
                        ...List.generate(
                          arr.managementTeam.length,
                          (index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                text1(arr.managementTeam[index].name != null
                                    ? arr.managementTeam[index].name.trim()
                                    : '-'),
                                text2(arr.managementTeam[index].designation !=
                                        null
                                    ? arr.managementTeam[index].designation
                                        .trim()
                                    : '-'),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            );
                          },
                        ),
                        // text1('Mr. Dinesh D. Thakkar'),
                        // // text1(arr.managementTeam.chairmanAndManagingDirector),
                        // text2('Chairman and Managing Director'),
                        // SizedBox(height: 20),
                        // // text1(arr.managementTeam.directorAndChiefExecutiveOfficer),
                        // text2('Director and Chief Executive Officer'),
                        // SizedBox(height: 20),
                        // // text1(arr.managementTeam.independentDirector),
                        // text2('Independent Director'),
                        SizedBox(height: 18),
                        text('Contact Info'),
                        SizedBox(height: 26),
                        // text1('Sy. No. 143 – 148, 150 and 151'),
                        text1(
                          arr.contactInfo.address != null
                              ? arr.contactInfo?.address?.replaceAll(', ', '\n')
                              : '-',
                        ),
                        // text1('Near Gandi Maisamma ‘X’ Roads'),
                        // text1('D.P. Pally, Dundigal, Dundigal – Gandi Maisamma'),
                        // text1('(M) Medchal-Malkajgiri District'),
                        // text1('Hyderabad 500 043'),
                        // text1('Telangana, India'),
                        SizedBox(height: 20),
                        text2('Tel:'),
                        // text1('+91 40 3051 0999'),
                        text1(arr.contactInfo?.telephoneNumber
                                ?.replaceAll(' ', '') ??
                            '-'),
                        SizedBox(height: 20),
                        text2('Website:'),
                        // text1('www.glandpharma.com'),
                        text3(
                          arr.contactInfo.website?.replaceAll(' ', '') ?? '-',
                          () async {
                            await launch(
                              'https://' + getTrimed(arr.contactInfo?.website),
                            );
                          },
                        ),
                        SizedBox(height: 20),
                        text2('E-mail:'),
                        text3(
                          arr.contactInfo.email?.replaceAll(' ', '') ?? '-',
                          () async {
                            await launch(
                              Uri(
                                scheme: 'mailto',
                                path:
                                    arr.contactInfo.email?.replaceAll(' ', ''),
                              ).toString(),
                            );
                          },
                        ),
                        SizedBox(height: 46),
                        Center(
                            child: Text('IPO Details', style: subtitle1White)),
                        SizedBox(height: 40),
                        text('IPO Details'),
                        SizedBox(height: 26),
                        column(
                            'Issues Opens',
                            arr.ipoDetails.issuesOpensOn ?? '-',
                            'Issues Closes',
                            arr.ipoDetails.issueClosesOn ?? '-'),
                        column('Offer Price', arr.ipoDetails.issuePrice ?? '-',
                            'Face Value', arr.ipoDetails.faceValue ?? '-'),
                        column(
                            'Retail Category Allocation',
                            arr.ipoDetails.retailCategoryAllocation ?? '-',
                            'Minimum Lot',
                            arr.ipoDetails.minimumLot ?? '-'),
                        column(
                          'Minimum Investment',
                          arr.ipoDetails.minimumInvestment ?? '-',
                          'Issue Constitutes',
                          arr.ipoDetails.issueConstitutes ?? '-',
                        ),
                        column('Issue Size', arr.ipoDetails.issueSize,
                            'Market Cap', arr.ipoDetails.marketCap ?? '-'),
                        column(
                            'Listing At',
                            arr.ipoDetails.listingAt ?? '-',
                            'Equity Shares\nOffered (OFS)',
                            arr.ipoDetails.equitySharesOfferedOfs ?? '-'),
                        column(
                          'Equity Shares Prior\nto the Issue',
                          arr.ipoDetails.equitySharesPriorToTheIssue ?? '-',
                          'Equity Shares\nafter the Issue',
                          arr.ipoDetails.equitySharesAfterTheIssue ?? '-',
                        ),
                        SizedBox(height: 36),
                        text('Important Dates'),
                        SizedBox(height: 26),
                        column(
                          'Finalization of Basis\nof Allotment',
                          arr.importantDates.finalizationOfBasisOfAllotment
                                  ?.replaceAll('Before ', 'Before\n') ??
                              '-',
                          'Initiation of Refunds',
                          arr.importantDates.initiationOfRefunds
                                  ?.replaceAll('Before ', 'Before\n') ??
                              '-',
                        ),
                        column(
                                'Credit of Equity Shares',
                                arr.importantDates.creditOfEquityShares
                                        ?.replaceAll('Before ', 'Before\n') ??
                                    '-',
                                'Listing Date',
                                arr.importantDates.listingDate
                                    ?.replaceAll('Before ', 'Before\n')) ??
                            '-',
                        SizedBox(height: 36),
                        text('Subscription Details'),
                        SizedBox(height: 26),
                        // TableBarv2(
                        //   title1: head[0],
                        //   title2: head[1],
                        //   title3: "Day 1",
                        //   title4: "Day 2",
                        //   title5: "Day 3",
                        //   isextended: true,
                        // ),
                        Container(
                          height: _category.length * 44.0,
                          child: CustomTable(
                            fixedColumnWidth: 0.25 * MediaQuery.of(context).size.width,
                            columnwidth: 0.24 * MediaQuery.of(context).size.width,
                            headersTitle: [
                              head[0],
                              head[1],
                              "Day 1",
                              "Day 2",
                              "Day 3",
                            ],
                            totalColumns: 5,
                            itemCount: _category.length ?? 0,
                            leftSideItemBuilder: (c, i) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  _category[i],
                                  style: bodyText2White,
                                ),
                              );
                            },
                            rightSideItemBuilder: (c, index) {
                              Employee d;
                              if (index == 0) {
                                d = arr.summary?.qib;
                              } else if (index == 1) {
                                d = arr.summary?.nii;
                              } else if (index == 2) {
                                d = arr.summary?.retail;
                              } else if (index == 3) {
                                d = arr.summary?.employee;
                              } else if (index == 4) {
                                d = arr.summary?.total;
                              }
                              return DataTableItem(
                                data: [
                                  d.shares != null
                                      ? d.shares == 'no data'
                                          ? 'TBA'
                                          : d.shares
                                      : '-',
                                  d.day1 != null
                                      ? d.day1 == 'no data'
                                          ? 'TBA'
                                          : d.day1
                                      : '-',
                                  d.day2 != null
                                      ? d.day2 == 'no data'
                                          ? 'TBA'
                                          : d.day2
                                      : '-',
                                  d.day3 != null
                                      ? d.day3 == 'no data'
                                          ? 'TBA'
                                          : d.day3
                                      : '-',
                                ],
                              );
                            },
                          ),
                        ),
                        // ...List.generate(
                        //   _category.length,
                        //   (index) {
                        //     Employee d;
                        //     if (index == 0) {
                        //       d = arr.summary?.qib;
                        //     } else if (index == 1) {
                        //       d = arr.summary?.nii;
                        //     } else if (index == 2) {
                        //       d = arr.summary?.retail;
                        //     } else if (index == 3) {
                        //       d = arr.summary?.employee;
                        //     } else if (index == 4) {
                        //       d = arr.summary?.total;
                        //     }
                        //     return TableItemv2(
                        //       isextended: true,
                        //       title: _category[index],
                        //       value: d.shares != null
                        //           ? d.shares == 'no data'
                        //               ? 'TBA'
                        //               : d.shares
                        //           : '-',
                        //       remarks: d.day1 != null
                        //           ? d.day1 == 'no data'
                        //               ? 'TBA'
                        //               : d.day1
                        //           : '-',
                        //       total: d.day2 != null
                        //           ? d.day2 == 'no data'
                        //               ? 'TBA'
                        //               : d.day2
                        //           : '-',
                        //       day3: d.day3 != null
                        //           ? d.day3 == 'no data'
                        //               ? 'TBA'
                        //               : d.day3
                        //           : '-',
                        //     );
                        //   },
                        // ),
                        SizedBox(height: 48),
                        text('IPO Allotment Status'),
                        SizedBox(height: 22),
                        text2('Link InTime Website'),
                        text3(
                            getTrimed(arr.ipoAllotmentStatus.linkInTimeWebsite),
                            () async {
                          await launch(getTrimed(
                              arr.ipoAllotmentStatus.linkInTimeWebsite));
                        }),
                        SizedBox(height: 20),
                        text2('BSE IPO Website'),
                        text3(getTrimed(arr.ipoAllotmentStatus.bseIpoWebsite),
                            () async {
                          await launch(
                              getTrimed(arr.ipoAllotmentStatus.bseIpoWebsite));
                        }),
                        SizedBox(height: 48),
                        text('Registrar Info'),
                        SizedBox(height: 26),
                        text1(arr.registrarInfo.address != null
                            ? arr.registrarInfo.address?.replaceAll(', ', '')
                            : '-'),
                        SizedBox(height: 20),
                        text2('Tel:'),
                        text1(arr.registrarInfo.telephoneNumber ?? '-'),
                        SizedBox(height: 20),
                        text2('Website:'),
                        text3(
                          getTrimed(arr.registrarInfo?.website),
                          () async {
                            await launch(
                              'https://' +
                                  getTrimed(arr.registrarInfo?.website),
                            );
                          },
                        ),
                        SizedBox(height: 20),
                        text2('E-mail:'),
                        text3(
                          getTrimed(arr.registrarInfo.email),
                          () async {
                            await launch(
                              Uri(
                                scheme: 'mailto',
                                path: getTrimed(arr.registrarInfo.email),
                              ).toString(),
                            );
                          },
                        ),
                        SizedBox(height: 48),
                        Center(child: Text('Analysis', style: subtitle1White)),
                        SizedBox(height: 40),
                        text('Revenue (Cr)'),
                        SizedBox(height: 22),
                        column4(
                          'FY17',
                          'FY 18',
                          'FY 19',
                          'FY 20',
                          arr.analysis.revenueInfo.fy17 != null
                              ? arr.analysis.revenueInfo.fy17 == 'no data'
                                  ? 'TBA'
                                  : arr.analysis.revenueInfo.fy17
                              : '-',
                          arr.analysis.revenueInfo.fy18 != null
                              ? arr.analysis.revenueInfo.fy18 == 'no data'
                                  ? 'TBA'
                                  : arr.analysis.revenueInfo.fy18
                              : '-',
                          arr.analysis.revenueInfo.fy19 != null
                              ? arr.analysis.revenueInfo.fy19 == 'no data'
                                  ? 'TBA'
                                  : arr.analysis.revenueInfo.fy19
                              : '-',
                          arr.analysis.revenueInfo.fy20 != null
                              ? arr.analysis.revenueInfo.fy20 == 'no data'
                                  ? 'TBA'
                                  : arr.analysis.revenueInfo.fy20
                              : '-',
                        ),
                        SizedBox(height: 38),
                        text('Net Profit (Cr)'),
                        SizedBox(height: 22),
                        column4(
                          'FY17',
                          'FY 18',
                          'FY 19',
                          'FY 20',
                          arr.analysis.profitInfo.fy17 != null
                              ? arr.analysis.profitInfo.fy17 == 'no data'
                                  ? 'TBA'
                                  : arr.analysis.profitInfo.fy17
                              : '-',
                          arr.analysis.profitInfo.fy18 != null
                              ? arr.analysis.profitInfo.fy18 == 'no data'
                                  ? 'TBA'
                                  : arr.analysis.profitInfo.fy18
                              : '-',
                          arr.analysis.profitInfo.fy19 != null
                              ? arr.analysis.profitInfo.fy19 == 'no data'
                                  ? 'TBA'
                                  : arr.analysis.profitInfo.fy19
                              : '-',
                          arr.analysis.profitInfo.fy20 != null
                              ? arr.analysis.profitInfo.fy20 == 'no data'
                                  ? 'TBA'
                                  : arr.analysis.profitInfo.fy20
                              : '-',
                          color1: arr.analysis.profitInfo.fy17[0] == 'n'
                              ? white
                              : arr.analysis.profitInfo.fy17[1] == '-'
                                  ? red
                                  : blue,
                          color2: arr.analysis.profitInfo.fy18[0] == 'n'
                              ? white
                              : arr.analysis.profitInfo.fy18[1] == '-'
                                  ? red
                                  : blue,
                          color3: arr.analysis.profitInfo.fy19[0] == 'n'
                              ? white
                              : arr.analysis.profitInfo.fy19[1] == '-'
                                  ? red
                                  : blue,
                          color4: arr.analysis.profitInfo.fy20[0] == 'n'
                              ? white
                              : arr.analysis.profitInfo.fy20[1] == '-'
                                  ? red
                                  : blue,
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }

  Widget column(String a, String b, String c, String d, {Color color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 2 - 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(a, style: bodyText2White60),
                Text(b,
                    style: color != null
                        ? bodyText2.copyWith(color: color)
                        : bodyText2White),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 2 - 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(c, textAlign: TextAlign.right, style: bodyText2White60),
                Text(d,
                    textAlign: TextAlign.right,
                    style: color != null
                        ? bodyText2.copyWith(color: color)
                        : bodyText2White),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget column1(String a, String b, String c, String d) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 0.35,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  a,
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 12,
                  ),
                ),
                Text(
                  b,
                  style: TextStyle(
                      color: blue, fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          Container(
            width: 0.35,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  c,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 12,
                  ),
                ),
                Text(
                  d,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      color: blue, fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row column4(String a, String b, String c, String d, String e, String f,
      String g, String h,
      {Color color1, Color color2, Color color3, Color color4}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(a ?? "", style: bodyText2White60),
            Text(e ?? "",
                style: color1 != null
                    ? bodyText2.copyWith(color: color1)
                    : bodyText2White),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(b ?? "", textAlign: TextAlign.center, style: bodyText2White60),
            Text(f ?? "",
                textAlign: TextAlign.center,
                style: color2 != null
                    ? bodyText2.copyWith(color: color2)
                    : bodyText2White),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(c ?? "", textAlign: TextAlign.center, style: bodyText2White60),
            Text(g ?? "",
                textAlign: TextAlign.center,
                style: color3 != null
                    ? bodyText2.copyWith(color: color3)
                    : bodyText2White),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(d ?? "", textAlign: TextAlign.right, style: bodyText2White60),
            Text(h ?? "",
                textAlign: TextAlign.right,
                style: color4 != null
                    ? bodyText2.copyWith(color: color4)
                    : bodyText2White),
          ],
        ),
      ],
    );
  }

  Widget text(String s) {
    return Text(s ?? "", style: subtitle2White);
  }

  Widget text1(String s) {
    return Text(s ?? "", style: bodyText2White);
  }

  Widget text2(String s) {
    return Text(s ?? "", style: bodyText2White60);
  }

  Widget text3(String s, Function onTap) {
    return GestureDetector(
      child: Text(s ?? "",
          style: bodyText2White.copyWith(
              color: blue, decoration: TextDecoration.underline)),
      onTap: onTap,
    );
  }

  String getTrimed(String s) {
    return s != null ? s.trim() : '-';
  }
}

class IPO2 extends StatefulWidget {
  @override
  _IPO2State createState() => _IPO2State();
}

class _IPO2State extends State<IPO2> {
  bool _loading = true;
  List<Ipo2> listed;
  List<Ipo2> ongoing;
  List<UpcomingIpo2> upcoming;

  // IpoIndividualModel ipoIndividualresults;
  void getIpoList() async {
    listed = await IpoServices2.getListedIpo();
    ongoing = await IpoServices2.getOngoing();
    upcoming = await IpoServices2.getUpcoming();

    // ipoIndividualresults = await IpoServices.getIpoIndiResults(query);
    setState(() {
      _loading = false;
    });
    _refreshController.refreshCompleted();
  }

  @override
  void initState() {
    super.initState();
    getIpoList();
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        initialIndex: 1,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(106),
            child: Column(
              children: [
                AppBarWithBack(
                  text: 'IPO',
                ),
                TabBar(
                  labelStyle: buttonWhite,
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
                      text: "Past",
                    ),
                    Tab(
                      text: "Current",
                    ),
                    Tab(
                      text: "Upcoming",
                    ),
                  ],
                ),
              ],
            ),
          ),
          body: _loading
              ? LoadingPage()
              : listed == null
                  ? NoDataAvailablePage()
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                      child: TabBarView(
                        children: [
                          SmartRefresher(
                            controller: _refreshController,
                            enablePullDown: true,
                            enablePullUp: false,
                            header: ClassicHeader(
                              completeIcon:
                                  Icon(Icons.done, color: Colors.white60),
                              refreshingIcon: SizedBox(
                                width: 25,
                                height: 25,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.0,
                                  color: Colors.white60,
                                ),
                              ),
                            ),
                            onRefresh: () => getIpoList(),
                            child: ListView.builder(
                                itemBuilder: (c, i) => ipo(
                                      context,
                                      listed[i].id,
                                      listed[i].securityName ?? "",
                                      listed[i].openDate ?? "",
                                      listed[i].closeDate ?? "",
                                      listed[i].issuePrice ?? "",
                                    ),
                                itemCount: listed.length ?? 0),
                          ),
                          SmartRefresher(
                              controller: _refreshController,
                              enablePullDown: true,
                              enablePullUp: false,
                              header: ClassicHeader(
                                completeIcon:
                                    Icon(Icons.done, color: Colors.white60),
                                refreshingIcon: SizedBox(
                                  width: 25,
                                  height: 25,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.0,
                                    color: Colors.white60,
                                  ),
                                ),
                              ),
                              onRefresh: () => getIpoList(),
                              child: ListView.builder(
                                  itemBuilder: (c, i) => ipo(
                                        context,
                                        ongoing[i].id,
                                        ongoing[i].securityName ?? "",
                                        ongoing[i].openDate ?? "",
                                        ongoing[i].closeDate ?? "",
                                        (ongoing[i].issuePriceMin ?? "") +
                                            "-" +
                                            (ongoing[i].issuePriceMax ?? ""),
                                      ),
                                  itemCount: ongoing.length ?? 0)),
                          SmartRefresher(
                              controller: _refreshController,
                              enablePullDown: true,
                              enablePullUp: false,
                              header: ClassicHeader(
                                completeIcon:
                                    Icon(Icons.done, color: Colors.white60),
                                refreshingIcon: SizedBox(
                                  width: 25,
                                  height: 25,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.0,
                                    color: Colors.white60,
                                  ),
                                ),
                              ),
                              onRefresh: () => getIpoList(),
                              child: ListView.builder(
                                  itemBuilder: (c, i) => ipo(
                                        context,
                                        upcoming[i].id,
                                        upcoming[i].securityName ?? "",
                                        upcoming[i].openDate ?? "",
                                        upcoming[i].closeDate ?? "",
                                        (upcoming[i].issuePriceMin ?? "") +
                                            "-" +
                                            (upcoming[i].issuePriceMax ?? ""),
                                      ),
                                  itemCount: upcoming.length ?? 0)
                              // ListView.builder(
                              //     itemBuilder: (c, i) => ipoUpcoming(
                              //           context,
                              //           ipolist[0]
                              //                   ?.data
                              //                   ?.upcoming[i]
                              //                   .companyName ??
                              //               "",
                              //           ipolist[0].data.upcoming[i].ipoSize ?? "",
                              //           ipolist[0]
                              //                   .data
                              //                   .upcoming[i]
                              //                   .tentativeDates ??
                              //               "",
                              //         ),
                              //     itemCount:
                              //         ipolist[0].data.upcoming.length ?? 0),
                              ),
                        ],
                      ),
                    ),
        ));
  }

  Widget ipo(BuildContext context, int id, String name, String opendate,
      String closedate, String priceband) {
    return InkWell(
      onTap: () {
        pushNewScreen(context, screen: IPOIndividual2(id: id));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: darkGrey,
        ),
        child: Column(
          children: [
            Text(name ?? "", style: subtitle1White),
            SizedBox(height: 10),
            opendate == null || closedate == null
                ? Text("-", style: subtitle2White)
                : Text(
                    formatDate(opendate.split("T")[0]) +
                        ' - ' +
                        formatDate(closedate.split("T")[0]),
                    style: subtitle2White),
            Text('(Issue Date)', style: captionWhite60),
            SizedBox(height: 13),
            rows(
                'Offer Price',
                '₹ ' +
                    (priceband == null || priceband == "null-null"
                        ? "N/A"
                        : priceband.toString())),
            // rows('Min Lot Size', lotsize.toString() ?? ""),
            // rows('IPO Size (approx)', '₹ ' + iposize.toString() ?? ""),
          ],
          crossAxisAlignment: CrossAxisAlignment.center,
        ),
      ),
    );
  }

  Widget ipoUpcoming(
      BuildContext context, String name, String iposize, String date) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: darkGrey,
      ),
      child: Column(
        children: [
          Text(name ?? "", style: subtitle1White),
          SizedBox(height: 10),
          Text(date ?? "", style: subtitle2White),
          Text('(tentative date)', style: captionWhite60),
          SizedBox(height: 13),
          rows('IPO Size (approx)', '₹ ' + iposize ?? ""),
        ],
        crossAxisAlignment: CrossAxisAlignment.center,
      ),
    );
  }
}

formatDate(String date) {
  int m = int.parse(date.split("-")[1]);
  String d = date.split("-")[2];
  List<String> mons = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];
  return mons[m - 1].toString() + " " + d;
}

Widget rows(String s, String d) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(s, textAlign: TextAlign.left, style: captionWhite60),
        Text(d, textAlign: TextAlign.right, style: captionWhite)
      ],
    ),
  );
}

class IPOIndividual2 extends StatefulWidget {
  final int id;

  IPOIndividual2({Key key, this.id}) : super(key: key);

  @override
  _IPOIndividual2State createState() => _IPOIndividual2State();
}

format(String n) {
  // String r = "";
  // int c = 0;
  // for (int i = n.lastIndexOf('.') - 1; i >= 0; i--) {
  //   c++;
  //   r = n[i] + r;
  //   if (c % 3 == 0) {
  //     r += ',';
  //   }
  // }
  // r += n.split("");
  return Numeral(double.parse(n)).value();
}

class _IPOIndividual2State extends State<IPOIndividual2> {
  bool _loading = true;
  Map<String, dynamic> ipoDetails;
  Map<String, dynamic> ipoSubs;
  Map<String, dynamic> ipoProms;
  void _getData() async {
    try {
      ipoDetails = await IpoServices2.getIPODetails(widget.id);
      ipoSubs = await IpoServices2.getIPOSubscription(widget.id);
      ipoProms = await IpoServices2.getIPOPromoters(widget.id);
    } catch (e) {}
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    print(widget.id);
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWithBack(
          text: "IPO",
        ),
        body: _loading
            ? LoadingPage()
            : ipoDetails == null
                ? NoDataAvailablePage()
                : DefaultTabController(
                    length: ipoSubs == null ? 2 : 3,
                    initialIndex: 0,
                    child: Column(
                      children: [
                        Material(
                          color: Colors.black,
                          child: Column(children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: TabBar(
                                labelStyle: buttonWhite,
                                unselectedLabelColor: white38,
                                indicator: MaterialIndicator(
                                  horizontalPadding: 30,
                                  bottomLeftRadius: 8,
                                  bottomRightRadius: 8,
                                  color: Colors.white.withOpacity(0.87),
                                  paintingStyle: PaintingStyle.fill,
                                ),
                                tabs: [
                                  Tab(
                                    text: "Details",
                                  ),
                                  if (ipoSubs != null)
                                    Tab(
                                      text: "Subscription",
                                    ),
                                  Tab(
                                    text: "Promoters",
                                  ),
                                ],
                              ),
                            ),
                          ]),
                        ),
                        Expanded(
                          child: TabBarView(children: [
                            ListView(
                                padding: const EdgeInsets.all(8.0),
                                children: [
                                  Center(
                                      child: Text(
                                    "Overview",
                                    style: headline6,
                                  )),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  row(
                                      "Company Name",
                                      (ipoDetails["SecurityName"] ?? "--")
                                          .toString()),
                                  row(
                                      "Sector",
                                      (ipoDetails["SectorName"] ?? "--")
                                          .toString()),
                                  row(
                                      "Industry",
                                      (ipoDetails["IndustryName"] ?? "--")
                                          .toString()),
                                  Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 6),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                "Website",
                                                textAlign: TextAlign.left,
                                                style: bodyText2White60,
                                              ),
                                            ),
                                            Flexible(
                                              child: TextButton(
                                                  child: Text(
                                                    ipoDetails["Website"] ??
                                                        "N/A",
                                                    textAlign: TextAlign.right,
                                                  ),
                                                  onPressed: () async {
                                                    if (await canLaunch(
                                                        ipoDetails[
                                                            "Website"])) {
                                                      await launch(ipoDetails[
                                                          "Website"]);
                                                    } else {
                                                      BotToast.showText(
                                                          text:
                                                              "Could not launch url");
                                                      throw 'Could not launch ${ipoDetails["Website"]}';
                                                    }
                                                  }),
                                            )
                                          ])),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Center(
                                      child: Text(
                                    "Offer Details",
                                    style: headline6,
                                  )),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  row(
                                      "Issue Type",
                                      (ipoDetails == null
                                              ? '--'
                                              : ipoDetails["IssueType"] ?? "--")
                                          .toString()),
                                  row(
                                      "Offer Price (₹)",
                                      (ipoDetails == null
                                              ? '--'
                                              : (ipoDetails["IssuePriceMin"] == null
                                                  ? "N/A"
                                                  : format(ipoDetails[
                                                              "IssuePriceMin"]
                                                          .toString())) + (ipoDetails["IssuePriceMax"] == null
                                                  ? ""
                                                  :(" - "+ ( format(ipoDetails[
                                                              "IssuePriceMax"]
                                                          .toString()))))
                                                      )
                                          .toString()),
                                  row(
                                      "Open Date",
                                      (ipoDetails == null
                                          ? '--'
                                          : ipoDetails["OpenDate"] == null
                                              ? "--"
                                              : formatDate(
                                                      ipoDetails["OpenDate"])
                                                  .toString()
                                                  .split("T")[0])),
                                  row(
                                      "Close Date",
                                      (ipoDetails == null
                                          ? '--'
                                          : ipoDetails["CloseDate"] == null
                                              ? "--"
                                              : formatDate(
                                                      ipoDetails["CloseDate"])
                                                  .toString()
                                                  .split("T")[0])),
                                  row(
                                      "Issue Size (Rs. Cr.)",
                                      (ipoDetails == null
                                              ? '--'
                                              : (ipoDetails["IssueSizeMin"] == null
                                                  ? "N/A"
                                                  : format(ipoDetails[
                                                              "IssueSizeMin"]
                                                          .toString())) + (ipoDetails["IssueSizeMax"] == null
                                                  ? ""
                                                  :(" - "+ ( format(ipoDetails[
                                                              "IssueSizeMax"]
                                                          .toString()))))
                                                      )
                                          .toString()),
                                  row(
                                      "Min Application (Share)",
                                      (ipoDetails == null
                                              ? '--'
                                              : ipoDetails["MinApplication"] ==
                                                      null
                                                  ? "--"
                                                  : format(ipoDetails[
                                                          "MinApplication"]
                                                      .toString()))
                                          .toString()),
                                  row(
                                      "Max Retail",
                                      (ipoDetails == null
                                              ? '--'
                                              : ipoDetails[
                                                          "MaxRetailSubscription"] ==
                                                      null
                                                  ? "--"
                                                  : format(ipoDetails[
                                                          "MaxRetailSubscription"]
                                                      .toString()))
                                          .toString()),
                                  row(
                                      "Face Value",
                                      (ipoDetails == null
                                              ? '--'
                                              : ipoDetails["FaceValue"] == null
                                                  ? "--"
                                                  : format(
                                                      ipoDetails["FaceValue"]
                                                          .toString()))
                                          .toString()),
                                  row(
                                      "No. of Shares Offered",
                                      (ipoDetails == null
                                              ? '--'
                                              : ipoDetails["TotalEquity"] ==
                                                      null
                                                  ? "-"
                                                  : format(
                                                      ipoDetails["TotalEquity"]
                                                          .toString()))
                                          .toString()),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Center(
                                      child: Text(
                                    "Listing Details",
                                    style: headline6,
                                  )),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  row(
                                      "Listing Date",
                                      (ipoDetails == null
                                              ? '--'
                                              : ipoDetails["ListingDate"] ??
                                                  "--")
                                          .toString()
                                          .split("T")[0]),
                                  row(
                                      "Listing Price",
                                      (ipoDetails == null
                                              ? '--'
                                              : ipoDetails["ListPrice"] ?? "--")
                                          .toString()),
                                  row(
                                      "Listing In",
                                      (ipoDetails == null
                                              ? '--'
                                              : ipoDetails["IPOListings"][0]
                                                      ["StockExchangeName"] ??
                                                  "--")
                                          .toString()),
                                ]),
                            if (ipoSubs != null)
                              ListView(padding: EdgeInsets.all(16), children: [
                                column(
                                    "Type",
                                    "Non-Institutional Investor (NII)",
                                    "Shares Bid",
                                    ipoSubs == null
                                        ? "-"
                                        : (ipoSubs["NII_NosBidFor"] ?? "--")
                                            .toString()),
                                column(
                                    "Type",
                                    "Retail Individual Investor (RII)",
                                    "Shares Bid",
                                    ipoSubs == null
                                        ? "-"
                                        : (ipoSubs["RII_NosBidFor"] ?? "--")
                                            .toString()),
                                SizedBox(
                                  height: 10,
                                ),
                                row(
                                    "Grand Total",
                                    ipoSubs == null
                                        ? "-"
                                        : (ipoSubs["Total_NosBidFor"] ?? "--")
                                            .toString())
                              ]),
                            ListView(
                              padding: EdgeInsets.all(10),
                              children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Center(
                                        child: Text(
                                      " Promoter Shareholding ",
                                      style: headline6,
                                    )),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    row(
                                        "Promoter Holding Pre IPO",
                                        ((ipoProms == null
                                                ? "--"
                                                : ipoProms["PrePromoterHolding"] ==
                                                        null
                                                    ? "--"
                                                    : format(ipoProms[
                                                            "PrePromoterHolding"]
                                                        .toString()))
                                            .toString())),
                                    row(
                                        "Promoter Holding Post IPO",
                                        (ipoProms == null
                                                ? "--"
                                                : ipoProms["PostPromoterHolding"] ==
                                                        null
                                                    ? "--"
                                                    : format(ipoProms[
                                                            "PostPromoterHolding"]
                                                        .toString()))
                                            .toString()),
                                    row(
                                        "No.of Shares Pre IPO",
                                        (ipoProms == null
                                                ? "--"
                                                : ipoProms["PreShareCapital"] ==
                                                        null
                                                    ? "--"
                                                    : format(ipoProms[
                                                            "PreShareCapital"]
                                                        .toString()))
                                            .toString()),
                                    row(
                                        "No.of Shares Post IPO",
                                        (ipoProms == null
                                                ? "--"
                                                : ipoProms["PostShareCapital"] ==
                                                        null
                                                    ? "--"
                                                    : format(ipoProms[
                                                            "PostShareCapital"]
                                                        .toString()))
                                            .toString()),
                                    row(
                                        "Shares Offered To Public",
                                        (ipoProms == null
                                                ? "--"
                                                : ipoProms["OfferToPublic"] ==
                                                        null
                                                    ? "--"
                                                    : format(ipoProms[
                                                            "OfferToPublic"]
                                                        .toString()))
                                            .toString()),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Center(
                                        child: Text(
                                      " Promoters ",
                                      style: headline6,
                                    )),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ] +
                                  (ipoProms == null
                                      ? []
                                      : ipoProms["Promoters"] == null
                                          ? [Text("")].cast<Widget>()
                                          : List.generate(
                                              ipoProms["Promoters"].length,
                                              (index) => Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                        ipoProms["Promoters"]
                                                                [index]["Name"]
                                                            .toString()),
                                                  )).toList().cast<Widget>()),
                            )
                          ]),
                        ),
                      ],
                    ),
                  ));
  }

  Widget row(String param, String val) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 6),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  param,
                  textAlign: TextAlign.left,
                  style: bodyText2White60,
                ),
              ),
              Flexible(
                child: Text(
                  val,
                  textAlign: TextAlign.right,
                  style: bodyText2White,
                ),
              )
            ]));
  }

  Widget column(String a, String b, String c, String d, {Color color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 2 - 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(a, style: bodyText2White60),
                Text(b,
                    style: color != null
                        ? bodyText2.copyWith(color: color)
                        : bodyText2White),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 2 - 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(c, textAlign: TextAlign.right, style: bodyText2White60),
                Text(d,
                    textAlign: TextAlign.right,
                    style: color != null
                        ? bodyText2.copyWith(color: color)
                        : bodyText2White),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget column1(String a, String b, String c, String d) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 0.35,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  a,
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 12,
                  ),
                ),
                Text(
                  b,
                  style: TextStyle(
                      color: blue, fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          Container(
            width: 0.35,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  c,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 12,
                  ),
                ),
                Text(
                  d,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      color: blue, fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row column4(String a, String b, String c, String d, String e, String f,
      String g, String h,
      {Color color1, Color color2, Color color3, Color color4}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(a ?? "", style: bodyText2White60),
            Text(e ?? "",
                style: color1 != null
                    ? bodyText2.copyWith(color: color1)
                    : bodyText2White),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(b ?? "", textAlign: TextAlign.center, style: bodyText2White60),
            Text(f ?? "",
                textAlign: TextAlign.center,
                style: color2 != null
                    ? bodyText2.copyWith(color: color2)
                    : bodyText2White),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(c ?? "", textAlign: TextAlign.center, style: bodyText2White60),
            Text(g ?? "",
                textAlign: TextAlign.center,
                style: color3 != null
                    ? bodyText2.copyWith(color: color3)
                    : bodyText2White),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(d ?? "", textAlign: TextAlign.right, style: bodyText2White60),
            Text(h ?? "",
                textAlign: TextAlign.right,
                style: color4 != null
                    ? bodyText2.copyWith(color: color4)
                    : bodyText2White),
          ],
        ),
      ],
    );
  }

  Widget text(String s) {
    return Text(s ?? "", style: subtitle2White);
  }

  Widget text1(String s) {
    return Text(s ?? "", style: bodyText2White);
  }

  Widget text2(String s) {
    return Text(s ?? "", style: bodyText2White60);
  }

  Widget text3(String s, Function onTap) {
    return GestureDetector(
      child: Text(s ?? "",
          style: bodyText2White.copyWith(
              color: blue, decoration: TextDecoration.underline)),
      onTap: onTap,
    );
  }

  String getTrimed(String s) {
    return s != null ? s.trim() : '-';
  }
}
