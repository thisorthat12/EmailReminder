import 'package:email_reminder/model/item.dart';
import 'package:email_reminder/model/settings.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Settings to map', () async {
    Settings settings = Settings(sender: "sender", recipient: "recipient", stateMachineArn: "stateMachineArn", apiUrl: "http://localhost", apiKey: "apiKey");
    Map<String, Object?> map = settings.toMap();
    expect(map.isNotEmpty, true);
  });

  test('Map to settings', () async {
    Map<String, Object?> map = {
                                'id': 1,
                                'sender': "sender",
                                'recipient': "recipient",
                                'state_machine_arn': "stateMachineArn",
                                'api_url': "http://localhost",
                                'api_key': "apiKey"
                              };

    Settings settings = Settings.fromMap(map);
    expect(settings.sender, "sender");
    expect(settings.recipient, "recipient");
    expect(settings.stateMachineArn, "stateMachineArn");
    expect(settings.apiUrl, "http://localhost");
    expect(settings.apiKey, "apiKey");
  });
}