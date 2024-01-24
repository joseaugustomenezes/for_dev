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
    late Uri uri;
    try {
      uri = Uri.parse(url);
    } catch (_) {
      throw HttpError.serverError;
    }
    final response = await client.post(uri, headers: headers, body: jsonBody);
    return _handleResponse(response);
  }

  Map<String, dynamic> _handleResponse(Response response) {
    switch (response.statusCode) {
      case 400:
        throw HttpError.badRequest;
      case 200:
        if (response.body.isNotEmpty) {
          final jsonResponse = jsonDecode(response.body);
          if (jsonResponse is Map<String, dynamic>) {
            return jsonResponse;
          }
        }
        return {};
      case 204:
      default:
        return {};
    }
  }
}
