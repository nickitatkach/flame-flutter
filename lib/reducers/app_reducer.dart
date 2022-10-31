import 'package:flame/reducers/auth_reducer.dart';
import 'package:flame/reducers/todos_reducer.dart';

import '../states/app_state.dart';

AppState appReducer(AppState state, action) {
  return AppState(authReducer(state.authState, action),
      todosReducer(state.todosState, action));
}
