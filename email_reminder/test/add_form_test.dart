import 'package:email_reminder/add_form.dart';
import 'package:email_reminder/isar_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'email_send_service_test.mocks.dart';

@GenerateMocks([IsarService])
void main() {
  testWidgets('OK', (tester) async {
      MockIsarService mockIsarService = MockIsarService();

      await tester.pumpWidget(
        MaterialApp(home: AddForm(isarService: mockIsarService),)
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

}