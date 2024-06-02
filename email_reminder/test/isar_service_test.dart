import 'package:email_reminder/isar_service.dart';
import 'package:email_reminder/model/item.dart';
import 'package:email_reminder/model/settings.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';

void main() {

  late Isar isar;
  late IsarService isarService;

  final items = [Item(name: "name", boughtTime: DateTime.parse("2020-02-02"), expiryTime: DateTime.parse("2020-02-02").add(const Duration(days: 1))),
                Item(name: "test", boughtTime: DateTime.parse("2024-05-05"), expiryTime: DateTime.parse("2024-05-05").add(const Duration(days: 8)))];
  final setting = Settings(sender: "sender", recipient: "recipient", stateMachineArn: "stateMachineArn", apiUrl: "http://localhost", apiKey: "apiKey");

  setUpAll(() async {
    await Isar.initializeIsarCore(download: true);
    isar = await Isar.open([ItemSchema, SettingsSchema], directory: '' );

    await isar.writeTxn(() async {
      await isar.items.clear();
      await isar.settings.clear();
    });
  });

  tearDownAll(() {
    isar.close(deleteFromDisk: true);
  });

  setUp(() async {
    isarService = IsarService();
  });

  test('Get items', () async {
    await isarService.saveItem(items[0]);
    await isarService.saveItem(items[1]);
    final result = await isarService.getAllItems();
    expect(result.length, 2);
    Item resultItem = result[0];
    expect(resultItem.name, "name");
    expect(resultItem.boughtTime, DateTime.parse("2020-02-02"));
    expect(resultItem.expiryTime, DateTime.parse("2020-02-02").add(const Duration(days: 1)));

    Item resultItemAfterDelete = result[1];
    expect(resultItemAfterDelete.name, "test");
    expect(resultItemAfterDelete.boughtTime, DateTime.parse("2024-05-05"));
    expect(resultItemAfterDelete.expiryTime, DateTime.parse("2024-05-05").add(const Duration(days: 8)));
  });

  test('Delete item', () async {
    await isarService.saveItem(items[0]);
    await isarService.saveItem(items[1]);
    final result = await isarService.getAllItems();
    expect(result.length, 2);
    Item item1 = result[0];
    expect(item1.name, "name");
    expect(item1.boughtTime, DateTime.parse("2020-02-02"));
    expect(item1.expiryTime, DateTime.parse("2020-02-02").add(const Duration(days: 1)));
    Item item2 = result[1];
    expect(item2.name, "test");
    expect(item2.boughtTime, DateTime.parse("2024-05-05"));
    expect(item2.expiryTime, DateTime.parse("2024-05-05").add(const Duration(days: 8)));

    await isarService.deleteItem(item1.id);
    
    final resultAfterDelete = await isarService.getAllItems();
    expect(resultAfterDelete.length, 1);
    Item itemLeft = resultAfterDelete[0];
    expect(itemLeft.name, "test");
    expect(itemLeft.boughtTime, DateTime.parse("2024-05-05"));
    expect(itemLeft.expiryTime, DateTime.parse("2024-05-05").add(const Duration(days: 8)));
  });

  
  test('Get settings', () async {
    await isarService.saveSettings(setting);
    final result = await isarService.getSettings();
    expect(result.length, 1);
    Settings settings = result[0];
    expect(settings.apiUrl, "http://localhost");
    expect(settings.apiKey, "apiKey");
    expect(settings.stateMachineArn, "stateMachineArn");
    expect(settings.sender, "sender");
    expect(settings.recipient, "recipient");
  });
}