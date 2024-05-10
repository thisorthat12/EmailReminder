import 'dart:math';
import 'package:email_reminder/isar_service.dart';
import 'package:email_reminder/model/settings.dart';
import 'package:http/http.dart' as http;
import 'package:email_reminder/model/item.dart';
import 'package:jiffy/jiffy.dart';


class EmailSendService {
  EmailSendService();

  final IsarService isarService = IsarService();


  Future<void> sendEmailAtExpiry(Item item) async {
    Settings settings = await _getSettings();

    DateTime sendTime = item.expiryTime;
        
    _post(settings, sendTime, item.name);
  }

  Future<void> sendEmailWeekBefore(Item item) async {
    Settings settings = await _getSettings();

    // Return early if the current date is within one week of expiry
    DateTime sendTime = Jiffy.parseFromDateTime(item.expiryTime).subtract(weeks: 1).dateTime;
    if(Jiffy.now().isAfter(Jiffy.parseFromDateTime(sendTime))) {
      return;
    }

    _post(settings, sendTime, item.name);
  }

  Future<Settings> _getSettings() async {
    List<Settings> settingsList = await isarService.getSettings();
    return settingsList.first;
  }

  void _post(Settings settings, DateTime sendTime, String itemName) async {
    var response = await http.post(Uri.parse(settings.apiUrl),
      headers: {"Content-Type": "application/json", "x-api-key": settings.apiKey},
      body: _constructJsonBody(sendTime, itemName, settings)
    );

    print("${response.statusCode}");
    print(response.body);
  }

  String _constructJsonBody(DateTime sendTime, String itemName, Settings settings) {
    String executionName = 'Execution${Random().nextInt(10000)}';
    String body = 'Your item $itemName will expire in one week';
    return '''{
                "input": "{\\"sendTime\\": \\"${sendTime.toIso8601String()}+02:00\\",\\"queryStringParameters\\": {\\"subject\\": \\"Expiry notification\\",\\"body\\": \\"$body\\",\\"sender\\": \\"${settings.sender}\\",\\"recipient\\": \\"${settings.recipient}\\"}}",
                "name": "$executionName",
                "stateMachineArn": "${settings.stateMachineArn}"
              }''';
  }
}