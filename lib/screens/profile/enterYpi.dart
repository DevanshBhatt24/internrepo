import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:technical_ind/refferal/refferalApi.dart';
import 'package:technical_ind/screens/profile/payoutPage.dart';
import 'package:technical_ind/storage/referalSharedPref.dart';
import 'package:technical_ind/widgets/appbar_with_back_and_search.dart';
import 'package:technical_ind/onboarding/authentication/auth.dart';
import 'package:technical_ind/providers/authproviders.dart';
import 'package:technical_ind/providers/storageProviders.dart';
import 'package:technical_ind/refferal/referModel.dart';
import 'package:technical_ind/storage/storageServices.dart';
import '../../styles.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EnterUPIpage extends StatefulWidget {
  EnterUPIpage({Key key}) : super(key: key);

  @override
  _EnterUPIpageState createState() => _EnterUPIpageState();
}

class _EnterUPIpageState extends State<EnterUPIpage> {
  var _formkey = GlobalKey<FormState>();

  var _ACcontroller = TextEditingController();
  var _ACCcontroller = TextEditingController();
  var _IFSCcontroller = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    _ACCcontroller.dispose();
    _ACCcontroller.dispose();
    _IFSCcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithBack(text: "Enter Bank Details"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 29),
              Text(
                "Payout details",
                style: GoogleFonts.ibmPlexSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFFFFFFFF),
                ),
              ),
              SizedBox(height: 12),
              Form(
                key: _formkey,
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _ACcontroller,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: _ACcontroller.clear,
                          icon: FaIcon(
                            FontAwesomeIcons.pen,
                            size: 15,
                            color: white,
                          ),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        labelText: "Bank Account Number",
                      ),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Bank Account number is required';
                        }

                        if (!RegExp(r"^[0-9]+$").hasMatch(value)) {
                          return 'Please enter a valid Account Number';
                        }
                        return null;
                      },
                      style: GoogleFonts.ibmPlexSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.25,
                        color: white,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _ACCcontroller,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: _ACCcontroller.clear,
                          icon: FaIcon(
                            FontAwesomeIcons.pen,
                            size: 15,
                            color: white,
                          ),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        labelText: "Confirm Bank Account Number",
                      ),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Confirm bank account number';
                        }
                        if (_ACCcontroller.text != _ACcontroller.text)
                          return 'Bank account number did not match';
                        return null;
                      },
                      style: GoogleFonts.ibmPlexSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.25,
                        color: white,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _IFSCcontroller,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: _IFSCcontroller.clear,
                          icon: FaIcon(
                            FontAwesomeIcons.pen,
                            size: 15,
                            color: white,
                          ),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        labelText: "IFSC Code",
                      ),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'IFSC Code is required';
                        }

                        return null;
                      },
                      style: GoogleFonts.ibmPlexSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.25,
                        color: white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 21),
              Padding(
                padding: const EdgeInsets.only(right: 79),
                child: Text(
                  "Enter your bank details to receive comission directly into your bank account.",
                  style: GoogleFonts.ibmPlexSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: white,
                  ),
                ),
              ),
              SizedBox(height: 58),
              Center(
                child: TextButton(
                  onPressed: () {
                    _addUpiDetails();
                  },
                  child: Container(
                    height: 42,
                    width: 210,
                    decoration: BoxDecoration(
                      color: Color(0xFF007AFF),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        'Generate Refferal Link',
                        style: GoogleFonts.ibmPlexSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.1,
                            color: Color(0xFFFFF6F6)),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _addUpiDetails() async {
    if (!_formkey.currentState.validate()) return;
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        content: Container(
          height: 50,
          width: 50,
          child: Center(
            child: CircularProgressIndicator(color: Colors.white),
          ),
        ),
      ),
    );
    _formkey.currentState.save();
    DynamicLinksApi dynamicLinksApi = DynamicLinksApi();
    AuthenticationService user = context.read(authServicesProvider);
    StorageService storage = context.read(storageServicesProvider);

    String link =
        await dynamicLinksApi.createReferralLink();
    await storage.createRefferalAccount(
        ReferAccount(
            name: user.currentUser.displayName,
            email: user.currentUser.email,
            phone: user.currentUser.phoneNumber,
            accountNumber: _ACcontroller.text,
            ifsc: _IFSCcontroller.text),
        link);
    // ReferralSharedPreference.setAlreadyAdded(true);
    Navigator.of(context).pop();
    pushNewScreen(context, screen: PayoutPage());
  }
}
