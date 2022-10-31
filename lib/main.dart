import 'package:flame/reducers/app_reducer.dart';
import 'package:flame/states/app_state.dart';
import 'package:flame/states/auth_state.dart';
import 'package:flame/states/todos_state.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

import 'app.dart';

void main() async {
  final _initialState = AppState(AuthState(null, true), ToDosState(null));

  final Store<AppState> _store =
      Store<AppState>(appReducer, initialState: _initialState);

  runApp(MyApp(store: _store));
}
