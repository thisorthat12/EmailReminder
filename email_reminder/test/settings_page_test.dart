import 'package:email_reminder/isar_service.dart';
import 'package:email_reminder/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'email_send_service_test.mocks.dart';

@GenerateMocks([IsarService])
void main() {
  testWidgets('OK', (tester) async {
      MockIsarService mockIsarService = MockIsarService();

      await tester.pumpWidget(
        MaterialApp(home: SettingsPage(isarService: mockIsarService),)
      );

      final senderFieldKey = find.byKey(const Key("senderField"));
      await tester.enterText(senderFieldKey, "sender");
      expect(find.text("sender"), findsOneWidget);

      final recipientFieldKey = find.byKey(const Key("recipientField"));
      await tester.enterText(recipientFieldKey, "recipient");
      expect(find.text("recipient"), findsOneWidget);

      final stepFunctionFieldKey = find.byKey(const Key("stepFunctionField"));
      await tester.enterText(stepFunctionFieldKey, "arn");
      expect(find.text("arn"), findsOneWidget); 

      final apiUrlFieldKey = find.byKey(const Key("apiUrlField"));
      await tester.enterText(apiUrlFieldKey, "localhost");
      expect(find.text("localhost"), findsOneWidget); 

      final apiKeyFieldKey = find.byKey(const Key("apiKeyField"));
      await tester.enterText(apiKeyFieldKey, "12345");
      expect(find.text("12345"), findsOneWidget); 

      final saveButton = find.byKey(const Key("saveButton"));
      await tester.tap(saveButton);

      await tester.pump();
    });

}