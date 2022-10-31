import 'package:flame/pages/login_page.dart';
import 'package:flame/states/app_state.dart';
import 'package:flame/states/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var store = StoreProvider.of<AppState>(context);

    return StoreConnector<AppState, AuthState>(
      converter: (mainItemStore) => mainItemStore.state.authState,
      builder: (context, list) {
        return Scaffold(
          appBar: AppBar(title: const Text("Flutter Redux Example")),
          body: store.state.authState.account == null
              ? const LoginPage()
              : const Text("Flutter Redux Example"),
        );
      },
    );
  }
}
