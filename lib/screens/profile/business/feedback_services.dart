import 'package:http/http.dart' as http;

import 'package:technical_ind/screens/profile/business/model.dart';

String hostUrl = 'https://visit.bottomstreet.com/feedback.php';

class FeedbackServices {
  static Future<dynamic> getSuccessfullMessage(
      String type, String email, String message) async {
    final response = await http.post(Uri.parse(hostUrl),
        body: {"type": "$type", "email": "$email", "message": "$message"});
    var responseBody = feedbackModelFromJson(response.body);
    // print(responseBody.toString());
    return responseBody;
  }
}
