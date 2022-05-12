import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../providers/authproviders.dart';
import '../screens/profile/account/resetPass.dart';
import '../styles.dart';
import '../widgets/appbar_with_back_and_search.dart';
import 'authentication/auth.dart';
import 'authentication/auth_wrapper.dart';
import 'register.dart';

class SignInPage extends ConsumerWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // String _email, _pass;
  SignInPage({Key key}) : super(key: key);

  void updateEmail(BuildContext context, String email) {
    context.read(emailProvider).state = email;
  }

  void updatepPassword(BuildContext context, String password) {
    context.read(passwordProvider).state = password;
  }

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final _auth = watch(authServicesProvider);
    final email = watch(emailProvider).state ?? "";
    final password = watch(passwordProvider).state ?? "";
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
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _space(12),
                    Text("Let's sign you in.", style: headline5White),
                    _space(16),
                    Text("Welcome back.\nYou have been missed!",
                        style: subtitle1White60),
                    _space(16),
                  ],
                ),
              ),
            ),
            Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                top: 124,
                child: SingleChildScrollView(
                  reverse: true,
                  child: Container(
                    color: Colors.black,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          _space(16),
                          Container(
                            // height: 50,
                            child: TextFormField(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                labelText: "Email ID",
                              ),
                              onChanged: (value) {
                                updateEmail(context, value);
                                print(email);
                              },
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return 'Email is required';
                                }

                                if (!RegExp(
                                        r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                    .hasMatch(value)) {
                                  return 'Please enter a valid email address';
                                }

                                return null;
                              },
                              style: bodyText2White60,
                              keyboardType: TextInputType.emailAddress,
                              onSaved: (value) {
                                updateEmail(context, value);
                              },
                            ),
                          ),
                          SizedBox(height: 24),
                          Container(
                            // height: 50,
                            child: TextFormField(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                suffix: email.isNotEmpty
                                    ? InkWell(
                                        onTap: () async {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (BuildContext
                                                          context) =>
                                                      ResetPass(email: email)));
                                        },
                                        child: Text(
                                          'Forgot ?',
                                          style:
                                              bodyText2.copyWith(color: blue),
                                        ),
                                      )
                                    : SizedBox(),
                                labelText: "Password",
                              ),
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return 'Password is required';
                                }

                                if (value.length < 5 || value.length > 20) {
                                  return 'Password must be betweem 5 and 20 characters';
                                }

                                return null;
                              },
                              // key: ValueKey('password'),
                              obscureText: true,
                              style: bodyText2White60,
                              keyboardType: TextInputType.visiblePassword,
                              onSaved: (value) {
                                updatepPassword(context, value);
                              },
                              onChanged: (value) {
                                updatepPassword(context, value);
                              },
                            ),
                          ),
                          SizedBox(height: 38),
                          InkWell(
                            onTap: () =>
                                _submitForm(context, _auth, email, password),
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: blue,
                              ),
                              child: Center(
                                child: Text("Sign In", style: button),
                              ),
                            ),
                          ),
                          _space(28),
                          Row(
                            children: [
                              Expanded(
                                child: Divider(thickness: 2, height: 1),
                              ),
                              Text("   OR   ", style: subtitle2White),
                              Expanded(
                                child: Divider(thickness: 2, height: 1),
                              ),
                            ],
                          ),
                          _space(28),
                          InkWell(
                            onTap: () {
                              _googleLogin(context, _auth);
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: darkGrey,
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SvgPicture.string(
                                      '<svg xmlns="http://www.w3.org/2000/svg" width="19.6" height="20" viewBox="0 0 19.6 20"><defs><style>.a{fill:rgba(255,255,255,0.87);}</style></defs><path class="a" d="M3.064,7.51A10,10,0,0,1,12,2a9.6,9.6,0,0,1,6.69,2.6L15.823,7.473A5.4,5.4,0,0,0,12,5.977,6.007,6.007,0,0,0,6.405,13.9a6.031,6.031,0,0,0,8.981,3.168,4.6,4.6,0,0,0,2-3.018H12V10.182h9.418a11.5,11.5,0,0,1,.182,2.045,9.747,9.747,0,0,1-2.982,7.35A9.542,9.542,0,0,1,12,22,10,10,0,0,1,3.064,7.51Z" transform="translate(-2 -2)"/></svg>',
                                      color: almostWhite,
                                    ),
                                    Text("  Continue with google",
                                        style: button),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          _space(38),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "New to Bottomstreet?",
                                style: bodyText2White,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RegisterPage()));
                                },
                                child: Text(
                                  "  Register for free",
                                  style: bodyText2.copyWith(color: blue),
                                ),
                              ),
                            ],
                          ),
                          _space(38),
                        ],
                      ),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  _googleLogin(BuildContext context, AuthenticationService auth) async {
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
    String s = await auth.signInWithGoogle();
    if (s == 'Signed in With Google') {
      // Navigator.of(context).pop();
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (BuildContext context) => AuthenticationWrapper()),
          (r) => false);
    } else
      Navigator.of(context).pop();
  }

  Widget _space(double d) {
    return SizedBox(
      height: d,
    );
  }

  void _submitForm(BuildContext context, AuthenticationService auth,
      String email, String password) async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        content: Container(
          height: 50,
          width: 50,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
    _formKey.currentState.save();

    String s = await auth.signIn(email: email, password: password);
    if (s == 'Signed in') {
      Navigator.of(context).pop();
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (BuildContext context) => AuthenticationWrapper()),
          (route) => false);
    } else
      Navigator.of(context).pop();
    //

    //
  }
}
