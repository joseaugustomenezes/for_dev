import 'package:for_dev/data/http/http.dart';
import 'package:for_dev/domain/usecases/usecases.dart';

class RemoteAuthentication {
  final HttpClient httpClient;
  final String url;

  RemoteAuthentication({required this.httpClient, required this.url});

  Future<void> auth(AuthenticationParams params) async {
    final body = {'email': params.email, 'password': params.secret};
    httpClient.request(url, method: 'post', body: body);
  }
}
