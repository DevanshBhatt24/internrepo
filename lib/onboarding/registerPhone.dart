import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../styles.dart';
import '../widgets/appbar_with_back_and_search.dart';
import 'otpScreen.dart';

class RegisterPhonePage extends StatefulWidget {
  RegisterPhonePage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPhonePage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithBack(
        text: "",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _space(12),
                  Text("Register Your Phone Number", style: headline5White),
                  _space(16),
                  Text(
                      "Your number is safe with us.\nWe won't share your details with anyone.",
                      style: subtitle1White60),
                  _space(130),
                  Form(
                      key: _formKey,
                      child: Column(children: [
                        Container(
                          height: 70,
                          child: TextField(
                            controller: textEditingController,
                            decoration: InputDecoration(
                              // counterText: "",
                              prefix: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text("+91  "),
                                  Container(
                                    height: 24,
                                    width: 2,
                                    color: grey,
                                  ),
                                  Text("  ")
                                ],
                              ),
                              labelText: "Phone Number",
                            ),
                            keyboardType: TextInputType.number,
                            maxLength: 10,
                            style: bodyText2White60,
                          ),
                        ),
                        SizedBox(height: 38),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => OtpScreen(
                                      phoneNumber: textEditingController.text,
                                    )));
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: blue,
                            ),
                            child: Center(
                              child: Text("Register", style: button),
                            ),
                          ),
                        ),
                      ]))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _space(double d) {
    return SizedBox(
      height: d,
    );
  }
}
