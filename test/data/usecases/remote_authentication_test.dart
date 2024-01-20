import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:for_dev/data/http/http.dart';
import 'package:for_dev/data/usecases/usecases.dart';
import 'package:for_dev/domain/helpers/helpers.dart';
import 'package:for_dev/domain/usecases/usecases.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<HttpClient>()])
import 'remote_authentication_test.mocks.dart';

void main() {
  late RemoteAuthentication sut;
  late MockHttpClient httpClient;
  late String url;
  late AuthenticationParams params;

  setUp(() {
    httpClient = MockHttpClient();
    url = faker.internet.httpsUrl();
    sut = RemoteAuthentication(httpClient: httpClient, url: url);
    params = AuthenticationParams(
        email: faker.internet.email(), secret: faker.internet.password());
  });

  test('Should call HttpClient with values', () async {
    when(httpClient.request(any,
            method: anyNamed('method'), body: anyNamed('body')))
        .thenAnswer((_) async =>
            {'accessToken': faker.guid.guid(), 'name': faker.person.name()});

    await sut.auth(params);

    verify(httpClient.request(url,
        method: 'post',
        body: {'email': params.email, 'password': params.secret}));
  });

  test('Should throw UnexpectedError if HttpClient returns 400', () async {
    when(httpClient.request(any,
            method: anyNamed('method'), body: anyNamed('body')))
        .thenThrow(HttpErrors.badRequest);

    final future = sut.auth(params);
    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient returns 404', () async {
    when(httpClient.request(any,
            method: anyNamed('method'), body: anyNamed('body')))
        .thenThrow(HttpErrors.notFound);

    final future = sut.auth(params);
    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient returns 500', () async {
    when(httpClient.request(any,
            method: anyNamed('method'), body: anyNamed('body')))
        .thenThrow(HttpErrors.serverError);

    final future = sut.auth(params);
    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw InvalidCredentialsError if HttpClient returns 401',
      () async {
    when(httpClient.request(any,
            method: anyNamed('method'), body: anyNamed('body')))
        .thenThrow(HttpErrors.unauthorized);

    final future = sut.auth(params);
    expect(future, throwsA(DomainError.invalidCredentials));
  });

  test('Should return an Account if HttpClient returns 200', () async {
    final accessToken = faker.guid.guid();
    when(httpClient.request(any,
            method: anyNamed('method'), body: anyNamed('body')))
        .thenAnswer((_) async =>
            {'accessToken': accessToken, 'name': faker.person.name()});

    final account = await sut.auth(params);
    expect(account.token, accessToken);
  });

  test(
      'Should throw UnexpectedError if HttpClient returns 200 with invalid data',
      () async {
    when(httpClient.request(any,
            method: anyNamed('method'), body: anyNamed('body')))
        .thenAnswer((_) async => {'invalid_key': 'invalid_value'});

    final future = sut.auth(params);
    expect(future, throwsA(DomainError.unexpected));
  });
}
