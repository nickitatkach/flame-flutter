import 'package:flame/config/app_config.dart';
import 'package:flame/models/account.dart';
import 'package:flame/models/company.dart';
import 'package:flame/models/renew_access_token.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthenticationHelper {
  final storage = const FlutterSecureStorage();

  Future<Account?> get() async {
    final data = await storage.read(key: AppConfig.clientData);

    if (data == null) return null;

    final parts = data.split(':');

    final account = Account();

    account.id = parts[0];
    account.clientKey = parts[1];
    account.accessToken = parts[2];
    account.refreshToken = parts[3];
    account.expiresIn = int.parse(parts[4]);
    account.company = Company(parts[5], parts[6], int.parse(parts[7]));

    return account;
  }

  Future<bool> isAuthenticated() async {
    var data = await storage.read(key: AppConfig.clientData);

    return data != null;
  }

  Future<void> create(Account account) async {
    return storage.write(
        key: AppConfig.clientData,
        value: '${account.id}:${account.clientKey}:'
            '${account.accessToken}:${account.refreshToken}:${account.expiresIn}:'
            '${account.company?.id}:${account.company?.name}:${account.company?.type}');
  }

  Future<void> updateAccessToken(RenewAccessToken model) async {
    final account = await get();

    if (account != null) {
      account.accessToken = model.accessToken;
      account.expiresIn = model.expiresIn;

      await create(account);
    }
  }

  Future<void> updateCorporation(Company model) async {
    final account = await get();

    if (account != null) {
      account.company = Company(model.id, model.name, model.type);

      await create(account);
    }
  }

  void remove() {
    storage.delete(key: AppConfig.clientData);
  }
}
