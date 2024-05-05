import 'package:email_reminder/item.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


final itemsRepositoryProvider = Provider<IsarDatabase>((ref) {
  return IsarDatabase();
});

final itemsListStreamProvider = StreamProvider.autoDispose<List<Item?>>((ref) {
  final itemsRepository = ref.watch(itemsRepositoryProvider);
  return itemsRepository.listenToItems();
});

class IsarDatabase {

  late Future<Isar> db;

  IsarDatabase() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    final dir = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [ItemSchema],
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

  Stream<List<Item>> listenToItems() async* {
    final isar = await db;
    yield* isar.items.where().watch();
  }
}