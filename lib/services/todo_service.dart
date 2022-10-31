import 'package:flame/config/api_config.dart';
import 'package:flame/controllers/proxy_controller.dart';
import 'package:flame/models/todo.dart';
import 'package:flame/models/todos.dart';

class ToDoService {
  final _proxyController = ProxyController();

  Future<ToDo?> get(String id) async {
    var response = await _proxyController.send('${ApiConfig.apiEndpoint}/department-todos/$id', 'GET', null, null);

    if (response != null) {
      return ToDo.fromJson(response);
    }

    return null;
  }

  Future<ToDos?> getList(String? query, int? skip, int? take) async {
    var response = await _proxyController
      .send('${ApiConfig.apiEndpoint}/department-todos?query=${query ?? ''}&skip=$skip&take=$take', 'GET', null, null);

    if (response != null) {
      return ToDos.fromJson(response);
    }

    return null;
  }
}
