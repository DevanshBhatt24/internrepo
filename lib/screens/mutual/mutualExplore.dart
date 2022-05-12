import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_screenutil/size_extension.dart';
import 'package:rating_bar/rating_bar.dart';
import 'package:technical_ind/components/explorePage.dart';
import 'package:technical_ind/screens/cryptocurrency/newsPage.dart';
import 'package:technical_ind/screens/etf/business/models/etf_explore_model.dart';
import 'package:technical_ind/screens/mutual/business/fundsservices.dart';
import 'package:technical_ind/screens/mutual/peers.dart';
import 'package:technical_ind/screens/mutual/summary.dart';
import 'package:technical_ind/screens/search/business/model.dart';
import 'package:technical_ind/styles.dart';

import 'analysis.dart';
import 'info.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

class CustomEnd extends StatelessWidget {
  CustomEnd({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(
                'Direct - Growth',
                textAlign: TextAlign.center,
                style: subtitle1White60,
              ),
              Text('54.39', textAlign: TextAlign.center, style: headline5White),
              Text('-0.65 (-0.63%)',
                  textAlign: TextAlign.center,
                  style: bodyText2.copyWith(color: red))
            ],
          ),
          Container(
            width: 4,
            height: 87,
            color: Color(0xffffffff).withOpacity(0.12),
          ),
          Column(
            children: <Widget>[
              Text('Regular - Growth',
                  textAlign: TextAlign.center, style: subtitle1White60),
              Text(
                '54.39',
                textAlign: TextAlign.center,
                style: headline5White,
              ),
              Text(
                '-0.65 (-0.63%)',
                textAlign: TextAlign.center,
                style: bodyText2.copyWith(color: red),
              )
            ],
          )
        ],
      ),
    );
  }
}

class Customratingbar extends StatelessWidget {
  final rating;
  const Customratingbar({Key key, this.rating}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 12,
        ),
        Text('International',
            textAlign: TextAlign.center, style: captionWhite60),
        SizedBox(
          height: 14,
        ),
        RatingBar.readOnly(
          initialRating: 4,
          isHalfAllowed: true,
          halfFilledIcon: Icons.star_half,
          filledIcon: Icons.star,
          emptyIcon: Icons.star_border,
          filledColor: almostWhite,
          emptyColor: almostWhite,
          size: 25,
        ),
      ],
    );
  }
}

class MutualExplore extends StatefulWidget {
  final String title;
  final String rating;
  final int code;
  final latestnav;
  final bool isSearch;
  MutualExplore(
      {Key key,
      this.isSearch = false,
      this.code,
      this.title,
      this.rating,
      this.latestnav})
      : super(key: key);

  @override
  _MutualExploreState createState() => _MutualExploreState();
}

class _MutualExploreState extends State<MutualExplore> {
  List<String> exploremenu = [
    "Summary",
    "Peers",
    // "Funds vs Peers",
    "Fund Information",
    // "Charts",
    "News"
  ];

  List<Widget> exploreMenuWidgets = [];

  String searchTitle = "";
  String searchLatestNav = "";

  MutualFund mutualFundDetails;
  MutualPriceDetails mutualFundPriceDetails;

  var jsonText;
  List<FundEtfSearch> fundsEtf;
  bool loading = false;

  _loadData() async {
    jsonText = await rootBundle.loadString('assets/instrument/fundsEtf.json');
    print("done");
    setState(() {
      fundsEtf = fundEtfSearchFromJson(jsonText);
      loading = true;
    });
  }

  String _mfcode;

  _fetchapi() async {
    final response = await http.get(Uri.parse(
        'https://api.bottomstreet.com/mutualfund/histroricalgraph?amc=${widget.title}'));
    final data = json.decode(response.body);
    // await _loadData();

    // final code = widget.title.replaceAll(" ", "-").toLowerCase();
    // print(code);
    print(fundsEtf);
    String mfcode = widget.title.replaceAll(" ", "-").toLowerCase();
    // for (var i in fundsEtf) {
    //   if (i.field3 == widget.code) {
    //     mfcode = i.fundName;
    //   }
    // }
    setState(() {
      _mfcode = mfcode;
    });
    mutualFundDetails = await FundsService.fundDetails(mfcode);
    mutualFundPriceDetails = await FundsService.fundPriceDetails(mfcode);
    print(mutualFundDetails);
    setState(() {
      searchTitle = data["meta"]["scheme_name"];
      searchLatestNav = data["data"][0]["nav"];
      exploreMenuWidgets = [
        Summary(
          title: searchTitle,
          latestNav: searchLatestNav,
        ),
        PeersMutualFunds(
            fundvspeer: mutualFundDetails.peerComparison,
            latestNav: searchLatestNav,
            mutualFundPriceDetails: mutualFundPriceDetails,
            title: searchTitle),
        // PortFolioMutual(),
        FundsInformation(
            about: mutualFundDetails.about,
            latestNav: widget.latestnav.toString(),
            mutualFundPriceDetails: mutualFundPriceDetails,
            title: widget.title),
        Analysis(),
        NewsPage(),
      ];
      loading = true;
    });
  }

  _fetchDetails() async {
    await _loadData();

    String mfcode;
    for (var i in fundsEtf) {
      if (i.field3 == widget.code) {
        mfcode = i.fundName;
      }
    }
    print(mfcode);
    mutualFundDetails = await FundsService.fundDetails(mfcode);
    mutualFundPriceDetails = await FundsService.fundPriceDetails(mfcode);
    print(mutualFundDetails);
    setState(() {
      _mfcode = mfcode;
      exploreMenuWidgets = [
        Summary(
          title: widget.title,
          latestNav: widget.latestnav.toString(),
          mfcode: mfcode,
        ),
        // PortFolioMutual(),
        PeersMutualFunds(
            fundvspeer: mutualFundDetails.peerComparison,
            latestNav: widget.latestnav.toString(),
            mutualFundPriceDetails: mutualFundPriceDetails,
            title: widget.title),
        FundsInformation(
            about: mutualFundDetails.about,
            latestNav: widget.latestnav.toString(),
            mutualFundPriceDetails: mutualFundPriceDetails,
            title: widget.title),
        Analysis(),
        NewsPage(),
      ];
      loading = true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    if (widget.isSearch == true) {
      _fetchapi();
    } else {
      _fetchDetails();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ExplorePage(
      code: _mfcode,
      explorerLoading: loading,
      mutualFundDetails: mutualFundDetails,
      title: widget.isSearch == false ? widget.title : searchTitle,
      mid: widget.rating != "unrated"
          ? RatingBar.readOnly(
              initialRating: double.parse(widget.rating),
              isHalfAllowed: true,
              halfFilledIcon: Icons.star_half,
              filledIcon: Icons.star,
              emptyIcon: Icons.star_border,
              filledColor: almostWhite,
              emptyColor: almostWhite,
              size: 20,
            )
          : SizedBox(),
      end: widget.isSearch == false
          ? Column(
              children: [
                // Text("Latest Nav", style: captionWhite),
                // Text('${widget.latestnav}', style: bodyText1white),
              ],
            )
          : Column(
              children: [
                // Text("Latest Nav", style: captionWhite),
                // Text(searchLatestNav, style: bodyText1white),
              ],
            ),
      menu: exploremenu,
      menuWidgets: exploreMenuWidgets,
      defaultheight: 110,
    );
  }
}
