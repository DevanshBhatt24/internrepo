import 'package:flutter/material.dart';
import 'package:technical_ind/components/LoadingPage.dart';
import 'package:technical_ind/components/noDataAvailable.dart';
import 'package:technical_ind/screens/stocks/business/models/StockDetailsModel.dart';
import 'package:technical_ind/screens/stocks/business/stockServices.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../styles.dart';

class AboutPage extends StatefulWidget {
  final String isin;
  AboutPage({Key key, this.isin}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class CustomText extends StatelessWidget {
  final String title1, title2, subtitle1, subtitle2;

  CustomText(
    this.title1,
    this.subtitle1,
    this.title2,
    this.subtitle2,
  ) : super();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title1, style: subtitle1White),
                Text(subtitle1, style: bodyText2White60)
              ],
            ),
          ),
          SizedBox(
            width: 32,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              //mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  title2,
                  textAlign: TextAlign.right,
                  style: subtitle1White,
                ),
                Text(subtitle2,
                    textAlign: TextAlign.right, style: bodyText2White60)
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AboutPageState extends State<AboutPage> {
  About about;
  bool loading = true;

  fetchApi() async {
    about = await StockServices.stockAboutDetails(widget.isin);
    if (about != null) {
      for (var i = 0; i < about.management.length; i += 2) {
        management.add(CustomText(
            about.management[i].name,
            about.management[i].position,
            i + 1 >= about.management.length
                ? ''
                : about.management[i + 1].name,
            i + 1 >= about.management.length
                ? ''
                : about.management[i + 1].position));
      }
    }
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    fetchApi();
    super.initState();
  }

  List<Widget> management = [];
  @override
  Widget build(BuildContext context) {
    return loading
        ? LoadingPage()
        : about == null
            ? NoDataAvailablePage()
            : Scaffold(
                body: SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      //mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 38),
                        Text("Registered Office", style: subtitle1White),
                        SizedBox(height: 16),
                        col('Address', about.registeredOffice?.address ?? "-",
                            false),
                        CustomRow('City', about.registeredOffice?.city ?? "-",
                            'State', about.registeredOffice?.state),
                        CustomRow(
                            'Tel No.',
                            about.registeredOffice?.telNo ?? "-",
                            'Fax No.',
                            about.registeredOffice?.faxNo ?? "-"),
                        col('Email', about.registeredOffice?.email ?? "-",
                            true),
                        col('Internet', about.registeredOffice?.internet ?? "-",
                            true),
                        SizedBox(height: 40),
                        Text("Registrars", style: subtitle1White),
                        SizedBox(height: 16),
                        col('Address', about.registrars?.address ?? "-", false),
                        CustomRow('City', about.registrars?.city ?? "-",
                            'State', about.registrars?.state ?? "-"),
                        CustomRow('Tel No.', about.registrars?.telNo ?? "-",
                            'Fax No.', about.registrars?.faxNo ?? "-"),
                        col('Email', about.registrars?.email ?? "-", true),
                        col('Internet', about.registrars?.internet ?? "-",
                            true),
                        SizedBox(height: 40),
                        Text("Management", style: subtitle1White),
                        SizedBox(height: 16),
                        ...management,
                        // CustomText('Mukesh D Ambani', 'Chairman & Managing Director',
                        //     'P M S Prasad', 'Executive Director'),
                        // CustomText('Pawan Kumar Kapil', 'Executive Director',
                        //     'Nikhil R Meswani', 'Executive Director'),
                        // CustomText('Hital R Meswani', 'Executive Director', '', ''),
                        SizedBox(height: 40),
                        Text("Included In", style: subtitle1White),
                        SizedBox(height: 16),
                        CustomRow(
                            'BSE 100',
                            about.includedIn.bse100.toUpperCase() ?? "",
                            'BSE 200',
                            about.includedIn.bse200.toUpperCase() ?? ""),
                        CustomRow(
                            'SENSEX',
                            about.includedIn.sensex.toUpperCase() ?? "",
                            'CNX MIDCAP 200',
                            about.includedIn.cnxMidcap200.toUpperCase() ?? ""),
                        CustomRow(
                            'NIFTY 50',
                            about.includedIn.nifty50.toUpperCase() ?? "",
                            'BSE 500',
                            about.includedIn.bse500.toUpperCase() ?? ""),
                        SizedBox(height: 40),
                        Text("Details", style: subtitle1White),
                        SizedBox(height: 16),
                        CustomRow('BSE', about.details.bse ?? "", 'NSE',
                            about.details.nse ?? ""),
                        CustomRow('SERIES', about.details.series ?? "", 'ISIN',
                            about.details.isin ?? ""),
                      ],
                    ),
                  ),
                ),
              );
  }

  String getTrimed(String s) {
    return s != null ? s.trim() : '-';
  }

  Widget col(String a, String b, bool isLink) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(a, style: bodyText2White60),
          SizedBox(height: 4),
          InkWell(
            onTap: () async {
              await launch(
                'https://' + getTrimed(b),
              );
            },
            child: Container(
                width: 1 * MediaQuery.of(context).size.width - 50,
                child: Text(b,
                    style: bodyText2White.copyWith(
                        color: isLink ? blue : white,
                        decoration: isLink ? TextDecoration.underline : null))),
          )
        ],
      ),
    );
  }

  Widget CustomRow(String a, String b, String c, String d) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(a, style: bodyText2White60),
                SizedBox(height: 4),
                Text(b, style: bodyText2White)
              ],
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(c, textAlign: TextAlign.end, style: bodyText2White60),
                SizedBox(height: 4),
                Text(d, textAlign: TextAlign.right, style: bodyText2White),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
