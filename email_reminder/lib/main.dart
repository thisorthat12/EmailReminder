import 'package:email_reminder/form.dart';
import 'package:email_reminder/isar_database.dart';
import 'package:email_reminder/item.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

void main() {
  runApp(
    MaterialApp(
      home: MyApp(),
    )
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  late IsarDatabase isarDatabase;

  List<bool> _selected = [];

  @override
  void initState() {
    super.initState();
    isarDatabase = IsarDatabase();
  }
  
  late Future<List<Item>> _items = _getAllItems();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DataTable Demo'),
      ),
     /*  body: StreamBuilder(
        stream: listenToItems(),
        builder:(context, snapshot) {
          if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
            return ListView(
              children: [
                _createDataTable(snapshot.data!),
                _createAddField(),
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ) */
      body: FutureBuilder(
        future: _items,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
            return ListView(
              children: [
                _createDataTable(snapshot.data),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddForm(isarDatabase: isarDatabase),
                          ),
                        );
                        setState(() {
                          _items = _getAllItems();
                        });
                      },
                      child: Text('Next'),
                    ),
                  ],
                ),
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Future<List<Item>> _getAllItems() {
    return isarDatabase.getAllItems();
  }

  Stream<List<Item>> listenToItems() {
    return isarDatabase.listenToItems();
  }
  
  DataTable _createDataTable(List<Item> items) {
    return DataTable(columns: _createColumns(), rows: _createRows(items));
  }
  
  List<DataColumn> _createColumns() {
    return [
      DataColumn(label: Text('Name')),
      DataColumn(label: Text('Bought Date')),
      DataColumn(label: Text('Expiry Date'))
    ];
  }
  
  List<DataRow> _createRows(List<Item> items) {
    _selected = List<bool>.generate(items.length, (int index) => false);;
    return items
        .mapIndexed((index, item) => DataRow(
                cells: [
                  DataCell(Text(item.name)),
                  DataCell(Text(item.boughtTime.toString())),
                  DataCell(Text(item.expiryTime.toString()))
                ],
                selected: _selected[index],
                onSelectChanged: (bool? selected) {
                  setState(() {
                    _selected[index] = selected!;
                  });
                }))
        .toList();
  }

  Row _createAddField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddForm(isarDatabase: isarDatabase),
              ),
            );
          },
          child: Text('Next'),
        ),
      ],
    );
  }
}