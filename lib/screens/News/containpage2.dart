import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:technical_ind/providers/floatingIconProvider.dart';
import 'package:technical_ind/providers/navBarProvider.dart';
import 'package:technical_ind/providers/storageProviders.dart';
import 'package:technical_ind/screens/News/NewsSearchPage.dart';
import 'package:technical_ind/widgets/appbar_with_bookmark_and_share.dart';

import 'package:technical_ind/styles.dart';

import '../../components/slidePanel.dart';

class ContainPage2 extends StatefulWidget {
  final List<String> menu;
  final List<Widget> menuWidgets;
  final String title, defaultWidget, query;
  final double defaultheight;

  //isList for indices
  final bool isList, isListEtf, isListForex, isListGlobal;
  ContainPage2(
      {Key key,
      this.title,
      this.isListEtf = false,
      this.isListForex = false,
      this.isListGlobal = false,
      this.query,
      this.isList = false,
      this.menu,
      this.menuWidgets,
      this.defaultWidget,
      this.defaultheight = 80})
      : super(key: key);

  @override
  _ContainPageState2 createState() => _ContainPageState2();
}

class _ContainPageState2 extends State<ContainPage2> {
  int _selected;

  PanelController _panelController = new PanelController();
  List<String> menu;
  List<Widget> widgetList;
  bool show = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Visibility(
        visible: context.read(iconVisibleProvider).iconVisible,
        child: FloatingActionButton(
          onPressed: () {
            pushNewScreen(context, screen: NewsSearchPage());
          },
          backgroundColor: blue,
          child: ImageIcon(
            AssetImage("assets/nav/search.png"),
            color: white,
          ),
        ),
      ),
      body: Material(
        child: SlidePanel(
          defaultHeight: 70,
          menu: menu,
          defaultWidget: widget.defaultWidget,
          panelController: _panelController,
          onChange: (val) {
            setState(() {
              _selected = val;
            });
            context.read(iconVisibleProvider).setNavbarVisible(true);
          },
          // panel: Column(
          //   children: [
          //     Center(
          //       child: Container(
          //         margin: EdgeInsets.only(top: 8, bottom: 24),
          //         width: 38,
          //         height: 4,
          //         decoration: BoxDecoration(
          //             color: white60, borderRadius: BorderRadius.circular(30)),
          //       ),
          //     ),
          //     // Center(
          //     //   child: Text("Explore", style: subtitle2White),
          //     // ),
          //   ...List.generate(
          //       widget.menu.length,
          //       (index) => InkWell(
          //             onTap: () {
          //               _panelController.close();
          //               if (widgetList[index] != null)
          //                 setState(() {
          //                   _selected = index;
          //                   show = true;
          //                 });
          //               context
          //                   .read(navBarVisibleProvider)
          //                   .setNavbarVisible(false);
          //             },
          //             child: Container(
          //               padding: EdgeInsets.symmetric(
          //                   horizontal: 16, vertical: 14),
          //               child: Row(
          //                 children: [
          //                   Container(
          //                       width: 24,
          //                       child: Icon(
          //                         Icons.check,
          //                         color: _selected == index
          //                             ? almostWhite
          //                             : Colors.transparent,
          //                       )),
          //                   SizedBox(
          //                     width: 16,
          //                   ),
          //                   Text(
          //                     menu[index],
          //                     style: subtitle1.copyWith(
          //                       color: _selected == index
          //                           ? almostWhite
          //                           : white38,
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //           )),
          // ],
          // ),
          child: Scaffold(
            //backgroundColor: kindaWhite,

            appBar: PreferredSize(
              preferredSize: Size.fromHeight(60),
              child: InkWell(
                onTap: () {
                  context.read(iconVisibleProvider).setNavbarVisible(false);
                  context.read(navBarVisibleProvider).setNavbarVisible(true);

                  _panelController.open();
                },
                child: Hero(
                  tag: "explore",
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      margin: EdgeInsets.only(
                          left: 16, right: 16, top: 0, bottom: 5),
                      padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
                      //height: 40.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color(0xff1c1c1e),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(menu[_selected], style: buttonWhite),
                          Icon(
                            Icons.expand_more,
                            color: almostWhite,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            body: widgetList[_selected],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    menu = widget.menu;
    widgetList = widget.menuWidgets;
    _selected = menu.indexOf(widget.defaultWidget);
    super.initState();
  }
}
