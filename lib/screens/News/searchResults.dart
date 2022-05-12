import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:technical_ind/widgets/appbar_with_back_and_search.dart';
import '../../styles.dart';
import 'broadcastPage.dart';
import 'business/model.dart';
import 'business/newsServices.dart';

class SearchResultsPage extends StatefulWidget {
  final String title;
  final bool isSearched, isIpo;

  SearchResultsPage({Key key, this.title, this.isSearched, this.isIpo})
      : super(key: key);

  @override
  _NewsDetailsPageState createState() => _NewsDetailsPageState();
}

class _NewsDetailsPageState extends State<SearchResultsPage> {
  List<Article> articles = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: !widget.isSearched
            ? PreferredSize(
                child: Container(
                  height: 58,
                  color: grey,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    // height: 40,
                    child: CupertinoTextField(
                      // onTap: () => Navigator.popAndPushNamed(context, MaterialPageRoute(builder: builder)
                      onSubmitted: (val) {
                        pushNewScreen(
                          context,
                          screen: SearchResultsPage(
                            title: val,
                            isIpo: false,
                            isSearched: true,
                          ),
                        );
                      },
                      clearButtonMode: OverlayVisibilityMode.editing,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(6)),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 9),
                      prefix: Padding(
                        padding: const EdgeInsets.only(left: 18),
                        child: ImageIcon(
                          AssetImage("assets/nav/search.png"),
                          color: white60,
                        ),
                      ),
                      style: subtitle2White,
                    ),
                  ),
                ),
                preferredSize: Size.fromHeight(58),
              )
            : null,
        body: articles.isEmpty
            ? Center(
                heightFactor: 16,
                child: CircularProgressIndicator(color: Colors.white),
              )
            : NewsWidget(
                articles: articles,
                refresh: getArticles,
              ),
      ),
    );
  }

  Future getArticles() async {
    print(widget.title);
    articles =
        await NewsServices.getNewsFromQuery(widget.title).whenComplete(() {
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    getArticles();
  }
}
