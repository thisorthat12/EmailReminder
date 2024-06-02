import 'package:email_reminder/display.dart';
import 'package:email_reminder/email_send_service.dart';
import 'package:email_reminder/http_service.dart';
import 'package:email_reminder/isar_service.dart';
import 'package:email_reminder/model/item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import 'display_test.mocks.dart';

@GenerateMocks([IsarService, HttpService, EmailSendService])
void main() {
  testWidgets('OK', (tester) async {
    MockIsarService mockIsarService = MockIsarService();
    MockHttpService mockHttpService = MockHttpService();
    MockEmailSendService mockEmailSendService = MockEmailSendService();

    Item item = Item(name: "name", boughtTime: DateTime.parse("2020-02-02"), expiryTime: DateTime.parse("2020-02-02").add(const Duration(days: 1)));
    when(mockIsarService.getAllItems()).thenAnswer((realInvocation) => Future.value([item]),);
    when(mockEmailSendService.sendEmailWeekBefore(any)).thenAnswer((realInvocation) => Future.value(http.Response('body', 200)));
    when(mockEmailSendService.sendEmailAtExpiry(any)).thenAnswer((realInvocation) => Future.value(http.Response('body', 200)));

    await tester.pumpWidget(
      MaterialApp(home: Display(isarService: mockIsarService, httpService: mockHttpService, emailSendService: mockEmailSendService,),)
    );

    await tester.pump();

    expect(find.text("name"), findsOneWidget);
    expect(find.text(item.boughtTime.toString()), findsOneWidget);
    expect(find.text(item.expiryTime.toString()), findsOneWidget); 

    final addButton = find.byKey(const Key("addButton"));
    await tester.tap(addButton);

    await tester.pump();
  });

  testWidgets('OK - dialog press back', (tester) async {
    MockIsarService mockIsarService = MockIsarService();
    MockHttpService mockHttpService = MockHttpService();
    MockEmailSendService mockEmailSendService = MockEmailSendService();

    Item item = Item(name: "name", boughtTime: DateTime.parse("2020-02-02"), expiryTime: DateTime.parse("2020-02-02").add(const Duration(days: 1)));
    when(mockIsarService.getAllItems()).thenAnswer((realInvocation) => Future.value([item]),);
    when(mockEmailSendService.sendEmailWeekBefore(any)).thenAnswer((realInvocation) => Future.value(http.Response('body', 200)));
    when(mockEmailSendService.sendEmailAtExpiry(any)).thenAnswer((realInvocation) => Future.value(http.Response('body', 200)));

    await tester.pumpWidget(
      MaterialApp(home: Display(isarService: mockIsarService, httpService: mockHttpService, emailSendService: mockEmailSendService,),)
    );

    await tester.pump();

    final nameField = find.text("name");
    await tester.longPress(nameField);

    await tester.pump();

    final dialogBackButton = find.byKey(const Key("dialogBackButton"));
    await tester.tap(dialogBackButton);

    await tester.pump();
  });

  testWidgets('OK - dialog press delete', (tester) async {
    MockIsarService mockIsarService = MockIsarService();
    MockHttpService mockHttpService = MockHttpService();
    MockEmailSendService mockEmailSendService = MockEmailSendService();

    Item item = Item(name: "name", boughtTime: DateTime.parse("2020-02-02"), expiryTime: DateTime.parse("2020-02-02").add(const Duration(days: 1)));
    when(mockIsarService.getAllItems()).thenAnswer((realInvocation) => Future.value([item]),);
    when(mockEmailSendService.sendEmailWeekBefore(any)).thenAnswer((realInvocation) => Future.value(http.Response('body', 200)));
    when(mockEmailSendService.sendEmailAtExpiry(any)).thenAnswer((realInvocation) => Future.value(http.Response('body', 200)));

    await tester.pumpWidget(
      MaterialApp(home: Display(isarService: mockIsarService, httpService: mockHttpService, emailSendService: mockEmailSendService,),)
    );

    await tester.pump();

    final nameField = find.text("name");
    await tester.longPress(nameField);

    await tester.pump();

    final dialogDeleteButton = find.byKey(const Key("dialogDeleteButton"));
    await tester.tap(dialogDeleteButton);

    await tester.pump();
  });
}