import 'dart:async';
import 'dart:io';
import 'package:email_reminder/item.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DatabaseHelper {
  static final DatabaseHelper _databaseHelper = DatabaseHelper._();

  DatabaseHelper._();

  late Database db;

  factory DatabaseHelper() {
    return _databaseHelper;
  }

  Future<void> initDB() async {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "demo_always_copy_asset_example.db");

    // delete existing if any
    await deleteDatabase(path);

    // Make sure the parent directory exists
    try {
      await Directory(dirname(path)).create(recursive: true);
    } catch (_) {}

    // Copy from asset
    ByteData data = await rootBundle.load(url.join("assets", "items.db"));
    List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await File(path).writeAsBytes(bytes, flush: true);

    db = await openDatabase(path, version: 1, readOnly: true,
      onCreate: (Database db, int version) async {
        // When creating the db, create the table
        await db.execute(
              """
                CREATE TABLE items (
                  id INTEGER PRIMARY KEY AUTOINCREMENT, 
                  name TEXT NOT NULL,
                  bought_time DateTimeOffset NOT NULL, 
                  expiry_time DateTimeOffset NOT NULL
                )
              """,
            );
      });
  }

  Future<int> insertItem(Item item) async {
    int result = await db.insert('items', item.toMap());
    return result;
  }

  Future<int> updateItem(Item item) async {
    int result = await db.update(
      'items',
      item.toMap(),
      where: "id = ?",
      whereArgs: [item.id],
    );
    return result;
  }

  Future<List<Item>> retrieveItems() async {
    final List<Map<String, Object?>> queryResult = await db.query('items');
    return queryResult.map((e) => Item.fromMap(e)).toList();
  }

  Future<void> deleteItem(int id) async {
    await db.delete(
      'items',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}