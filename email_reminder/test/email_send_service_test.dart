import 'dart:convert';

import 'package:email_reminder/email_send_service.dart';
import 'package:email_reminder/isar_service.dart';
import 'package:email_reminder/model/item.dart';
import 'package:email_reminder/model/settings.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/testing.dart';
import 'email_send_service_test.mocks.dart';


@GenerateMocks([IsarService])
void main() {
  test('Send email at expiry', () async {
    TestWidgetsFlutterBinding.ensureInitialized();
    MockIsarService mockIsarService = MockIsarService();
    Settings settings = Settings(sender: "sender", recipient: "recipient", stateMachineArn: "stateMachineArn", apiUrl: "apiUrl", apiKey: "apiKey");
    when(mockIsarService.getSettings()).thenAnswer((realInvocation) => Future.value([settings]));
    
    final mapJson = {'executionArn':'123', 'startDate':'123456'};
    MockClient((request) async {  
      return Response(json.encode(mapJson),200);
    });

    EmailSendService emailSendService = EmailSendService();
    Item item = Item(name: "name", boughtTime: DateTime.now(), expiryTime: DateTime.now());

    Response resp = await emailSendService.sendEmailAtExpiry(item);

    verify(mockIsarService.getSettings()).called(1);
    expect(resp.body, mapJson);
    expect(resp.statusCode, 200);
  });

}