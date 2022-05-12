import 'package:flutter/material.dart';

import '../../styles.dart';
import '../../widgets/appbar_with_back_and_search.dart';

class NewsWatchList extends StatelessWidget {
  const NewsWatchList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithBack(
        text: 'Watchlist',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: ListView.builder(
            itemCount: 15,
            itemBuilder: (context, i) {
              return Container(
                height: 90,
                padding: EdgeInsets.all(12),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Container(
                        height: 64,
                        width: 64,
                        child: Image.asset(
                          "images/download.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Sensex And Nifty Rise as Financials\nGain, Blue-chip Earnings In Focus",
                          style: subtitle2White,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "6 HOURS AGO",
                          style: overlineWhite60,
                        )
                      ],
                    ))
                  ],
                ),
              );
            }),
      ),
    );
  }
}
