import 'company.dart';

class Account {
  late final String? id;
  late final String? clientKey;
  late final String? accessToken;
  late final String? refreshToken;
  late final int? expiresIn;
  late final Company? company;

  Account();

  Account.fromJson(Map<String, dynamic> json)
      : id = json["Id"],
        clientKey = json["ClientKey"],
        accessToken = json["AccessToken"],
        refreshToken = json["RefreshToken"],
        expiresIn = json["Expires"],
        company = json["InitialCorporation"] != null
            ? Company.fromJson(json["InitialCorporation"])
            : null;

  Map<String, dynamic> toJson() => {
        "ClientKey": clientKey,
        "AccessToken": accessToken,
        "RefreshToken": refreshToken,
        "InitialCorporation": company?.toJson()
      };
}
