abstract class HttpClient {
  Future<void> request(String url, {String method, Map<String, dynamic> body});
}
