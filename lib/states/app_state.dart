import 'package:flame/states/auth_state.dart';
import 'package:flame/states/todos_state.dart';
import 'package:flutter/cupertino.dart';

@immutable
class AppState {
  final AuthState _authState;
  final ToDosState _todosState;

  const AppState(AuthState authState, ToDosState todosState) 
    : _authState = authState,
      _todosState = todosState;

  AppState copyWith({
    authState,
    todosState,
  }) {
    return AppState(
      authState ?? _authState,
      todosState ?? _todosState,
    );
  }

  AuthState get authState => _authState;
  ToDosState get todosState => _todosState;

  dynamic toJson() {
    return {'AuthState': _authState.toJson(), 'ToDosState': _todosState.toJson()};
  }

  static AppState? fromJson(dynamic json) {
    return json != null
        ? AppState(AuthState.fromJson(json["AuthState"]), ToDosState.fromJson(json["ToDosState"]))
        : null;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          _authState == other._authState &&
          _todosState == other._todosState;

  @override
  int get hashCode => _authState.hashCode ^ _todosState.hashCode;

  @override
  String toString() {
    return 'AppState{'
        '\n_authState: '
        '\n$_authState}'
        '\n_todosState: '
        '\n$_todosState}';
  }
}
