abstract class HttpClient {
  Future<T> request<T extends Deserializable<T>>(String url,
      {String method, Map<String, dynamic> body});
}

abstract class Deserializable<T> {
  T fromMap(Map<String, dynamic> data);
}
