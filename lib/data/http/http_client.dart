abstract class HttpClient {
  Future<T> request<T extends Serializable<T>>(String url,
      {String method, Map<String, dynamic> body});
}

abstract class Serializable<T> {
  T fromJson(Map<String, dynamic> json);
}
