import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
//import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:technical_ind/components/containPage.dart';
import 'package:technical_ind/providers/storageProviders.dart';
import 'package:technical_ind/screens/etf/business/models/etf_explore_model.dart';
import 'package:technical_ind/screens/search/business/model.dart';
import 'package:technical_ind/styles.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/appbar_with_bookmark_and_share.dart';

class ExplorePage extends StatefulWidget {
  final List<String> menu;
  final List<Widget> menuWidgets;
  final String title, value, subValue;
  final Widget top, mid, end;
  final String expiryDate;
  final String code;
  final double defaultheight;
  final MutualFund mutualFundDetails;
  bool explorerLoading;

  ExplorePage(
      {Key key,
      this.menu,
      this.mutualFundDetails,
      this.title,
      this.code,
      this.value,
      this.subValue,
      this.menuWidgets,
      this.expiryDate,
      this.top,
      this.mid,
      this.end,
      this.defaultheight = 80,
      this.explorerLoading = false})
      : super(key: key);

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  PanelController _panelController = new PanelController();
  List<String> menu;

  Future<bool> checkIsSaved() async {
    print("checking saved...");
    var user = context.read(firestoreUserProvider);
    if (user.containsKey('MutualWatchlist')) {
      List<dynamic> mutualwatchlist = user['MutualWatchlist'];

      return mutualwatchlist.contains(widget.code);
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: SlidingUpPanel(
            controller: _panelController,
            color: const Color(0xff1c1c1e),
            defaultPanelState: PanelState.CLOSED,
            backdropEnabled: true,
            minHeight: 0,
            maxHeight: widget.defaultheight + menu.length * 48 + 2,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18), topRight: Radius.circular(18)),
            panel: Column(
              children: [
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 8, bottom: 24),
                    width: 38,
                    height: 4,
                    decoration: BoxDecoration(
                        color: white60,
                        borderRadius: BorderRadius.circular(30)),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(widget.title,
                        textAlign: TextAlign.center, style: subtitle2White),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ...List.generate(
                    widget.menu.length,
                    (index) => InkWell(
                          onTap: () {
                            _panelController
                                .close()
                                .whenComplete(() => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ContainPage(
                                                menu: menu,
                                                menuWidgets: widget.menuWidgets,
                                                title: widget.title,
                                                defaultWidget: menu[index],
                                              )),
                                    ));
                          },
                          child: Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 14),
                            child: new Text(menu[index], style: subtitle1White),
                          ),
                        ))
              ],
            ),
            body: Scaffold(
              // backgroundColor: kindaWhite,
              // for now the share icon is false
              appBar: widget.code != null
                  ? AppbarWithShare(
                      showShare: false,
                      isSaved: checkIsSaved,
                      onSaved: () async {
                        var db = context.read(storageServicesProvider);
                        // await db.updateMutualWatchlist(widget.code);
                        BotToast.showText(
                            contentColor: almostWhite,
                            textStyle: TextStyle(color: black),
                            text: "Added to Watchlist");
                      },
                      delSaved: () async {
                        print("removing...");
                        var db = context.read(storageServicesProvider);
                        // await db.removeMutualWatchlist([widget.code]);
                        BotToast.showText(
                            contentColor: almostWhite,
                            textStyle: TextStyle(color: black),
                            text: "Removed from Watchlist");
                      },
                    )
                  : null,
              body: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        // SizedBox(
                        //   height: 165,
                        // ),
                        widget.top != null
                            ? widget.top
                            : Center(
                                child: Text(widget.title,
                                    textAlign: TextAlign.center,
                                    style: headline6)),
                        SizedBox(
                          height: 10,
                        ),
                        widget.mid != null ? widget.mid : Container(),
                        SizedBox(height: (widget.expiryDate != null) ? 15 : 0),
                        (widget.expiryDate != null)
                            ? Center(
                                child: Text(widget.expiryDate,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: almostWhite,
                                        fontWeight: FontWeight.w600)))
                            : SizedBox(),
                        (widget.expiryDate != null)
                            ? Center(
                                child: Text('Expiry date',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: white60,
                                    )))
                            : SizedBox(),
                        SizedBox(
                          height: 100,
                        ),
                        widget.end != null
                            ? widget.end
                            : Center(
                                child:
                                    Text(widget.value, style: headline5White)),
                        widget.end != null
                            ? Container()
                            : Center(
                                child: Text(widget.subValue,
                                    style: bodyText2.copyWith(color: blue))),
                      ],
                    ),
                    SizedBox(
                      height: (widget.expiryDate != null || widget.end != null)
                          ? 80
                          : 128,
                    ),
                    Center(
                      child: InkWell(
                        onTap: () {
                          if (widget.explorerLoading) {
                            _panelController.open();
                          }
                        },
                        child: Hero(
                          tag: "explore",
                          child: Material(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              padding: EdgeInsets.all(12),
                              width: 240,
                              height: 48,
                              decoration: BoxDecoration(
                                  color: Colors.white12,
                                  borderRadius: BorderRadius.circular(6)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/explore.svg',
                                    color: almostWhite,
                                  ),
                                  Text("   Explore", style: buttonWhite),
                                  Flexible(
                                    child: Container(),
                                  ),
                                  widget.explorerLoading
                                      ? Icon(
                                          CupertinoIcons.forward,
                                          color: almostWhite,
                                          //size: 30,
                                        )
                                      : Container(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )));
  }

  @override
  void initState() {
    menu = widget.menu;
    super.initState();
  }
}
