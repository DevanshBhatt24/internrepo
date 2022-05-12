import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../styles.dart';
import '../../widgets/appbar_with_back_and_search.dart';
import '../../widgets/miss.dart';

class HolidaysPage extends StatelessWidget {
  const HolidaysPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(108),
        child: Column(
          children: [
            AppBarWithBack(
              haveSearch: false,
              text: "Market Holidays",
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: TableBar(
                title1: "Holidays",
                title2: "Day/Date",
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            SizedBox(height: 9),

            buildListItem("Republic Day", '26 Jan 2022', 'Wednesday'),
            buildListItem("Mahashivratri", '1 Mar 2022', 'Tuesday'),
            buildListItem("Holi", '18 Mar 2022', 'Friday'),
            buildListItem("Dr.Baba Saheb \nAmbedkar Jayanti", '14 April 2022','Thursday'),
            buildListItem("Good Friday", '15 April 2022', 'Friday'),
            buildListItem("Id-Ul-Fitr (Ramzan Id)", '03 May 2022', 'Tuesday'),
            buildListItem("Muharram", '09 Aug 2022', 'Tuesday'),
            buildListItem('Independence  Day', '15 Aug 2022', 'Monday'),
            buildListItem("Ganesh Chaturthi", '31 Aug 2022', 'Wednesday'),
            buildListItem("Dussehra", '05 Oct 2022', 'Wednesday'),
            buildListItem("Diwali * Laxmi Pujan", '24 Oct 2022', 'Monday'),
            buildListItem("Diwali Balipratipada", '26 Oct 2022', 'Wednesday'),
            buildListItem("Gurunanak Jayanti", '08 Nov 2022', 'Tuesday'),

            SizedBox(height: 32),
            Center(
              child: Text(
                  'Following Holidays are Falling on \nSaturday / Sunday',
                  style: subtitle1White,
                  textAlign: TextAlign.center),
            ),

            SizedBox(height: 22),
            buildListItem("New Year Day", '01 Jan 2022', 'Saturday'),
            buildListItem("Ram Navami", '10 April 2022', 'Sunday'),
            buildListItem("Maharashtra Day", '01 May 2022', 'Sunday'),
            buildListItem("Bakri Id", '10 Jul 2022', 'Sunday'),
            buildListItem("Mahatma Gandhi Jayanti", '02 Oct 2022', 'Sunday'),
            buildListItem("Christmas", '25 Dec 2021', 'Sunday'),
            SizedBox(height: 32),
            Text(
                ' Muhurat Trading will be held on Monday, October 24,2022.',
                style: subtitle2White),
            SizedBox(height: 14),
            // Text(
            //     'The Exchange may alter / change any of the above \nholidays, for which a separate circular shall be \nissued in advance.',
            //     style: subtitle2White),
            // SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget buildListItem(String name, String date, String day) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 9, horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name, style: subtitle2White),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(date, style: subtitle2White),
              Text(day, style: subtitle2White),
            ],
          )
        ],
      ),
    );
  }
}
