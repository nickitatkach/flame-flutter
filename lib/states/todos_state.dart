import 'package:flame/models/todos.dart';

class ToDosState {
  final ToDos? todos;

  ToDosState(this.todos);

  static ToDosState fromJson(dynamic json) {
    return json != null
        ? ToDosState(json["ToDos"] != null ? ToDos.fromJson(json["ToDos"]) : null)
        : ToDosState(null);
  }

  dynamic toJson() {
    return {'ToDos': todos?.toJson()};
  }

  @override
  bool operator ==(Object other) => identical(this, other) ||
      other is ToDosState &&
          runtimeType == other.runtimeType &&
          todos.hashCode == other.todos.hashCode;

  @override
  int get hashCode => todos.hashCode;

  @override
  String toString() {
    return 'ToDosState{'
        '\ntodos: $todos';
  }
}
