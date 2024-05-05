import 'package:isar/isar.dart';

part 'item.g.dart';

@collection
class Item {
  Id id = Isar.autoIncrement;
  String name;
  DateTime boughtTime;
  DateTime expiryTime;

  Item({required this.name, required this.boughtTime, required this.expiryTime});

  Item.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        name = res["name"],
        boughtTime = res["bought_time"],
        expiryTime = res["expiry_time"];

  Map<String, Object?> toMap() {
    return {'id': id, 'name': name, 'bought_time': boughtTime, 'expiry_time': expiryTime};
  }
}