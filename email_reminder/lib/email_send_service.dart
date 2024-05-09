import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:email_reminder/item.dart';
import 'package:jiffy/jiffy.dart';


class EmailSendService {
  EmailSendService();

  Future<void> sendEmailAtExpiry(Item item) async {
    DateTime sendTime = item.expiryTime;
    String executionName = 'Execution${Random().nextInt(1000)}';
    String body = 'Your item ${item.name} has expired';
    
    String uri = 'https://rojdibztkd.execute-api.eu-north-1.amazonaws.com/alpha/execution';

    String jsonBody = _constructJsonBody(sendTime, executionName, body);
    
    var response = await http.post(Uri.parse(uri),
      headers: {"Content-Type": "application/json", "x-api-key": "SioygBs4i45dWb2bgScQN8EgHK0YAT2L434MLrLV"},
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
    
    String uri = 'https://rojdibztkd.execute-api.eu-north-1.amazonaws.com/alpha/execution';
    
    var response = await http.post(Uri.parse(uri),
      headers: {"Content-Type": "application/json", "x-api-key": "SioygBs4i45dWb2bgScQN8EgHK0YAT2L434MLrLV"},
      body: _constructJsonBody(sendTime, executionName, body)
    );

    print("${response.statusCode}");
    print(response.body);
  }

  String _constructJsonBody(DateTime sendTime, String executionName, String body) {
    return '''{
                "input": "{\\"sendTime\\": \\"${sendTime.toIso8601String()}+02:00\\",\\"queryStringParameters\\": {\\"subject\\": \\"Expiry notification\\",\\"body\\": \\"$body\\",\\"sender\\": \\"s331zg8id@mozmail.com\\",\\"recipient\\": \\"srlvvlw39@mozmail.com\\"}}",
                "name": "$executionName",
                "stateMachineArn": "arn:aws:states:eu-north-1:222103012619:stateMachine:MyStateMachine-iq91z8dq4"
              }''';
  }
}