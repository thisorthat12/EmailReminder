import 'dart:math';
import 'package:email_reminder/isar_service.dart';
import 'package:email_reminder/model/settings.dart';
import 'package:http/http.dart' as http;
import 'package:email_reminder/model/item.dart';
import 'package:jiffy/jiffy.dart';


class EmailSendService {
  EmailSendService();

  final IsarService isarService = IsarService();


  Future<http.Response> sendEmailAtExpiry(Item item) async {
    Settings settings = await _getSettings();

    DateTime sendTime = item.expiryTime;
        
    return await _post(settings, sendTime, item.name, false);
  }

  Future<http.Response> sendEmailWeekBefore(Item item) async {
    Settings settings = await _getSettings();

    // Return early if the current date is within one week of expiry
    DateTime sendTime = Jiffy.parseFromDateTime(item.expiryTime).subtract(weeks: 1).dateTime;
    if(Jiffy.now().isAfter(Jiffy.parseFromDateTime(sendTime))) {
      return http.Response('', 400);
    }

    return await _post(settings, sendTime, item.name, true);
  }

  Future<Settings> _getSettings() async {
    List<Settings> settingsList = await isarService.getSettings();
    return settingsList.first;
  }

  Future<http.Response> _post(Settings settings, DateTime sendTime, String itemName, bool weekBefore) async {
    var response = await http.post(Uri.parse(settings.apiUrl),
      headers: {"Content-Type": "application/json", "x-api-key": settings.apiKey},
      body: _constructJsonBody(sendTime, itemName, settings, weekBefore)
    );
    return response;
  }

  String _constructJsonBody(DateTime sendTime, String itemName, Settings settings, bool weekBefore) {
    String executionName = 'Execution${Random().nextInt(10000)}';
    String body = weekBefore ? 'Your item $itemName will expire in one week' : 'Your item $itemName has expired';
    return '''{
                "input": "{\\"sendTime\\": \\"${sendTime.toIso8601String()}+02:00\\",\\"queryStringParameters\\": {\\"subject\\": \\"Expiry notification\\",\\"body\\": \\"$body\\",\\"sender\\": \\"${settings.sender}\\",\\"recipient\\": \\"${settings.recipient}\\"}}",
                "name": "$executionName",
                "stateMachineArn": "${settings.stateMachineArn}"
              }''';
  }
}