import 'package:flame/models/todo.dart';

class ToDos {
  late final int? count;
  late final List<ToDo> items;

  ToDos();

  ToDos.fromJson(Map<String, dynamic> json)
      : items = json["items"],
        count = json["count"];

  Map<String, dynamic> toJson() => {
        "items": items,
        "count": count
      };
}
