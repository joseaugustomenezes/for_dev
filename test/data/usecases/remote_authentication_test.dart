import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<HttpClient>()])
import 'remote_authentication_test.mocks.dart';

class RemoteAuthentication {
  final HttpClient httpClient;
  final String url;

  RemoteAuthentication({required this.httpClient, required this.url});

  Future<void> auth() async {
    httpClient.request(url, method: 'post');
  }
}

abstract class HttpClient {
  Future<void> request(String url, {String method});
}

void main() {
  late RemoteAuthentication sut;
  late MockHttpClient httpClient;
  late String url;

  setUp(() {
    httpClient = MockHttpClient();
    url = faker.internet.httpsUrl();
    sut = RemoteAuthentication(httpClient: httpClient, url: url);
  });

  test('Should call HttpClient with values', () async {
    await sut.auth();

    verify(httpClient.request(url, method: 'post'));
  });
}
