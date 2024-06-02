import 'package:email_reminder/display.dart';
import 'package:email_reminder/email_send_service.dart';
import 'package:email_reminder/http_service.dart';
import 'package:email_reminder/isar_service.dart';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart';

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
  late HttpService httpService;
  late EmailSendService emailSendService;

  @override
  void initState() {
    super.initState();
    isarService = IsarService();
    httpService = HttpService(client: IOClient());
    emailSendService = EmailSendService(isarService: isarService, httpService: httpService);
  }

  @override
  Widget build(BuildContext context) {
    return Display(isarService: isarService, httpService: httpService, emailSendService: emailSendService,);
  }
}