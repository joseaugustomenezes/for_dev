import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<Client>()])
import 'http_adapter_test.mocks.dart';

class HttpAdapter {
  final Client client;

  HttpAdapter(this.client);

  Future<void> request(String url,
      {required String method, Map<String, dynamic>? body}) async {
    await client.post(Uri.parse(url));
  }
}

void main() {
  group('post', () {
    test('Should call post with correct values', () async {
      final client = MockClient();
      final sut = HttpAdapter(client);
      final url = faker.internet.httpsUrl();

      await sut.request(url, method: 'post');

      verify(client.post(Uri.parse(url)));
    });
  });
}
