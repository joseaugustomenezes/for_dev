abstract class HttpClient {
  Future<Map<String, dynamic>> request(String url,
      {required String method, Map<String, dynamic>? body});
}
