import 'package:flutter/material.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:technical_ind/components/LoadingPage.dart';
import 'package:technical_ind/screens/indices/business/global_overview_model.dart';
import 'package:technical_ind/screens/indices/business/indices_services.dart';

import '../../../styles.dart';

class GlobalIndicesCompoments extends StatefulWidget {
  final String query;

  GlobalIndicesCompoments({Key key, this.query}) : super(key: key);

  @override
  _GlobalIndicesCompomentsState createState() =>
      _GlobalIndicesCompomentsState();
}

class _GlobalIndicesCompomentsState extends State<GlobalIndicesCompoments> {
  Component component;
  fetchApi() async {
    component = await IndicesServices.getGolbalIndicesComponents(widget.query);

    setState(() {});
    _refreshController.refreshCompleted();
  }

  @override
  void initState() {
    fetchApi();
    super.initState();
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void dispose() {
    // TODO: implement dispose

    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return component != null
        ? Scaffold(
            body: SmartRefresher(
                enablePullDown: true,
                enablePullUp: false,
                controller: _refreshController,
                onRefresh: fetchApi,
                header: ClassicHeader(
                  completeIcon: Icon(Icons.done, color: Colors.white60),
                  refreshingIcon: SizedBox(
                    width: 25,
                    height: 25,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                      color: Colors.white60,
                    ),
                  ),
                ),
                child: ListView.builder(
                    itemCount: component.data.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CardGridItem(
                          // aspectRatio: 0.96,
                          component?.data[index]?.name,
                          component?.data[index]?.price,
                          component.data[index].chg.contains('-')
                              ? component?.data[index]?.chg +
                                  '(' +
                                  component?.data[index]?.datumChg +
                                  ')'
                              : component?.data[index]?.chg +
                                  '(' +
                                  component?.data[index]?.datumChg +
                                  ')',
                          component.data[index].chg[0] == '-' ? red : blue,
                        ),
                      );
                    })),
          )
        : LoadingPage();
  }

  Widget CardGridItem(
      String title, String value, String subvalue, Color color) {
    return Container(
      width: MediaQuery.of(context).size.width,
      // height: 188,
      //margin: EdgeInsets.symmetric(vertical: 4),
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
        color: darkGrey,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 2),
            blurRadius: 8,
            color: Color(0xff000000).withOpacity(0.04),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 2.9 / 5,
            child:
                Text(title, textAlign: TextAlign.left, style: subtitle1White),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(value, textAlign: TextAlign.right, style: bodyText2White),
              SizedBox(height: 2),
              Text(
                subvalue,
                textAlign: TextAlign.right,
                style: bodyText2AnyColour.copyWith(color: color),
                overflow: TextOverflow.ellipsis,
                softWrap: false,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
