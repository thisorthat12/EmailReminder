import 'package:email_reminder/form.dart';
import 'package:email_reminder/isar_service.dart';
import 'package:email_reminder/model/item.dart';
import 'package:email_reminder/model/settings.dart';
import 'package:email_reminder/settings_page.dart';
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
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {

  late IsarService isarService;

  late Future<List<Item>> _items = _getAllItems();

  @override
  void initState() {
    super.initState();
    isarService = IsarService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Email Reminders'),
        actions: [
          IconButton(onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SettingsPage(isarService: isarService),
              ),
            );
          }, 
          icon: Icon(Icons.settings))
        ],
      ),
      body: FutureBuilder(
        future: _items,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
            return ListView(
              children: [
                Align(child: _createDataTable(snapshot.data)),
                _createAddField(),
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Future<List<Item>> _getAllItems() {
    return isarService.getAllItems();
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
    return items
        .mapIndexed((index, item) => DataRow(
                cells: [
                  DataCell(Text(item.name)),
                  DataCell(Text(item.boughtTime.toString())),
                  DataCell(Text(item.expiryTime.toString()))
                ],
                onLongPress: () async {
                  _showDialog(item.id).then((_) => setState(() {
                    _items = _getAllItems();
                  }));
                },
                ))
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
                builder: (context) => AddForm(isarService: isarService),
              ),
            ).then((_) => setState(() {
                _items = _getAllItems();
              })
            );
          },
          child: Text('Add'),
        ),
      ],
    );
  }

  Future<void> _showDialog(int id) async {
    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
                title: Text("Delete item?"),
            titleTextStyle: 
              TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,fontSize: 20),
              actionsOverflowButtonSpacing: 20,
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  }, 
                  child: Text("Back"),
                ),
                ElevatedButton(
                  onPressed: () {
                    isarService.deleteItem(id);
                    Navigator.of(context).pop(true);
                  }, 
                  child: Text("Delete"),
                ),
              ],
              content: Text("Deleted successfully"),
              );
          },
        );
      },
    );
  }
}