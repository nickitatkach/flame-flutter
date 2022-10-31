import 'package:flame/actions/auth_state_action.dart';
import 'package:flame/states/app_state.dart';
import 'package:flame/states/todos_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

typedef OnToDosStateCallback = void Function(ToDosState todosState);

class ToDosPage extends StatefulWidget {
  const ToDosPage({Key? key}) : super(key: key);

  @override
  _ToDosPageState createState() => _ToDosPageState();
}

class _ToDosPageState extends State<ToDosPage> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, OnToDosStateCallback>(
        converter: (Store<AppState> store) {
      return (data) {
        store.dispatch(AuthStateAction(authState: data));
      };
    }, builder:
            (BuildContext context, OnToDosStateCallback todosStateCallback) {
      return Padding(
        padding: const EdgeInsets.all(30),
        child: Center(
          child: CupertinoButton(
              child: const Text('Load ToDos'),
              onPressed: () async {
                try {
                  // var items = await _todoService.getList(null, 0, 50);

                  // todosStateCallback()

                } catch (e) {
                  print(e);
                }
              }),
        ),
      );
    });
  }
}
