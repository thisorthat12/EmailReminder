import 'package:collection/collection.dart';
import 'package:email_reminder/add_form.dart';
import 'package:email_reminder/email_send_service.dart';
import 'package:email_reminder/http_service.dart';
import 'package:email_reminder/isar_service.dart';
import 'package:email_reminder/model/item.dart';
import 'package:email_reminder/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Display extends StatefulWidget{
  Display({
    required this.isarService,
    required this.httpService,
    required this.emailSendService,
    super.key,
  });

  final IsarService isarService;
  final HttpService httpService;
  final EmailSendService emailSendService;

  @override
  State<Display> createState() => _DisplayState();
}

class _DisplayState extends State<Display> {

  late Future<List<Item>> _items = _getAllItems();
  final DateFormat dateFormatter = DateFormat('yyyy-MM-dd');
  bool isAscending = true;
  int sortColumnIndex = 0;

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
                builder: (context) => SettingsPage(isarService: widget.isarService),
              ),
            );
          }, 
          icon: Icon(Icons.settings, size: 40,))
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

  /* Retrieves all items to be displayed. */
  Future<List<Item>> _getAllItems() {
    return widget.isarService.getAllItems();
  }
  
  /* Creates a table containing all items to be displayed. */
  DataTable _createDataTable(List<Item> items) {
    sortByExpiry(isAscending, items);
    return DataTable(
      sortAscending: isAscending,
      sortColumnIndex: sortColumnIndex,
      columns: _createColumns(items), 
      rows: _createRows(items));
  }

  void sortByExpiry(bool ascending, List<Item> items) {
    if (ascending) {
      items.sort((a, b) => a.expiryTime.compareTo(b.expiryTime));
    } else {
      items.sort((a, b) => a.expiryTime.compareTo(b.expiryTime));
    }
  }
  
  /* The names of the columns on the home page. */
  List<DataColumn> _createColumns(List<Item> items) {
    return [
      DataColumn(
        label: Text('Name')),
      DataColumn(
        label: Text('Bought Date')),
      DataColumn(
        label: Text('Expiry Date'))
    ];
  }
  
  /* Creates an item row to be displayed on the home page. */
  List<DataRow> _createRows(List<Item> items) {
    return items
        .mapIndexed((index, item) => DataRow(
                cells: [
                  DataCell(Text(item.name,)),
                  DataCell(Text(dateFormatter.format(item.boughtTime))),
                  DataCell(Text(dateFormatter.format(item.expiryTime)))
                ],
                onLongPress: () async {
                  _showDialog(item.id).then((_) => setState(() {
                    _items = _getAllItems();
                  }));
                },
                ))
        .toList();
  }

  /* Displays an "add" button that when pressed displays the form to add a new item.
     After returning from the form, the home page is rebuilt. */
  Row _createAddField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          key: const Key("addButton"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddForm(isarService: widget.isarService, httpService: widget.httpService, emailSendService: widget.emailSendService,),
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

  /* A dialog to be shown after long pressing an item.
     The selected item can be deleted through this dialog.
     Backing out or deleting will return the user to the home page. */
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
                  key: const Key("dialogBackButton"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }, 
                  child: Text("Back"),
                ),
                ElevatedButton(
                  key: const Key("dialogDeleteButton"),
                  onPressed: () {
                    widget.isarService.deleteItem(id);
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