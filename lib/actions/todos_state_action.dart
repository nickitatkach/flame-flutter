import 'package:flame/states/todos_state.dart';

class GetToDosStateAction {
  final ToDosState _getToDosState;

  GetToDosStateAction({getTodosState}) : _getToDosState = getTodosState;

  ToDosState get getTodosState => _getToDosState;
}

class GetMoreToDosStateAction {
  final ToDosState _getMoreTodosState;

  GetMoreToDosStateAction({getMoreTodosState}) : _getMoreTodosState = getMoreTodosState;

  ToDosState get getMoreTodosState => _getMoreTodosState;
}