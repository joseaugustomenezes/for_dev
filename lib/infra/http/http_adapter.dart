import 'dart:convert';

import 'package:for_dev/data/http/http.dart';
import 'package:http/http.dart';

class HttpAdapter implements HttpClient {
  final Client client;

  HttpAdapter(this.client);

  @override
  Future<Map<String, dynamic>> request(String url,
      {required String method, Map<String, dynamic>? body}) async {
    final headers = {
      'content-type': 'application/json',
      'accept': 'application/json'
    };
    final jsonBody = body != null ? jsonEncode(body) : null;
    try {
      final response =
          await client.post(Uri.parse(url), headers: headers, body: jsonBody);
      if (response.body.isNotEmpty && response.statusCode != 204) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse is Map<String, dynamic>) {
          return jsonResponse;
        }
      }
      return {};
    } catch (e) {
      throw HttpError.serverError;
    }
  }
}
