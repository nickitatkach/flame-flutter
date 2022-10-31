import 'package:flame/states/auth_state.dart';
import 'package:redux/redux.dart';
import '../actions/auth_state_action.dart';

final authReducer = combineReducers<AuthState>([
  TypedReducer<AuthState, AuthStateAction>(_setAuthResponseData),
]);

AuthState _setAuthResponseData(AuthState state, AuthStateAction action) {
  return AuthState(action.authState.account, false);
}
