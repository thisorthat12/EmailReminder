import 'package:isar/isar.dart';

part 'settings.g.dart';

@collection
class Settings {
  Id id = Isar.autoIncrement;
  String sender;
  String recipient;
  String stateMachineArn;
  String apiUrl;
  String apiKey;

  Settings({required this.sender, required this.recipient, required this.stateMachineArn, required this.apiUrl, required this.apiKey});

  Settings.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        sender = res["sender"],
        recipient = res["recipient"],
        stateMachineArn = res["state_machine_arn"],
        apiUrl = res["api_url"],
        apiKey = res["api_key"];

  Map<String, Object?> toMap() {
    return {'id': id, 'sender': sender, 'recipient': recipient, 'state_machine_arn': stateMachineArn, 'api_url': apiUrl, 'api_key': apiKey};
  }
}