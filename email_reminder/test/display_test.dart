import 'package:email_reminder/display.dart';
import 'package:email_reminder/email_send_service.dart';
import 'package:email_reminder/http_service.dart';
import 'package:email_reminder/isar_service.dart';
import 'package:email_reminder/model/item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import 'display_test.mocks.dart';

@GenerateMocks([IsarService, HttpService, EmailSendService])
void main() {

  final DateFormat dateFormatter = DateFormat('yyyy-MM-dd');

  expectItem(Item item) {
    expect(find.text(item.name), findsOneWidget);
    expect(find.text(dateFormatter.format(item.boughtTime)), findsOneWidget);
    expect(find.text(dateFormatter.format(item.expiryTime)), findsOneWidget); 
  }
  
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

    expectItem(item);

    final addButton = find.byKey(const Key("addButton"));
    await tester.tap(addButton);

    await tester.pump();
  });

  testWidgets('OK - multiple items are sorted by expiry date', (tester) async {
    MockIsarService mockIsarService = MockIsarService();
    MockHttpService mockHttpService = MockHttpService();
    MockEmailSendService mockEmailSendService = MockEmailSendService();

    Item item1 = Item(name: "name1", boughtTime: DateTime.parse("2020-01-01"), expiryTime: DateTime.parse("2020-01-01").add(const Duration(days: 1)));
    Item item2 = Item(name: "name2", boughtTime: DateTime.parse("2021-02-02"), expiryTime: DateTime.parse("2021-02-02").add(const Duration(days: 1)));
    Item item3 = Item(name: "name3", boughtTime: DateTime.parse("2022-03-03"), expiryTime: DateTime.parse("2022-03-03").add(const Duration(days: 1)));
    when(mockIsarService.getAllItems()).thenAnswer((realInvocation) => Future.value([item3, item2, item1]),);
    when(mockEmailSendService.sendEmailWeekBefore(any)).thenAnswer((realInvocation) => Future.value(http.Response('body', 200)));
    when(mockEmailSendService.sendEmailAtExpiry(any)).thenAnswer((realInvocation) => Future.value(http.Response('body', 200)));

    await tester.pumpWidget(
      MaterialApp(home: Display(isarService: mockIsarService, httpService: mockHttpService, emailSendService: mockEmailSendService,),)
    );

    await tester.pump();

    expectItem(item1); 
    expectItem(item2);
    expectItem(item3);


    DataTable table = tester.widgetList<DataTable>(find.byType(DataTable)).elementAt(0);
    List<DataRow> rows = table.rows;
    Text name1 = rows.elementAt(0).cells.elementAt(0).child as Text;
    expect(name1.data, "name1");
    Text name2 = rows.elementAt(1).cells.elementAt(0).child as Text;
    expect(name2.data, "name2");
    Text name3 = rows.elementAt(2).cells.elementAt(0).child as Text;
    expect(name3.data, "name3");

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