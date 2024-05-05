import 'package:email_reminder/isar_database.dart';
import 'package:email_reminder/item.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class AddForm extends StatefulWidget{
  AddForm({
    required this.isarDatabase,
    super.key,
  });

  final IsarDatabase isarDatabase;

  @override
  State<AddForm> createState() => _AddFormState();
}

class _AddFormState extends State<AddForm> {  

  final nameController = TextEditingController();
  final boughtController = TextEditingController();
  final expiresInController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Title"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      TextFormField(
                        controller: nameController,
                        decoration: const InputDecoration(
                            hintText: 'Enter the item name', labelText: 'Name'),
                      ),
                      TextFormField(
                        controller: boughtController,
                        decoration: const InputDecoration(
                            hintText: 'Enter the bought date (format: 2012-02-27)', labelText: 'Bought date'),
                      ),
                      TextFormField(
                        controller: expiresInController,
                        decoration: const InputDecoration(
                            hintText: 'Enter in how many months the item will expire',
                            labelText: 'Expires in'),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                                margin:
                                    EdgeInsets.symmetric(vertical: 10),
                                child: ElevatedButton(
                                  onPressed: () {
                                    addItem();
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Submit'),
                                )),
                          ])
                      ]))),
              ],
            )),
          ],
      )  
    );
  }

  Future<void> addItem() async {
    String name = nameController.text;
    String boughtTime = boughtController.text;
    String expiresIn = expiresInController.text;

    DateTime boughtTimeParsed = DateTime.parse(boughtTime);
    DateTime expiryTime = Jiffy.parse(boughtTime).add(months: int.parse(expiresIn)).dateTime;

    Item item = Item(name: name, boughtTime: boughtTimeParsed, expiryTime: expiryTime);
    await widget.isarDatabase.saveItem(item);
    resetData();
  }

  void resetData() {
    nameController.clear();
    boughtController.clear();
    expiresInController.clear();
  }
}