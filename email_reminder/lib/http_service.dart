import 'package:email_reminder/model/settings.dart';
import 'package:http/http.dart' as http;

class HttpService {
  HttpService({required this.client});

  final http.Client client;

  /* Sends a POST request to the AWS API Gateway of the Step Function. */
  Future<http.Response> postEmail(Settings settings, String body) async {
    var response = await client.post(Uri.parse(settings.apiUrl),
      headers: {"Content-Type": "application/json", "x-api-key": settings.apiKey},
      body: body
    );
    return response;
  }
}