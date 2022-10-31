import 'package:flame/actions/todos_state_action.dart';
import 'package:flame/states/todos_state.dart';
import 'package:redux/redux.dart';

final todosReducer = combineReducers<ToDosState>([
  TypedReducer<ToDosState, GetToDosStateAction>(_setToDos),
  TypedReducer<ToDosState, GetMoreToDosStateAction>(_setMoreToDos),
]);

ToDosState _setToDos(ToDosState state, GetToDosStateAction action) {
  return ToDosState(action.getTodosState.todos);
}

ToDosState _setMoreToDos(ToDosState state, GetMoreToDosStateAction action) {
  return ToDosState(action.getMoreTodosState.todos);
}