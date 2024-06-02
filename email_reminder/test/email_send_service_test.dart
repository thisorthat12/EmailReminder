import 'dart:convert';
import 'package:email_reminder/email_send_service.dart';
import 'package:email_reminder/http_service.dart';
import 'package:email_reminder/isar_service.dart';
import 'package:email_reminder/model/item.dart';
import 'package:email_reminder/model/settings.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'email_send_service_test.mocks.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([IsarService, HttpService])
void main() {
  test('Send email at expiry', () async {
    MockHttpService mockHttpService = MockHttpService();
    MockIsarService mockIsarService = MockIsarService();

    Settings settings = Settings(sender: "sender", recipient: "recipient", stateMachineArn: "stateMachineArn", apiUrl: "http://localhost", apiKey: "apiKey");
    when(mockIsarService.getSettings()).thenAnswer((realInvocation) => Future.value([settings]));

    final mapResponse = {'executionArn':'123', 'startDate':'123456'};
    when(mockHttpService.postEmail(settings, any)).thenAnswer((realInvocation) => Future.value(http.Response(json.encode(mapResponse), 200)));
    
    EmailSendService emailSendService = EmailSendService(isarService: mockIsarService, httpService: mockHttpService);
    Item item = Item(name: "name", boughtTime: DateTime.now(), expiryTime: DateTime.now().add(const Duration(days: 1)));
    Response resp = await emailSendService.sendEmailAtExpiry(item);

    verify(mockIsarService.getSettings()).called(1);
    expect(resp.body, json.encode(mapResponse));
    expect(resp.statusCode, 200);
  });

  test('Send email one week before', () async {
    MockHttpService mockHttpService = MockHttpService();
    MockIsarService mockIsarService = MockIsarService();

    Settings settings = Settings(sender: "sender", recipient: "recipient", stateMachineArn: "stateMachineArn", apiUrl: "http://localhost", apiKey: "apiKey");
    when(mockIsarService.getSettings()).thenAnswer((realInvocation) => Future.value([settings]));

    final mapResponse = {'executionArn':'123', 'startDate':'123456'};
    when(mockHttpService.postEmail(settings, any)).thenAnswer((realInvocation) => Future.value(http.Response(json.encode(mapResponse), 200)));

    EmailSendService emailSendService = EmailSendService(isarService: mockIsarService, httpService: mockHttpService);
    Item item = Item(name: "name", boughtTime: DateTime.now(), expiryTime: DateTime.now().add(const Duration(days: 8)));
    Response resp = await emailSendService.sendEmailWeekBefore(item);

    verify(mockIsarService.getSettings()).called(1);
    expect(resp.body, json.encode(mapResponse));
    expect(resp.statusCode, 200);
  });

  test('Send email one week before while in week of expiry', () async {
    MockHttpService mockHttpService = MockHttpService();
    MockIsarService mockIsarService = MockIsarService();

    Settings settings = Settings(sender: "sender", recipient: "recipient", stateMachineArn: "stateMachineArn", apiUrl: "http://localhost", apiKey: "apiKey");
    when(mockIsarService.getSettings()).thenAnswer((realInvocation) => Future.value([settings]));

    EmailSendService emailSendService = EmailSendService(isarService: mockIsarService, httpService: mockHttpService);
    Item item = Item(name: "name", boughtTime: DateTime.now(), expiryTime: DateTime.now().add(const Duration(days: 1)));
    Response resp = await emailSendService.sendEmailWeekBefore(item);

    verify(mockIsarService.getSettings()).called(1);
    expect(resp.body, '');
    expect(resp.statusCode, 400);
  });
}