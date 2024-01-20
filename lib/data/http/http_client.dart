abstract class HttpClient {
  Future<Map<String, dynamic>> request(String url,
      {String method, Map<String, dynamic> body});
}
