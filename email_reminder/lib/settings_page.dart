import 'package:email_reminder/isar_service.dart';
import 'package:email_reminder/model/settings.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget{
  SettingsPage({
    required this.isarService,
    super.key,
  });

  final IsarService isarService;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {  

  final senderController = TextEditingController();
  final recipientController = TextEditingController();
  final stateMachineController = TextEditingController();
  final apiUrlController = TextEditingController();
  final apiKeyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Settings"),
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
                          controller: senderController,
                          decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                              borderSide:BorderSide(color: Colors.blueGrey, width: 2.0)),
                              border: OutlineInputBorder(borderSide: BorderSide()),
                              fillColor: Colors.white,
                              filled: true,
                              prefixIcon: Icon(Icons.email),
                              hintText: 'Enter the email address for the sender.', 
                              labelText: 'Sender email'),
                        ),
                      ),
                      SizedBox(height: 10,),
                      SizedBox(
                        width: 400,
                        child: TextFormField(
                          controller: recipientController,
                          decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                              borderSide:BorderSide(color: Colors.blueGrey, width: 2.0)),
                              border: OutlineInputBorder(borderSide: BorderSide()),
                              fillColor: Colors.white,
                              filled: true,
                              prefixIcon: Icon(Icons.email),
                              hintText: 'Enter the email address for the recipient.', 
                              labelText: 'Recipient email'),
                        ),
                      ),
                      SizedBox(height: 10,),
                      SizedBox(
                        width: 400,
                        child: TextFormField(
                          controller: stateMachineController,
                          decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                              borderSide:BorderSide(color: Colors.blueGrey, width: 2.0)),
                              border: OutlineInputBorder(borderSide: BorderSide()),
                              fillColor: Colors.white,
                              filled: true,
                              prefixIcon: Icon(Icons.more_vert),
                              hintText: 'Enter the Step Function arn.',
                              labelText: 'Step Function arn'),
                        ),
                      ),
                      SizedBox(height: 10,),
                      SizedBox(
                        width: 400,
                        child: TextFormField(
                          controller: apiUrlController,
                          decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                              borderSide:BorderSide(color: Colors.blueGrey, width: 2.0)),
                              border: OutlineInputBorder(borderSide: BorderSide()),
                              fillColor: Colors.white,
                              filled: true,
                              prefixIcon: Icon(Icons.link),
                              hintText: 'Enter API Gateway url.',
                              labelText: 'API Gateway url'),
                        ),
                      ),
                      SizedBox(height: 10,),
                      SizedBox(
                        width: 400,
                        child: TextFormField(
                          controller: apiKeyController,
                          decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                              borderSide:BorderSide(color: Colors.blueGrey, width: 2.0)),
                              border: OutlineInputBorder(borderSide: BorderSide()),
                              fillColor: Colors.white,
                              filled: true,
                              prefixIcon: Icon(Icons.key),
                              hintText: 'Enter the API key for the API Gateway.',
                              labelText: 'API key'),
                        ),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                margin:
                                    EdgeInsets.symmetric(vertical: 10),
                                child: ElevatedButton(
                                  onPressed: () {
                                    saveSettings();
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Save'),
                                )),
                          ])
                      ]
                    )
                  )
                ),
              ],
            )
          ),
        ],
      )  
    );
  }

  Future<void> saveSettings() async {
    String sender = senderController.text;
    String recipient = recipientController.text;
    String stateMachineArn = stateMachineController.text;
    String apiUrl = apiUrlController.text;
    String apiKey = apiKeyController.text;

    Settings settings = Settings(sender: sender, recipient: recipient, stateMachineArn: stateMachineArn, apiUrl: apiUrl, apiKey: apiKey);

    await widget.isarService.saveSettings(settings);
  }
}