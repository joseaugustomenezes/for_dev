import 'package:for_dev/data/http/http.dart';
import 'package:for_dev/domain/entities/account_entity.dart';

class RemoteAccountModel implements Serializable<RemoteAccountModel> {
  final String accessToken;

  RemoteAccountModel(this.accessToken);

  AccountEntity toEntity() => AccountEntity(accessToken);

  @override
  RemoteAccountModel fromJson(Map<String, dynamic> json) {
    if (json['accessToken'] is! String) {
      throw HttpError.invalidData;
    }
    return RemoteAccountModel(json['accessToken'] as String);
  }
}
