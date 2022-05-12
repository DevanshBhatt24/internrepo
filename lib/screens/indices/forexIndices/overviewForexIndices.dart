import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../styles.dart';
import '../../../widgets/item.dart';

class OverviewForexIndices extends StatefulWidget {
  OverviewForexIndices({Key key}) : super(key: key);

  @override
  _OverviewForexIndicesState createState() => _OverviewForexIndicesState();
}

class _OverviewForexIndicesState extends State<OverviewForexIndices> {
  List<Widget> list = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(CupertinoIcons.back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          Icon(
            Icons.bookmark_border,
            //size: 32,
          ),
          SizedBox(
            width: 18,
          ),
          Icon(
            Icons.share_outlined,
            //size: 32,
          ),
          SizedBox(
            width: 18,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 76),
              Text('DXY ', textAlign: TextAlign.center, style: headline4White),
              SizedBox(height: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      height: 12,
                      width: 18,
                      child: Image.asset('icons/flags/png/us.png',
                          package: 'country_icons')),
                  Text(" " + 'U.S Dollar Currency Index', style: captionWhite60)
                ],
              ),
              SizedBox(height: 48),
              Text("11,686.59", style: headline5White),
              Text("+6.59 (+0.59%)",
                  style: bodyText2AnyColour.copyWith(color: blue)),
              SizedBox(height: 32),
              RowItem("Previous", "27,785.42"),
              RowItem("Open", "4.2%"),
              RowItem("Day's Range", "3.6%"),
              SizedBox(height: 40),
              Text('Weightage', style: bodyText1white),
              SizedBox(height: 27),
              RowItem(
                "Euro (EUR)",
                "27,785.42",
              ),
              RowItem(
                "Japanese yen (JPY)",
                "27,382.94 - 29,568.56",
              ),
              RowItem(
                "Pound sterling (GBP)",
                "57.6%",
              ),
              RowItem(
                "Canadian dollar (CAD)",
                "13.6%",
              ),
              RowItem(
                "Swedish krona (SEK)",
                "11.9%",
              ),
              RowItem(
                "Swiss franc (CHF)",
                "9.1%",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
