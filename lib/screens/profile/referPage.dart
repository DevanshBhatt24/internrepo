import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:technical_ind/providers/authproviders.dart';
import 'package:technical_ind/providers/storageProviders.dart';
import 'package:technical_ind/refferal/refferalApi.dart';
import 'package:technical_ind/styles.dart';

class ReferalPage extends StatefulWidget {
  ReferalPage({Key key}) : super(key: key);

  @override
  _ReferalPageState createState() => _ReferalPageState();
}

class _ReferalPageState extends State<ReferalPage> {
  DynamicLinksApi dynamicLinksApi = DynamicLinksApi();
  String link = '';
  createLink() async {
    User user = context.read(authServicesProvider).currentUser;
    link = await dynamicLinksApi.createReferralLink();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    createLink();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Center(
          child: Text(
        "Link: " + link,
        style: subtitle1,
      )),
    );
  }
}
