import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:technical_ind/widgets/dialoghelper.dart';
import '../../styles.dart';
import '../../widgets/appbar_with_cross.dart';
import 'business/feedback_services.dart';

class FeedBack extends StatefulWidget {
  @override
  _FeedBackState createState() => _FeedBackState();
}

List<bool> press = [false, true];
final FirebaseAuth auth = FirebaseAuth.instance;
final user = auth.currentUser;
final uid = user.email;
bool _tfborder = false;

class _FeedBackState extends State<FeedBack> {
  final TextEditingController _controller = TextEditingController();
  bool _isvalid = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  var messageFeedback;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithCross(
        text: "Send us your feedback!",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 20.0, right: 16),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Any suggestion? let us know in the field below",
                  style: TextStyle(color: white60, fontSize: 14),
                ),
              ),
              SizedBox(height: 33),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _containerBuilder("Bad", 'assets/icons/redbear.svg', 0, red),
                  _containerBuilder(
                      "Good", 'assets/icons/bluebull.svg', 1, blue),
                ],
              ),
              SizedBox(height: 40),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _tfborder = true;
                  });
                },
                child: Container(
                  height: 136,
                  width: 0.91 * MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: darkGrey,
                    borderRadius: BorderRadius.circular(8),
                    border: _tfborder
                        ? Border.all(color: Colors.white)
                        : Border.all(color: grey),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 17.0, right: 17),
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        errorText: _isvalid ? "Review can't be empty!" : null,
                        isDense: true,
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: 'Describe your experience here..',
                        hintStyle: TextStyle(color: white38, fontSize: 14),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 54),
              TextButton(
                child: Container(
                  height: 48,
                  width: 0.66 * MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Color(0xFF007AFF),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      "Submit Feedback",
                      style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 14),
                    ),
                  ),
                ),
                onPressed: () async {
                  setState(() {
                    _controller.text.isEmpty
                        ? _isvalid = true
                        : _isvalid = false;
                  });
                  String type = press[0] ? 'bad' : 'good';
                  var messageDetails =
                      await FeedbackServices.getSuccessfullMessage(
                              type, uid.toString(), _controller.text)
                          .whenComplete(() {
                    if (!_isvalid) {
                      return DialogHelperFeedback.exit(context);
                      // BotToast.showText(
                      //   contentColor: almostWhite,
                      //   textStyle: TextStyle(color: black),
                      //   text: 'Submitted!',
                      // );
                    }
                  });
                  print(messageDetails[0].message);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _containerBuilder(
      String title, String imagepath, int index, Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (index == 0) {
            press[0] = true;
            press[1] = false;
          } else {
            press[1] = true;
            press[0] = false;
          }
        });
      },
      child: Container(
        height: 162,
        width: 0.42 * MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: darkGrey,
          border: press[index] ? Border.all(color: color) : null,
          // image: SvgPicture.asset('assets/icons/bluebull.svg'),
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 23.0),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(25),
                child: SvgPicture.asset(
                  imagepath,
                  color: press[index] ? color : white24,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  title,
                  style: TextStyle(color: !press[index] ? white38 : color),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
