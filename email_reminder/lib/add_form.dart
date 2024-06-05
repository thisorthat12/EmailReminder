import 'package:email_reminder/email_send_service.dart';
import 'package:email_reminder/http_service.dart';
import 'package:email_reminder/isar_service.dart';
import 'package:email_reminder/model/item.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';


class AddForm extends StatefulWidget{
  AddForm({
    required this.isarService,
    required this.httpService,
    required this.emailSendService,
    super.key,
  });

  final IsarService isarService;
  final HttpService httpService;
  final EmailSendService emailSendService;

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
        centerTitle: true,
        title: Text("Add a reminder"),
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                      SizedBox(
                        width: 400,
                        child: TextFormField(
                          key: const Key('nameField'),
                          controller: nameController,
                          decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                              borderSide:BorderSide(color: Colors.blueGrey, width: 2.0)),
                              border: OutlineInputBorder(borderSide: BorderSide()),
                              fillColor: Colors.white,
                              filled: true,
                              prefixIcon: Icon(Icons.account_box),
                              hintText: 'Enter the item name.', 
                              labelText: 'Name'),
                        ),
                      ),
                      SizedBox(height: 10,),
                      SizedBox(
                        width: 400,
                        child: TextFormField(
                          key: const Key('boughtField'),
                          controller: boughtController,
                          decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                              borderSide:BorderSide(color: Colors.blueGrey, width: 2.0)),
                              border: OutlineInputBorder(borderSide: BorderSide()),
                              fillColor: Colors.white,
                              filled: true,
                              prefixIcon: Icon(Icons.date_range),
                              hintText: 'Enter the bought date (format: 2012-02-27).', 
                              labelText: 'Bought date'),
                        ),
                      ),
                      SizedBox(height: 10,),
                      SizedBox(
                        width: 400,
                        child: TextFormField(
                          key: const Key('expiryField'),
                          controller: expiresInController,
                          decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                              borderSide:BorderSide(color: Colors.blueGrey, width: 2.0)),
                              border: OutlineInputBorder(borderSide: BorderSide()),
                              fillColor: Colors.white,
                              filled: true,
                              prefixIcon: Icon(Icons.date_range),
                              hintText: 'Enter in how many months the item will expire.',
                              labelText: 'Expires in'),
                        ),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                margin:
                                    EdgeInsets.symmetric(vertical: 10),
                                child: ElevatedButton(
                                  key: const Key("submitButton"),
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

  /* Adds an item to the database. */
  Future<void> addItem() async {
    String name = nameController.text;
    String boughtTime = boughtController.text;
    String expiresIn = expiresInController.text;
    
    DateTime boughtTimeParsed = DateTime.parse(boughtTime);
    DateTime expiryTime = Jiffy.parse(boughtTime).add(months: int.parse(expiresIn)).dateTime;

    Item item = Item(name: name, boughtTime: boughtTimeParsed, expiryTime: expiryTime);
    await widget.isarService.saveItem(item);
    sendEmails(item);
    clearFormFields();
  }

  /* Calls the email send service to send the emails. */
  Future<void> sendEmails(Item item) async {
    await widget.emailSendService.sendEmailWeekBefore(item);
    await widget.emailSendService.sendEmailAtExpiry(item);
  }

  /* Clears the fields of the form. */
  void clearFormFields() {
    nameController.clear();
    boughtController.clear();
    expiresInController.clear();
  }
}