import 'package:flutter_to_do/models/model/to_do_model.dart';
import 'package:flutter_to_do/resources/app_logger.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DBProvider {
  DBProvider._();

  DBProvider();

  static final DBProvider db = DBProvider._();

  Database _database;
  final String _tableTodo = 'todo';
  final String _columnId = 'id';
  final String _columnName = 'name';
  final String _columnValue = 'value';
  final String _dbName = 'app.db';

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    var data = await getDatabasesPath();
    String path = join(data, _dbName);
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE $_tableTodo ($_columnId INTEGER PRIMARY KEY, $_columnName TEXT, $_columnValue INTEGER)');
    });
  }

  Future<int> insert(TodoModel todo) async {
    int count = 0;
    try {
      var db = (await database).batch();
      db.insert(_tableTodo, todo.toJson());
      count = (await db.commit()).length;
    } catch (e) {
      AppLogger.e(e);
    }
    return count;
  }

  Future<List<TodoModel>> getListTodo() async {
    var db = (await database).batch();
    db.query(_tableTodo);
    List<dynamic> maps = await db.commit();
    if (maps.length > 0) {
      return TodoModel().getListFromJson(maps.first);
    }
    return [];
  }

  Future<int> delete(int id) async {
    var db = (await database).batch();
    db.delete(_tableTodo, where: '$_columnId = ?', whereArgs: [id]);
    return (await db.commit()).length;
  }

  Future<int> update(TodoModel todo) async {
    var db = (await database).batch();
    db.update(_tableTodo, todo.toJson(),
        where: '$_columnId = ?', whereArgs: [todo.id]);
    return (await db.commit()).length;
  }

  Future close() async => await (await database).close();
}
