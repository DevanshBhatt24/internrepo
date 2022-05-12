import 'dart:math';

import 'package:flutter/material.dart';
//import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../providers/navBarProvider.dart';
import '../styles.dart';

typedef void Callback(PanelController p);
typedef void IntCallback(int id);

class SlidePanel extends StatelessWidget {
  final List<String> menu;
  final IntCallback onChange;
  final PanelController panelController;
  final Callback open;
  final Widget child;
  final String defaultWidget;
  final double defaultHeight;

  int _selected;

  SlidePanel(
      {Key key,
      this.menu,
      this.onChange,
      this.child,
      this.defaultWidget,
      this.open,
      this.panelController,
      this.defaultHeight = 60.0})
      : super(key: key);

  // PanelController _panelController = new PanelController();

  @override
  Widget build(BuildContext context) {
    _selected = menu.indexOf(defaultWidget);
    return Material(
      child: SlidingUpPanel(
        controller: panelController,
        color: const Color(0xff1c1c1e),
        defaultPanelState: PanelState.CLOSED,
        backdropEnabled: true,
        minHeight: 0,
        maxHeight: min(defaultHeight + menu.length * 48,
            MediaQuery.of(context).size.height * 0.9),
        borderRadius: BorderRadius.circular(18),
        onPanelClosed: () {
          context.read(navBarVisibleProvider).setNavbarVisible(false);
        },
        panel: Column(
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 6),
                width: 38,
                height: 4,
                decoration: BoxDecoration(
                    color: white60, borderRadius: BorderRadius.circular(30)),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(
                      menu.length,
                      (index) => InkWell(
                            onTap: () {
                              panelController.close().whenComplete(() {
                                onChange(index);
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.only(left: 16, bottom: 28),
                              child: Row(
                                children: [
                                  Container(
                                      width: 40,
                                      child: Icon(
                                        Icons.check,
                                        color: _selected == index
                                            ? Colors.white.withOpacity(0.87)
                                            : Colors.transparent,
                                      )),
                                  Text(
                                    menu[index],
                                    style: subtitle1.copyWith(
                                      color: _selected == index
                                          ? almostWhite
                                          : white38,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )),
                ),
              ),
            ),
          ],
        ),
        body: child,
      ),
    );
  }
}
