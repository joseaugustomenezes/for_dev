import 'package:for_dev/data/http/http.dart';
import 'package:for_dev/data/models/models.dart';
import 'package:for_dev/domain/entities/entities.dart';
import 'package:for_dev/domain/helpers/helpers.dart';
import 'package:for_dev/domain/usecases/usecases.dart';

class RemoteAuthentication {
  final HttpClient httpClient;
  final String url;

  RemoteAuthentication({required this.httpClient, required this.url});

  Future<AccountEntity> auth(AuthenticationParams params) async {
    final body = RemoteAuthenticationParams.fromDomain(params).toJson();
    try {
      final response =
          await httpClient.request(url, method: 'post', body: body);
      return RemoteAccountModel.fromJson(response).toEntity();
    } on HttpErrors catch (e) {
      switch (e) {
        case HttpErrors.serverError:
        case HttpErrors.badRequest:
        case HttpErrors.notFound:
        case HttpErrors.invalidData:
          throw DomainError.unexpected;
        case HttpErrors.unauthorized:
          throw DomainError.invalidCredentials;
      }
    }
  }
}

class RemoteAuthenticationParams {
  final String email;
  final String password;

  RemoteAuthenticationParams({required this.email, required this.password});

  factory RemoteAuthenticationParams.fromDomain(AuthenticationParams params) =>
      RemoteAuthenticationParams(email: params.email, password: params.secret);

  Map<String, dynamic> toJson() => {'email': email, 'password': password};
}
