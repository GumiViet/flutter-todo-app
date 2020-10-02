import 'package:flutter_to_do/base/base_view_model.dart';
import 'package:flutter_to_do/data/sql/database.dart';
import 'package:flutter_to_do/dependency_injection/dependency_injection.dart';
import 'package:flutter_to_do/models/model/to_do_model.dart';
import 'package:flutter_to_do/resources/app_logger.dart';

class HomeViewModel extends BaseViewModel {
  DBProvider db = byInject<DBProvider>();

  List<TodoModel> _listTodo = [];

  List<TodoModel> get listTodo => _listTodo;

  void getListTodo() async {
    var list = await db.getListTodo();
    if (list.isNotEmpty) {
      _listTodo = list;
      notifyListeners();
    }
  }

  void addTodo() async {
    var countItem = _listTodo.length + 1;
    var count = await db.insert(TodoModel(
      id: countItem,
      name: "Todo $countItem",
      value: countItem * 100,
    ));
    AppLogger.d(count);
    getListTodo();
  }

  Future<int> deleteTodo(TodoModel item) async {
    var result = await db.delete(item.id);
    if (result != 0) getListTodo();
    return result;
  }
}
