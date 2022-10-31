import 'dart:convert';

import 'package:flame/config/api_config.dart';
import 'package:flame/identity/authentication_helper.dart';
import 'package:flame/models/account.dart';
import 'package:http/http.dart' as http;

class AccountService {
  final _authenticationHelper = AuthenticationHelper();

  Future<Account> login(String login, String password) async {
    var response = await http.get(
        Uri.parse('${ApiConfig.apiEndpoint}/accounts'),
        headers: <String, String>{
          'X-Login': login,
          'X-Password': password,
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        });

    if (response.statusCode == 200) {
      var account = Account.fromJson(jsonDecode(response.body));
      _authenticationHelper.create(account);
      return account;
    } else {
      throw Exception('Failed to create album.');
    }
  }
}
