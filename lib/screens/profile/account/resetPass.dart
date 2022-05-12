import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import '../../../styles.dart';
import 'checkEmail.dart';

class ResetPass extends StatefulWidget {
  final String email;

  const ResetPass({Key key, this.email}) : super(key: key);
  @override
  _ResetPassState createState() => _ResetPassState();
}

class _ResetPassState extends State<ResetPass> {
  FocusNode _focusNode;
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
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
              Text('Reset Password', style: headline5White),
              SizedBox(height: 20),
              Text(
                'Enter the email associated with your account and we\'ll send an email with instructions to reset your password',
                style: bodyText2White60,
              ),
              SizedBox(height: 80),
              TextField(
                controller: textEditingController,
                focusNode: _focusNode,
                style: bodyText2White38,
                decoration: InputDecoration(
                    fillColor: _focusNode.hasFocus ? Colors.black : darkGrey,
                    filled: true,
                    alignLabelWithHint: true,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: almostWhite,
                      ),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    labelText: _focusNode.hasFocus ? 'Email ID' : null,
                    labelStyle: _focusNode.hasFocus ? bodyText2 : null,
                    hintText: _focusNode.hasFocus ? null : 'Email ID',
                    hintStyle: bodyText2White38),
              ),
              SizedBox(height: 50),
              FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0)),
                  minWidth: 1 * MediaQuery.of(context).size.width,
                  height: 48,
                  color: blue,
                  onPressed: () {
                    pushNewScreen(context,
                        screen: CheckEmail(
                          email: textEditingController.text,
                        ),
                        withNavBar: false);
                  },
                  child: Text('Send',
                      style: TextStyle(
                          fontSize: 14,
                          color: almostWhite,
                          fontWeight: FontWeight.w500)))
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
  }

  @override
  void initState() {
    super.initState();
    _focusNode = new FocusNode();
    _focusNode.addListener(_onOnFocusNodeEvent);
    if (RegExp(
            r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
        .hasMatch(widget.email)) textEditingController.text = widget.email;
  }

  _onOnFocusNodeEvent() {
    setState(() {
      // Re-renders
    });
  }
}
