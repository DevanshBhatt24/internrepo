import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:technical_ind/screens/News/NewsSearchPage.dart';
import 'package:technical_ind/screens/News/headlines.dart';
import 'package:technical_ind/screens/News/news_categories.dart';
// import 'package:intl/intl.dart';
import '../../styles.dart';
import 'business/model.dart';

class NewsFeed extends StatelessWidget {
  final List<News> news;

  const NewsFeed({this.news, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int currentNews = 0;
    PageController controller = PageController(initialPage: currentNews);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.animateToPage(0,
              duration: Duration(milliseconds: 2), curve: Curves.decelerate);
        },
        backgroundColor: blue,
        child: Icon(
          Icons.arrow_upward_sharp,
          color: Colors.white,
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
        child: PageView(
          onPageChanged: (x) {
            // print(x);
            currentNews = x;
          },
          controller: controller,
          scrollDirection: Axis.vertical,
          children: news.map((e) => NewsItem(data: e)).toList(),
        ),
      ),
      // body: SmartRefresher(
      //   controller: _refreshController,
      //   enablePullDown: true,
      //   enablePullUp: false,
      //   header: ClassicHeader(
      //     completeIcon: Icon(Icons.done, color: Colors.white60),
      //     refreshingIcon: SizedBox(
      //       width: 25,
      //       height: 25,
      //       child: CircularProgressIndicator(
      //         strokeWidth: 2.0,
      //         color: Colors.white60,
      //       ),
      //     ),
      //   ),
      //   onRefresh: getData,
      //   child: ListView.builder(
      //     itemCount: news.length,
      //     itemBuilder: (context,index) => NewsItem(data: news[index],),
      //   ),
      //   // child: NewsFeed(
      //   //   news: news,
      //   // ),
      // ),
    );
  }
}

class NewsItem extends StatelessWidget {
  final News data;
  NewsItem({Key key, this.data}) : super(key: key);
  final months = {
    1: 'Jan',
    2: 'Feb',
    3: 'Mar',
    4: 'Apr',
    5: 'May',
    6: 'Jun',
    7: 'Jul',
    8: 'Aug',
    9: 'Sep',
    10: 'Oct',
    11: 'Nov',
    12: 'Dec'
  };

  @override
  Widget build(BuildContext context) {
    // DateTime d = DateTime.parse(data.createdAt);
    DateTime d = DateTime.fromMillisecondsSinceEpoch(
        int.parse(data.createdAt_unix) * 1000);
    // Duration duration = new Duration(hours: 5, minutes: 30);
    // d = d.add(duration);
    DateTime tempDate = DateFormat("hh:mm")
        .parse(d.hour.toString() + ":" + d.minute.toString());
    var dateFormat = DateFormat("h:mm a").format(tempDate);
    // print(d.millisecondsSinceEpoch / 1000);
    return Container(
      height: MediaQuery.of(context).size.height * 1.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: NetworkImage(
                      data.bannerLink.toString(),
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Wrap(
                //     alignment: WrapAlignment.start,
                //     children: data.companies.length>2? data.companies.sublist(0,2)
                //         .map((e) => Text('# ${e["name"]}   ',
                //         style: TextStyle(color: Colors.blue)))
                //         .toList()
                //         .cast<Widget>() : data.companies
                //         .map((e) => Text('# ${e["name"]}   ',
                //         style: TextStyle(color: Colors.blue)))
                //         .toList()
                //         .cast<Widget>(),
                //
                //   ),
                // ),
                // Padding(
                //     padding: const EdgeInsets.all(8.0),
                //   child: Wrap(
                //     spacing: 30,
                //     // runAlignment: WrapAlignment.end,
                //     alignment: WrapAlignment.spaceBetween,
                //     // crossAxisAlignment: WrapCrossAlignment.end,
                //     // textDirection: TextDirection.rtl,
                //     children: [
                //       Text(
                //           '# ${data.companies_name}   ',
                //           style: TextStyle(color: Colors.blue)
                //       ),
                //       data.companies_industry!= 'N/A' ?
                //       Text(
                //           '# ${data.companies_industry}',
                //           textAlign: TextAlign.end,
                //           style: TextStyle(color: Colors.blue)
                //       ) : Container()
                //     ],
                //   ),
                // ),
                Text(
                  data.title.toString(),
                  textAlign: TextAlign.left,
                  style: headline6,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  child: SingleChildScrollView(
                    child: Text(
                      data.content.split(' ').length <= 100
                          ? data.content.toString()
                          : '${data.content.split(' ').take(100).join(' ')}.',
                      style: subtitle1White60,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(16, 10, 0, 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${d.day}, ${months[d.month]} ${d.year} ${dateFormat}',
                  // DateTime.parse(data.createdAt).toString(),
                  style: subtitle1White60newsBody,
                ),
                Container(
                  margin: EdgeInsets.only(right: 36),
                  child: Text(
                    '${data.sourceLink}',
                    // DateTime.parse(data.createdAt).toString(),
                    style: subtitle1White60newsBody,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
