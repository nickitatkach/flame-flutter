import '../models/account.dart';

class AuthState {
  final Account? account;
  final bool? loading;

  AuthState(this.account, this.loading);

  static AuthState fromJson(dynamic json) {
    return json != null
        ? AuthState(
            json["Account"] != null ? Account.fromJson(json["Account"]) : null,
            json["Loading"])
        : AuthState(null, false);
  }

  dynamic toJson() {
    return {'Account': account?.toJson(), "Loading": loading};
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthState &&
          runtimeType == other.runtimeType &&
          account?.accessToken == other.account?.accessToken;

  @override
  int get hashCode => account.hashCode;

  @override
  @override
  String toString() {
    return 'AuthState{'
        '\naccessToken: ${account?.accessToken}'
        '\nloading: $loading}';
  }
}
