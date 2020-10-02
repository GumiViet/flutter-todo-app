import 'package:flutter_to_do/base/base_view_model.dart';
import 'package:flutter_to_do/data/sql/database.dart';
import 'package:flutter_to_do/dependency_injection/dependency_injection.dart';
import 'package:flutter_to_do/models/model/to_do_model.dart';

class AddItemViewModel extends BaseViewModel {
  DBProvider db = byInject<DBProvider>();

  TodoModel _modelTodo = TodoModel();
  TodoModel get modelTodo => _modelTodo;
  set modelTodo(value) => _modelTodo = value;

  void setValue(String val) {
    _modelTodo.value = int.tryParse(val);
    notifyListeners();
  }

  void setName(String val) {
    _modelTodo.name = val;
    notifyListeners();
  }

  Future<int> addItemTodo(TodoModel item) async {
    var result = await db.insert(item);
    return result;
  }

  Future<int> editItemTodo(TodoModel item) async {
    var result = await db.update(item);
    return result;
  }
}
