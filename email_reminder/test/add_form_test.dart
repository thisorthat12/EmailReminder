import 'package:email_reminder/add_form.dart';
import 'package:email_reminder/email_send_service.dart';
import 'package:email_reminder/http_service.dart';
import 'package:email_reminder/isar_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import 'add_form_test.mocks.dart';

@GenerateMocks([IsarService, HttpService, EmailSendService])
void main() {
  testWidgets('OK', (tester) async {
    MockIsarService mockIsarService = MockIsarService();
    MockHttpService mockHttpService = MockHttpService();
    MockEmailSendService mockEmailSendService = MockEmailSendService();

    await tester.pumpWidget(
      MaterialApp(home: AddForm(isarService: mockIsarService, httpService: mockHttpService, emailSendService: mockEmailSendService,),)
    );

    final nameFieldKey = find.byKey(const Key("nameField"));
    await tester.enterText(nameFieldKey, "name");
    expect(find.text("name"), findsOneWidget);

    final boughtFieldKey = find.byKey(const Key("boughtField"));
    await tester.enterText(boughtFieldKey, "2020-02-02");
    expect(find.text("2020-02-02"), findsOneWidget);

    final expiryFieldKey = find.byKey(const Key("expiryField"));
    await tester.enterText(expiryFieldKey, "1");
    expect(find.text("1"), findsOneWidget); 
  });

  testWidgets('OK with submit', (tester) async {
    MockIsarService mockIsarService = MockIsarService();
    MockHttpService mockHttpService = MockHttpService();
    MockEmailSendService mockEmailSendService = MockEmailSendService();

    when(mockEmailSendService.sendEmailWeekBefore(any)).thenAnswer((realInvocation) => Future.value(http.Response('body', 200)));
    when(mockEmailSendService.sendEmailAtExpiry(any)).thenAnswer((realInvocation) => Future.value(http.Response('body', 200)));

    await tester.pumpWidget(
      MaterialApp(home: AddForm(isarService: mockIsarService, httpService: mockHttpService, emailSendService: mockEmailSendService,),)
    );

    final nameFieldKey = find.byKey(const Key("nameField"));
    await tester.enterText(nameFieldKey, "name");
    expect(find.text("name"), findsOneWidget);

    final boughtFieldKey = find.byKey(const Key("boughtField"));
    await tester.enterText(boughtFieldKey, "2020-02-02");
    expect(find.text("2020-02-02"), findsOneWidget);

    final expiryFieldKey = find.byKey(const Key("expiryField"));
    await tester.enterText(expiryFieldKey, "1");
    expect(find.text("1"), findsOneWidget); 

    final submitButton = find.byKey(const Key("submitButton"));
    await tester.tap(submitButton);

    await tester.pump();
  });
}