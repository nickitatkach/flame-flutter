import 'dart:io';

import 'package:flame/reducers/app_reducer.dart';
import 'package:flame/states/app_state.dart';
import 'package:flame/states/auth_state.dart';
import 'package:flame/states/todos_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux_dev_tools/flutter_redux_dev_tools.dart';
import 'package:redux_dev_tools/redux_dev_tools.dart';
import 'package:redux_persist/redux_persist.dart';
import 'package:redux_persist_flutter/redux_persist_flutter.dart';

import 'app.dart';

// The Dev version of your app. It will build a DevToolsStore instead of a
// normal Store. In addition, it will provide a DevDrawer for the app, which
// will contain the ReduxDevTools themselves.
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final persistor = Persistor<AppState>(
    storage: FlutterStorage(
        key: 'FlameStore', location: FlutterSaveLocation.sharedPreferences),
    serializer: JsonSerializer<AppState>(AppState.fromJson),
    debug: true,
  );

  final initialState = await persistor.load();

  final store = DevToolsStore<AppState>(
    appReducer,
    initialState: initialState ?? AppState(AuthState(null, true), ToDosState(null)),
    middleware: [persistor.createMiddleware()],
  );

  runApp(ReduxDevToolsContainer(
    store: store,
    child: MyApp(
      store: store,
      devDrawerBuilder: (context) {
        return Drawer(
          child: Padding(
            padding: const EdgeInsets.only(top: 24.0),
            child: ReduxDevTools(store),
          ),
        );
      },
    ),
  ));
}
