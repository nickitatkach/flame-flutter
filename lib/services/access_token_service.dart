import 'dart:convert';

import 'package:flame/config/api_config.dart';
import 'package:flame/models/account.dart';
import 'package:http/http.dart' as http;

class AccessTokenService {
  Future<Account> renew(String clientKey, String refreshToken) async {
    final response = await http.post(
        Uri.parse('${ApiConfig.apiEndpoint}/access-tokens'),
        headers: <String, String>{
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          'ClientKey': clientKey,
          'RefreshToken': refreshToken
        }));

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return Account.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create album.');
    }
  }
}
