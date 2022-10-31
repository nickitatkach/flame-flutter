import 'dart:convert';

import 'package:flame/identity/authentication_helper.dart';
import 'package:flame/models/account.dart';
import 'package:flame/models/renew_access_token.dart';
import 'package:flame/services/access_token_service.dart';
import 'package:http/http.dart' as http;

class ProxyController {
  final _authenticationHelper = AuthenticationHelper();
  final _accessTokenService = AccessTokenService();
  Account? _account;

  // collect(url: string, method: string, headers?: Headers, body?: any): RequestInit {
  //     if (!headers) {
  //         headers = new Headers();
  //     }

  //     headers.set('X-CallerId', this._account.clientKey);
  //     headers.set('Authorization', `Bearer ${this._account.accessToken}`);
  //     headers.set('Accept', 'application/json');
  //     headers.set('Content-Type', 'application/json');

  //     if (this._account.corporation) {
  //         headers.set('X-CorporationId', this._account.corporation.id);
  //     }

  //     let params: RequestInit = {
  //         method: 'GET',
  //         headers: headers,
  //         body: JSON.stringify(body)
  //     };

  //     return params;
  // };

  Future<dynamic> send(String url, String method, Map<String, String>? headers, Object? body) async {
    final Account? account = await _authenticationHelper.get();

    if (account != null) {
      _account = account;

      Future<http.Response> action() {
        // final http.Request request = http.Request(method, Uri.parse(url));
        // request.body = jsonEncode(body);

        // if (headers != null) request.headers.addAll(headers);

        // request.headers.addAll(<String, String>{
        //   'X-CallerId': _account?.clientKey ?? '',
        //   'Authorization': 'Bearer ${_account?.accessToken ?? ''}',
        //   'Accept': 'application/json',
        //   'Content-Type': 'application/json'
        // });

        // if (_account?.company != null) {
        //   request.headers.addAll(
        //       <String, String>{'X-CorporationId': _account?.company?.id ?? ''});
        // }

        // return request.send();

        headers = headers ?? <String, String>{};

        headers?.addAll(<String, String>{
          'X-CallerId': _account?.clientKey ?? '',
          'Authorization': 'Bearer ${_account?.accessToken ?? ''}',
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        });

        if (_account?.company != null) {
          headers?.addAll(
              <String, String>{'X-CorporationId': _account?.company?.id ?? ''});
        }

        if (method == 'POST') {
          return http.post(Uri.parse(url), headers: headers, body: body);
        }

        return http.get(Uri.parse(url), headers: headers);
      }

      return await invoke(action);
    }
  }

  Future<dynamic> invoke(Future<http.Response> Function() action) async {
    final DateTime utc = DateTime.now();
    final int now = ((utc.millisecondsSinceEpoch * 10000) + 621355968000000000);

    if ((_account?.expiresIn ?? 0) < now) {
      return await renewAndInvoke(action);
    }

    final http.Response response = await action();

    if (response.statusCode == 401) {
      return await renewAndInvoke.call(() async => await invoke.call(action));
    }

    if (response.statusCode >= 200 || response.statusCode < 300) {
      // final http.Response result = await http.Response.fromStream(response);
      return jsonDecode(response.body);
    }
  }

  Future<void> renew() async {
    final account = await _accessTokenService.renew(
        _account?.clientKey ?? '', _account?.refreshToken ?? '');

    _account?.accessToken = account.accessToken;
    _account?.expiresIn = account.expiresIn;

    if (_account?.accessToken != null) {
      await _authenticationHelper.updateAccessToken(
          RenewAccessToken(_account?.accessToken ?? '', _account?.expiresIn));
    }
  }

  Future<void> renewAndInvoke(Future<http.Response>? Function() invoke) async {
    try {
      await renew();
      invoke.call();
    } catch (e) {
      throw Exception(e);
    }
  }
}
