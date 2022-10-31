import 'dart:convert';

import 'package:flame/config/api_config.dart';
import 'package:flame/controllers/proxy_controller.dart';
import 'package:flame/helpers/filtered_list.dart';
import 'package:flame/identity/authentication_helper.dart';
import 'package:flame/models/company.dart';

class CompanyService {
  final ProxyController _proxyController = ProxyController();
  final AuthenticationHelper _authentiocationHelper = AuthenticationHelper();

  Future<FilteredList<Company>> getList() async {
    final account = await _authentiocationHelper.get();

    if (account == null) return FilteredList(null, null);

    final response = await _proxyController.send(
        '${ApiConfig.apiEndpoint}/accounts/${account.id}/corporations',
        'GET',
        null,
        null);

    if (response != null) {
      final json = jsonDecode(response);

      return FilteredList(json.Items.map((company) => Company.fromJson(company)), json.Count);
    }

    return FilteredList(null, null);
  }
}
