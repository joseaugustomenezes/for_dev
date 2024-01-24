enum Methods { post }

abstract class HttpClient {
  Future<Map<String, dynamic>> request(String url,
      {required Methods method, Map<String, dynamic>? body});
}
