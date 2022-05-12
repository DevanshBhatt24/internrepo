import 'package:flutter/material.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:technical_ind/components/LoadingPage.dart';
import 'package:technical_ind/components/noDataAvailable.dart';
import 'package:technical_ind/screens/indices/business/indices_services.dart';
import 'package:technical_ind/screens/stocks/explore/home.dart';
import '../business/indian_overview_model.dart';
import '../../../styles.dart';

class IndianIndicesComponents extends StatefulWidget {
  // final List<Component> components;
  String query;
  IndianIndicesComponents({this.query});
  @override
  _IndianIndicesComponentsState createState() =>
      _IndianIndicesComponentsState();
}

class _IndianIndicesComponentsState extends State<IndianIndicesComponents> {
  List<Component> components;
  bool loading = true;
  @override
  void initState() {
    fetchApi();
    super.initState();
  }

  fetchApi() async {
    components = await IndicesServices.getIndianIndicesComponents(widget.query);
    setState(() {
      loading = false;
    });
    _refreshController.refreshCompleted();
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
    return Scaffold(
      body: loading
          ? LoadingPage()
          : components != null
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SmartRefresher(
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
                      itemCount: components.length,
                      itemBuilder: (c, i) => comp(
                          components[i].chg,
                          components[i].chgPercent,
                          components[i].name,
                          components[i].price,
                          components[i].stock_code),
                    ),
                  ),
                )
              : NoDataAvailablePage(),
    );
  }

  Widget comp(String chg, String chgpercent, String name, String price,
      String stock_code) {
    return InkWell(
      onTap: () {
        pushNewScreen(context,
            withNavBar: false,
            screen: Homepage(
              name: name ?? "",
              stockCode: stock_code ?? "",
            ));
      },
      child: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.symmetric(vertical: 4),
        color: darkGrey,
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(name ?? "", style: bodyText1white),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(price ?? "",
                    style: bodyText2White, textAlign: TextAlign.right),
                chg == null || chgpercent == null
                    ? SizedBox()
                    : Text(
                        chg[0] != '-'
                            ? '+' + chg + ' (+' + chgpercent + '%)'
                            : chg + ' (' + chgpercent + '%)',
                        style: bodyText2AnyColour.copyWith(
                          color: chg[0] != '-' ? blue : red,
                        ),
                        textAlign: TextAlign.right,
                      )
              ],
            )
          ],
        ),
      ),
    );
  }
}
