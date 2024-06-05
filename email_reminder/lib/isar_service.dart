
import 'package:email_reminder/model/item.dart';
import 'package:email_reminder/model/settings.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarService {

  late Future<Isar> db;

  IsarService() {
    db = openDB();
  }

  /* Opens a database instance should it not exist already. */
  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      return await Isar.open(
        [ItemSchema, SettingsSchema],
        inspector: true,
        directory: dir.path,
      );
    }

    return Future.value(Isar.getInstance());
  }

  Future<void> saveItem(Item item) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.items.putSync(item));
  }

  Future<List<Item>> getAllItems() async {
    final isar = await db;
    return await isar.items.where().findAll();
  }

  Future<void> deleteItem(int id) async {
    final isar = await db;
    isar.writeTxnSync<bool>(() => isar.items.deleteSync(id));
  }

  Future<void> saveSettings(Settings settings) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.settings.putSync(settings));
  }

  Future<List<Settings>> getSettings() async {
    final isar = await db;
    return await isar.settings.where().findAll();
  }
}