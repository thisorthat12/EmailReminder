import 'package:email_reminder/model/item.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Item to map', () async {
    Item item = Item(name: "name", boughtTime: DateTime.now(), expiryTime: DateTime.now().add(const Duration(days: 1)));
    Map<String, Object?> map = item.toMap();
    expect(map.isNotEmpty, true);
  });

  test('Map to item', () async {
    DateTime boughtTime = DateTime.parse("2020-02-02");
    DateTime expiryTime = DateTime.parse("2020-02-02").add(const Duration(days: 1));
    Map<String, Object?> map = {
                                'id': 1,
                                'name': "name",
                                'bought_time': boughtTime,
                                'expiry_time': expiryTime
                              };

    Item item = Item.fromMap(map);
    expect(item.name, "name");
    expect(item.boughtTime, DateTime.parse("2020-02-02"));
    expect(item.expiryTime, DateTime.parse("2020-02-02").add(const Duration(days: 1)));
  });
}