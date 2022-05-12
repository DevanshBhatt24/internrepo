import 'package:flutter/material.dart';
import '../business/indices_mcx_model.dart';
import '../../../styles.dart';

class MCXIndices extends StatelessWidget {
  final IndicesMcxModel indicesMcxModel;
  MCXIndices({this.indicesMcxModel});

  Mcxldex bulldexspot;
  Mcxldex bulldexfuture;
  Mcxldex metldexspot;
  Mcxldex metldexfuture;

  @override
  Widget build(BuildContext context) {
    bulldexspot = indicesMcxModel?.data[0]?.mcxbulldex;
    bulldexfuture = indicesMcxModel?.data[1]?.mcxbulldex;
    metldexspot = indicesMcxModel?.data[2]?.mcxmetldex;
    metldexfuture = indicesMcxModel?.data[3]?.mcxmetldex;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('BULLDEX', style: subtitle1White),
        _dex(context),
        Text('MELTDEX', style: subtitle1White),
        _dex2(context)
      ],
    );
  }

  Widget column(String s, String val) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(val, style: bodyText2),
        SizedBox(height: 2),
        Text(s, style: captionWhite60),
      ],
    );
  }

  Widget _dex(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(children: [
        Text('SPOT', style: subtitle2White),
        SizedBox(height: 2),
        Text(
          bulldexspot?.spot?.date ?? "",
          style: captionWhite60,
        ),
        SizedBox(height: 16),
        Container(
          child: Card(
            color: darkGrey,
            elevation: 50,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(bulldexspot?.spot?.price ?? "", style: subtitle1White),
                  SizedBox(height: 2),
                  Text(
                    bulldexspot.spot.change.contains('-')
                        ? bulldexspot.spot.change +
                            "(" +
                            bulldexspot.spot.changePercent +
                            ")"
                        : '+' +
                            bulldexspot.spot.change +
                            "(+" +
                            bulldexspot.spot.changePercent +
                            ")",
                    style: bodyText2.copyWith(
                      color: bulldexspot.spot.change.contains('-') ? red : blue,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          column('Open', bulldexspot?.spot?.open ?? ""),
                          SizedBox(),
                          column(
                              'Close', bulldexspot?.spot?.previousClose ?? ""),
                        ],
                      ),
                      SizedBox(height: 11),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          column(
                            'High',
                            bulldexspot?.spot?.highLow?.substring(
                              0,
                              bulldexspot.spot.highLow.indexOf('/'),
                            ),
                          ),
                          SizedBox(),
                          column(
                            'Low',
                            bulldexspot?.spot?.highLow?.substring(
                              bulldexspot.spot.highLow.indexOf('/') + 1,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
                crossAxisAlignment: CrossAxisAlignment.center,
              ),
            ),
          ),
        ),
        SizedBox(height: 31),
        Text('FUTURE', style: subtitle2White),
        SizedBox(height: 2),
        Text(bulldexfuture?.futures?.date ?? "", style: captionWhite60),
        SizedBox(height: 16),
        Container(
          child: Card(
            color: darkGrey,
            elevation: 50,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(bulldexfuture?.futures?.price ?? "",
                      style: subtitle1White),
                  SizedBox(height: 2),
                  Text(
                      bulldexfuture.futures.change.contains('-')
                          ? bulldexfuture?.futures?.change +
                              "(" +
                              bulldexfuture?.futures?.changePercent +
                              ")"
                          : '+' +
                              bulldexfuture?.futures?.change +
                              "(+" +
                              bulldexfuture?.futures?.changePercent +
                              ")",
                      style: bodyText2.copyWith(
                          color: bulldexfuture.futures.change.contains('-')
                              ? red
                              : blue)),
                  SizedBox(
                    height: 16,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          column('Open', bulldexfuture?.futures?.open ?? ""),
                          SizedBox(),
                          column('Close',
                              bulldexfuture?.futures?.previousClose ?? ""),
                        ],
                      ),
                      SizedBox(height: 11),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          column(
                            'High',
                            bulldexfuture?.futures?.highLow?.substring(
                              0,
                              bulldexfuture.futures.highLow.indexOf('/'),
                            ),
                          ),
                          SizedBox(),
                          column(
                            'Low',
                            bulldexfuture?.futures?.highLow?.substring(
                              bulldexfuture.futures.highLow.indexOf('/') + 1,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
                crossAxisAlignment: CrossAxisAlignment.center,
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Widget _dex2(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(children: [
        Text('SPOT', style: subtitle2White),
        SizedBox(height: 2),
        Text(
          bulldexspot.spot.date,
          style: captionWhite60,
        ),
        SizedBox(height: 16),
        Container(
          child: Card(
            color: darkGrey,
            elevation: 50,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(metldexspot.spot.price, style: subtitle1White),
                  SizedBox(height: 2),
                  Text(
                      metldexspot.spot.change.contains('-')
                          ? metldexspot.spot.change +
                              "(" +
                              metldexspot.spot.changePercent +
                              ")"
                          : '+' +
                              metldexspot.spot.change +
                              "(+" +
                              metldexspot.spot.changePercent +
                              ")",
                      style: bodyText2.copyWith(
                          color: metldexspot.spot.change.contains('-')
                              ? red
                              : blue)),
                  SizedBox(
                    height: 16,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          column('Open', metldexspot.spot.open),
                          SizedBox(),
                          column('Close', metldexspot.spot.previousClose),
                        ],
                      ),
                      SizedBox(height: 11),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          column(
                            'High',
                            metldexspot.spot.highLow.substring(
                              0,
                              metldexspot.spot.highLow.indexOf('/'),
                            ),
                          ),
                          SizedBox(),
                          column(
                            'Low',
                            metldexspot.spot.highLow.substring(
                              metldexspot.spot.highLow.indexOf('/') + 1,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
                crossAxisAlignment: CrossAxisAlignment.center,
              ),
            ),
          ),
        ),
        SizedBox(height: 31),
        Text('FUTURE', style: subtitle2White),
        SizedBox(height: 2),
        Text(metldexfuture.futures.date, style: captionWhite60),
        SizedBox(height: 16),
        Container(
          child: Card(
            color: darkGrey,
            elevation: 50,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(metldexfuture.futures.price, style: subtitle1White),
                  SizedBox(height: 2),
                  Text(
                      metldexfuture.futures.change.contains('-')
                          ? metldexfuture.futures.change +
                              "(" +
                              metldexfuture.futures.changePercent +
                              ")"
                          : '+' +
                              metldexfuture.futures.change +
                              "(+" +
                              metldexfuture.futures.changePercent +
                              ")",
                      style: bodyText2.copyWith(
                          color: metldexfuture.futures.change.contains('-')
                              ? red
                              : blue)),
                  SizedBox(
                    height: 16,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          column('Open', metldexfuture.futures.open),
                          SizedBox(),
                          column('Close', metldexfuture.futures.previousClose),
                        ],
                      ),
                      SizedBox(height: 11),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          column(
                            'High',
                            metldexfuture.futures.highLow.substring(
                              0,
                              metldexfuture.futures.highLow.indexOf('/'),
                            ),
                          ),
                          SizedBox(),
                          column(
                            'Low',
                            metldexfuture.futures.highLow.substring(
                              metldexfuture.futures.highLow.indexOf('/') + 1,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
                crossAxisAlignment: CrossAxisAlignment.center,
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
