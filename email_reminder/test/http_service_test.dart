import 'dart:convert';

import 'package:email_reminder/http_service.dart';
import 'package:email_reminder/model/settings.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import 'http_service_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  test('Send email at expiry', () async {
    final client = MockClient();

    Settings settings = Settings(sender: "sender", recipient: "recipient", stateMachineArn: "stateMachineArn", apiUrl: "http://localhost", apiKey: "apiKey");
    String body = "test";
    final mapResponse = {'executionArn':'123', 'startDate':'123456'};
    when(client.post(
            Uri.parse('http://localhost'),
            headers: {"Content-Type": "application/json", "x-api-key": settings.apiKey},
            body: body,
            encoding: null))
          .thenAnswer((_) async => http.Response(json.encode(mapResponse), 200));

    HttpService httpService = HttpService(client: client);
    
    
    Response resp = await httpService.postEmail(settings, body);

    expect(resp.body, json.encode(mapResponse));
    expect(resp.statusCode, 200);
  });
}