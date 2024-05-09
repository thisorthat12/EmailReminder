import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:email_reminder/item.dart';
import 'package:jiffy/jiffy.dart';


class EmailSendService {
  EmailSendService();

  Future<void> sendEmailAtExpiry(Item item) async {
    DateTime sendTime = item.expiryTime;
    String executionName = 'Execution${Random().nextInt(10000)}';
    String body = 'Your item ${item.name} has expired';
    
    String uri = 'uri';

    String jsonBody = _constructJsonBody(sendTime, executionName, body);
    
    var response = await http.post(Uri.parse(uri),
      headers: {"Content-Type": "application/json", "x-api-key": "api-key"},
      body: jsonBody
    );

    print("${response.statusCode}");
    print(response.body);
  }

  Future<void> sendEmailWeekBefore(Item item) async {
    DateTime sendTime = Jiffy.parseFromDateTime(item.expiryTime).subtract(weeks: 1).dateTime;
    if(Jiffy.now().isAfter(Jiffy.parseFromDateTime(sendTime))) {
      return;
    }
    String executionName = 'Execution${Random().nextInt(10000)}';
    String body = 'Your item ${item.name} will expire in one week';
    
    String uri = 'uri';
    
    var response = await http.post(Uri.parse(uri),
      headers: {"Content-Type": "application/json", "x-api-key": "api-key"},
      body: _constructJsonBody(sendTime, executionName, body)
    );

    print("${response.statusCode}");
    print(response.body);
  }

  String _constructJsonBody(DateTime sendTime, String executionName, String body) {
    return '''{
                "input": "{\\"sendTime\\": \\"${sendTime.toIso8601String()}+02:00\\",\\"queryStringParameters\\": {\\"subject\\": \\"Expiry notification\\",\\"body\\": \\"$body\\",\\"sender\\": \\"sender\\",\\"recipient\\": \\"recipient\\"}}",
                "name": "$executionName",
                "stateMachineArn": "arn"
              }''';
  }
}