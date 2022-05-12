import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

import '../../styles.dart';
import '../../widgets/appbar_with_back_and_search.dart';

class CustomerCare extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> urls = [
      Uri(scheme: 'mailto', path: 'help@bottomstreet.com').toString(),
      //'com.android.email',
      WhatsAppUnilink(
        phoneNumber: '+918178074992',
        text: "Hi! Can you help me with",
      ).toString(),
      Uri(scheme: "tel", path: "8178074992").toString(),
    ];
    return Scaffold(
      appBar: AppBarWithBack(text: 'Customer Care', height: 40),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            Center(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: Text('We are available 25x8 for you',
                  style: headline5White, textAlign: TextAlign.center),
            )),
            SizedBox(height: 20),
            _card(
                'Write us email',
                'Email your Query/Problem here',
                'Humans will reply, no spam',
                SvgPicture.asset('assets/icons/Mail.svg',
                    color: almostWhite, width: 24, height: 24),
                url: urls[0]),
            _card(
                'Chat with us',
                'Chat with our representatives',
                'We don\'t believe in Chatbot',
                SvgPicture.asset('assets/icons/whatsapp.svg',
                    color: almostWhite, width: 24, height: 24),
                url: urls[1]),
            _card(
                'Call us',
                'Speak to our members directly',
                'We don\'t use Automatic Teller Machine',
                SvgPicture.asset('assets/icons/Call.svg',
                    color: almostWhite, width: 24, height: 24),
                url: urls[2])
          ],
        ),
      ),
    );
  }

  Widget _card(String title, String subtitle1, String subtitle2, Widget icon,
      {String url}) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 7),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: darkGrey,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            //splashColor: Colors.white,
            onTap: () async {
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                BotToast.showText(
                    contentColor: almostWhite,
                    textStyle: TextStyle(color: black),
                    text: "Error Opening The App.");
              }
            },
            child: Container(
              height: 105,
              padding: EdgeInsets.only(top: 20, right: 20, left: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 50, child: icon),
                  Expanded(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(title, style: subtitle1White),
                          Text(subtitle1,
                              style: bodyText2White60,
                              textAlign: TextAlign.left),
                          Text(subtitle2,
                              style: bodyText2White60,
                              textAlign: TextAlign.left),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
