import 'package:flame/pages/login_page.dart';
import 'package:flame/pages/todos_page.dart';
import 'package:flame/states/app_state.dart';
import 'package:flame/states/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class MyApp extends StatelessWidget {
  final Store<AppState> _store;
  final WidgetBuilder _devDrawerBuilder;

  const MyApp({
    Key? key,
    @required store,
    devDrawerBuilder,
  })  : _store = store,
        _devDrawerBuilder = devDrawerBuilder,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: _store,
      child: MaterialApp(
        title: 'Flutter Demo',
        home: Home(
          endDrawer: _devDrawerBuilder != null
              ? _devDrawerBuilder(context)
              : const MyAppDrawer(),
        ),
        routes: {
          '/todos': (context) => const ToDosPage()
        },
      ),
    );
  }
}

class MyAppDrawer extends StatelessWidget {
  const MyAppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Drawer(
      child: Padding(
        padding: EdgeInsets.only(top: 24.0),
        child: Text('Hello'),
      ),
    );
  }
}

class Home extends StatelessWidget {
  final Widget endDrawer;

  const Home({Key? key, required this.endDrawer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AuthState>(
        converter: (store) => store.state.authState,
        builder: (BuildContext context, authState) {
          return Scaffold(
            endDrawer: endDrawer,
            appBar: authState.account != null
                ? AppBar(
                    title: const Text('Main content'),
                    backgroundColor: Colors.blueGrey,
                  )
                : null,
            body: authState.account == null
                ? const LoginPage()
                : const ToDosPage(),
          );
        });
  }
}
