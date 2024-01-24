import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:for_dev/infra/http/http.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<Client>()])
import 'http_adapter_test.mocks.dart';

void main() {
  late MockClient client;
  late HttpAdapter sut;
  late String url;

  setUp(() {
    client = MockClient();
    sut = HttpAdapter(client);
    url = faker.internet.httpsUrl();
  });

  group('post', () {
    PostExpectation<Future<Response>> mockRequest() => when(
        client.post(any, headers: anyNamed('headers'), body: anyNamed('body')));

    void mockResponse(
        {int statusCode = 200, String body = '{"any_key":"any_value"}'}) {
      mockRequest().thenAnswer((_) async => Response(body, statusCode));
    }

    setUp(() {
      mockResponse();
    });

    test('Should call post with correct values', () async {
      await sut.request(url, method: 'post', body: {'any_key': 'any_value'});

      verify(client.post(Uri.parse(url),
          headers: {
            'content-type': 'application/json',
            'accept': 'application/json'
          },
          body: '{"any_key":"any_value"}'));
    });

    test('Should call post with correct body', () async {
      await sut.request(url, method: 'post');

      verify(client.post(any, headers: anyNamed('headers')));
    });

    test('Should return data if post returns 200', () async {
      final response = await sut.request(url, method: 'post');

      expect(response, {'any_key': 'any_value'});
    });

    test('Should return empty map if post returns 200 with no data', () async {
      mockResponse(body: '');

      final response = await sut.request(url, method: 'post');

      expect(response, <String, dynamic>{});
    });

    test('Should return empty map if post returns 204 without data', () async {
      mockResponse(body: '', statusCode: 204);

      final response = await sut.request(url, method: 'post');

      expect(response, <String, dynamic>{});
    });

    test('Should return empty map if post returns 204 with data', () async {
      mockResponse(statusCode: 204);

      final response = await sut.request(url, method: 'post');

      expect(response, <String, dynamic>{});
    });
  });
}
