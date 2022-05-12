import 'package:flutter/material.dart';

import '../../../styles.dart';
import '../../../widgets/datagrid.dart';
import 'financialPage.dart';

class CapitalStructure extends StatefulWidget {
  @override
  _CapitalStructureState createState() => _CapitalStructureState();
}

class _CapitalStructureState extends State<CapitalStructure> {
  static final List<String> v2014 = ['1539', '1539', '1539', '1539', '1539'];
  static final List<String> v2013 = ['1539', '1539', '1539', '1539', '1539'];
  static final List<String> v2012 = ['1539', '1539', '1539', '1539', '1539'];
  static final List<String> v2011 = ['1539', '1539', '1539', '1539', '1539'];
  static final List<String> v2010 = ['1539', '1539', '1539', '1539', '1539'];
  final List<String> head = [
    'Authorized Capital',
    'Issued Capital',
    'Shares',
    'Face Value',
    'Capital'
  ];

  final data1 = [v2014, v2013, v2012, v2011, v2010];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          title: "Capital Structure",
          subtitle: "Bajaj Finserv",
          context: context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 18),
            Container(
              height: 400,
              child: CustomTable(
                scrollPhysics: NeverScrollableScrollPhysics(),
                headersTitle: [
                  "",
                  "2013-14",
                  "2012-13",
                  "2011-12",
                  "2010-11",
                  "2009-10"
                ],
                fixedColumnWidth: 170,
                columnwidth: 100,
                totalColumns: 6,
                itemCount: head.length,
                leftSideItemBuilder: (c, i) {
                  return text(head[i]);
                },
                rightSideItemBuilder: (c, i) => Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(
                            5,
                            (index) => Container(
                                  width: 100,
                                  child: Text(data1[index][i],
                                      textAlign: TextAlign.center,
                                      style: bodyText2White),
                                ))),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget text(String s) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Text(
        s,
        textAlign: TextAlign.left,
        style: bodyText2White60,
      ),
    );
  }
}
