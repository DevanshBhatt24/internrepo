import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rating_bar/rating_bar.dart';
import 'etfexplorepage.dart';
import '../../styles.dart';
import '../cryptocurrency/newsPage.dart';
import '../mutual/analysis.dart';
import '../mutual/info.dart';
import '../mutual/peers.dart';
import '../mutual/portfolio.dart';
import '../mutual/summary.dart';

class CustomEnd extends StatelessWidget {
  TextStyle style2 = TextStyle(
    fontSize: 28.sp,
    fontWeight: FontWeight.bold,
    color: almostWhite,
  );

  TextStyle style3 = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: red,
  );
  TextStyle style4 = TextStyle(
    fontSize: 16.sp,
    color: Color(0xffffffff).withOpacity(0.76),
  );
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
                style: style4,
              ),
              Text('54.39', textAlign: TextAlign.center, style: style2),
              Text('-0.65 (-0.63%)', textAlign: TextAlign.center, style: style3)
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
                  textAlign: TextAlign.center, style: style4),
              Text(
                '54.39',
                textAlign: TextAlign.center,
                style: style2,
              ),
              Text(
                '-0.65 (-0.63%)',
                textAlign: TextAlign.center,
                style: style3,
              )
            ],
          )
        ],
      ),
    );
  }
}

class Customratingbar extends StatelessWidget {
  const Customratingbar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'International',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14.sp,
            color: white60,
          ),
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

class EtfExplore extends StatefulWidget {
  final String name, id, percentchange, price;
  EtfExplore({
    Key key,
    this.id,
    this.name,
    this.percentchange,
    this.price,
  }) : super(key: key);

  @override
  _EtfExploreState createState() => _EtfExploreState();
}

class _EtfExploreState extends State<EtfExplore> {
  List<String> exploremenu = [
    "Summary",
    "Portfolio & Returns",
    "Funds vs Peers",
    "Fund Information",
    "Analysis",
    "News"
  ];

  List<Widget> exploreMenuWidgets = [
    Summary(),
    PortFolioMutual(),
    PeersMutualFunds(),
    FundsInformation(),
    Analysis(),
    NewsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return ExplorePageETF(
      defaultheight: 95,
      title: widget.name,
      mid: Column(
        children: [
          SizedBox(
            height: 12,
          ),
          Text('International',
              textAlign: TextAlign.center, style: bodyText2White60),
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
      ),
      end: Column(
        children: [
          Text(widget.price,
              textAlign: TextAlign.center, style: headline5White),
          Text(widget.percentchange,
              textAlign: TextAlign.center,
              style: bodyText2.copyWith(
                  color: widget.percentchange[0] == '-' ? red : blue)),
          // SizedBox(height: 60.h,)
        ],
      ),
      menu: exploremenu,
    );
  }
}
