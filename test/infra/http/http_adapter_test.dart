import 'dart:convert';

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

  Future<Map<String, dynamic>> request(String url,
      {required String method, Map<String, dynamic>? body}) async {
    final headers = {
      'content-type': 'application/json',
      'accept': 'application/json'
    };
    final jsonBody = body != null ? jsonEncode(body) : null;
    final response =
        await client.post(Uri.parse(url), headers: headers, body: jsonBody);
    return jsonDecode(response.body) as Map<String, dynamic>;
  }
}

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
    test('Should call post with correct values', () async {
      when(client.post(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => Response('{"any_key":"any_value"}', 200));

      await sut.request(url, method: 'post', body: {'any_key': 'any_value'});

      verify(client.post(Uri.parse(url),
          headers: {
            'content-type': 'application/json',
            'accept': 'application/json'
          },
          body: '{"any_key":"any_value"}'));
    });

    test('Should call post with correct body', () async {
      when(client.post(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => Response('{"any_key":"any_value"}', 200));

      await sut.request(url, method: 'post');

      verify(client.post(any, headers: anyNamed('headers')));
    });

    test('Should return data if post returns 200', () async {
      when(client.post(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => Response('{"any_key":"any_value"}', 200));

      final response = await sut.request(url, method: 'post');

      expect(response, {'any_key': 'any_value'});
    });
  });
}
