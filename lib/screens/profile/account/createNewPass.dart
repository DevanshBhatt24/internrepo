import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:technical_ind/onboarding/authentication/auth.dart';
import 'package:technical_ind/onboarding/signIn.dart';
import 'package:technical_ind/screens/profile/feedback.dart';
import '../../../styles.dart';

class CreateNewPass extends StatefulWidget {
  @override
  _CreateNewPassState createState() => _CreateNewPassState();
}

class _CreateNewPassState extends State<CreateNewPass> {
  FocusNode _focusNode0 = new FocusNode();
  FocusNode _focusNode = new FocusNode();
  FocusNode _focusNode1 = new FocusNode();
  TextEditingController _oldPass = new TextEditingController();
  TextEditingController _pass = new TextEditingController();
  TextEditingController _confirmPass = new TextEditingController();
  bool _passChanged = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(backgroundColor: Colors.black,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(CupertinoIcons.back),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Create New Password', style: headline5White),
                SizedBox(height: 20),
                SizedBox(
                  width: 280,
                  child: Text(
                    'Your new password must be different from previous used password.',
                    style: bodyText2White60,
                  ),
                ),
                SizedBox(height: 50),
                TextField(
                  controller: _oldPass,
                  focusNode: _focusNode0,
                  style: bodyText2White38,
                  obscureText: true,
                  decoration: InputDecoration(
                      fillColor: _focusNode0.hasFocus ? Colors.black : darkGrey,
                      filled: true,
                      alignLabelWithHint: true,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: almostWhite,
                        ),
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      labelText: _focusNode0.hasFocus ? 'Old Password' : null,
                      labelStyle: _focusNode0.hasFocus ? bodyText2 : null,
                      hintText: _focusNode0.hasFocus ? null : 'Old Password',
                      hintStyle: bodyText2White38),
                ),
                SizedBox(height: 50),
                TextField(
                  onChanged: (_) {
                    _passChanged = true;
                  },
                  controller: _pass,
                  focusNode: _focusNode,
                  style: bodyText2White38,
                  obscureText: true,
                  decoration: InputDecoration(
                      errorText:
                          (_pass.text.length < 5 || _pass.text.length > 20) &&
                                  _passChanged
                              ? 'Password must be betweem 5 and 20 characters'
                              : null,
                      fillColor: _focusNode.hasFocus ? Colors.black : darkGrey,
                      filled: true,
                      alignLabelWithHint: true,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: almostWhite,
                        ),
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      labelText: _focusNode.hasFocus ? 'New Password' : null,
                      labelStyle: _focusNode.hasFocus ? bodyText2 : null,
                      hintText: _focusNode.hasFocus ? null : 'New Password',
                      hintStyle: bodyText2White38),
                ),
                SizedBox(height: 25),
                TextField(
                  controller: _confirmPass,
                  focusNode: _focusNode1,
                  style: bodyText2White38,
                  obscureText: true,
                  decoration: InputDecoration(
                      errorText: _pass.text != _confirmPass.text
                          ? "Must be same as password"
                          : null,
                      fillColor: _focusNode1.hasFocus ? Colors.black : darkGrey,
                      filled: true,
                      alignLabelWithHint: true,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: almostWhite,
                        ),
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      labelText:
                          _focusNode1.hasFocus ? 'Confirm Password' : null,
                      labelStyle: _focusNode1.hasFocus ? bodyText2 : null,
                      hintText:
                          _focusNode1.hasFocus ? null : 'Confirm Password',
                      hintStyle: bodyText2White38),
                ),
                SizedBox(height: 40),
                FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0)),
                    minWidth: 1 * MediaQuery.of(context).size.width,
                    height: 48,
                    color: blue,
                    onPressed: () async {
                      if (_confirmPass.text.isEmpty ||
                          _pass.text.isEmpty || _oldPass.text.isEmpty) {
                        BotToast.showText(
                            contentColor: almostWhite,
                            textStyle: TextStyle(color: black),
                            text: "All fields must be filled",
                            duration: Duration(seconds: 3));
                        Navigator.of(context).pop();
                        return 0;
                      } else if (_oldPass.text == _pass.text) {
                        BotToast.showText(
                            contentColor: almostWhite,
                            textStyle: TextStyle(color: black),
                            text:
                                'New password must be different from previous password!',
                            duration: Duration(seconds: 3));
                        return 0;
                      } else if (_confirmPass.text != _pass.text) {
                        return 0;
                      } else if (_pass.text.length < 5 ||
                          _pass.text.length > 20) {
                        BotToast.showText(
                            contentColor: almostWhite,
                            textStyle: TextStyle(color: black),
                            text:
                                'Password must be betweem 5 and 20 characters',
                            duration: Duration(seconds: 3));
                        return 0;
                      }
                      showCupertinoDialog(
                        context: context,
                        builder: (context) => CupertinoAlertDialog(
                          content: Container(
                            height: 50,
                            width: 50,
                            child: Center(
                              child: CircularProgressIndicator(
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      );
                      String s =
                          await changePassword(_oldPass.text, _pass.text);

                      if (s == "success") {
                        await auth.signOut();
                        pushNewScreen(context,
                            screen: SignInPage(), withNavBar: false);
                      } else {
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text('Confirm',
                        style: TextStyle(
                            fontSize: 14,
                            color: almostWhite,
                            fontWeight: FontWeight.w500)))
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
    _focusNode1.dispose();
  }

  @override
  void initState() {
    super.initState();
    _focusNode = new FocusNode();
    _focusNode.addListener(_onOnFocusNodeEvent);
    _focusNode1 = new FocusNode();
    _focusNode1.addListener(_onOnFocusNodeEvent);
  }

  _onOnFocusNodeEvent() {
    setState(() {
      // Re-renders
    });
  }
}
