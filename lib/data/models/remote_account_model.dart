import 'package:for_dev/domain/entities/account_entity.dart';

class RemoteAccountModel {
  final String accessToken;

  RemoteAccountModel(this.accessToken);

  factory RemoteAccountModel.fromJson(Map<String, dynamic> json) =>
      RemoteAccountModel(json['accessToken'] as String);

  AccountEntity toEntity() => AccountEntity(accessToken);
}
