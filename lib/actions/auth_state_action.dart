import '../states/auth_state.dart';

class AuthStateAction {
  final AuthState _authState;

  AuthStateAction({authState}) : _authState = authState;

  AuthState get authState => _authState;
}