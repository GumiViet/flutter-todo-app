import 'package:flutter_to_do/models/model/to_do_model.dart';
import 'package:flutter_to_do/resources/app_logger.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database _database;
  final String _tableTodo = 'todo';
  final String _columnId = '_id';
  final String _columnName = '_name';
  final String _columnValue = '_value';
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
      await (await database).transaction((txn) async {
        count = await txn.rawInsert(
            'INSERT INTO $_tableTodo ($_columnId, $_columnName, $_columnValue) VALUES(${todo.id}, ${todo.name}, ${todo.value})');
        AppLogger.d(count);
      });
    } catch (e) {
      AppLogger.e(e);
    }
    return count;
  }

  Future<List<TodoModel>> getTodo(int id) async {
    List<dynamic> maps = await (await database).query(_tableTodo);
    if (maps.length > 0) {
      return TodoModel().getListFromJson(maps);
    }
    return [];
  }

  Future<int> delete(int id) async {
    return await (await database)
        .delete(_tableTodo, where: '$_columnId = ?', whereArgs: [id]);
  }

  Future<int> update(TodoModel todo) async {
    return await (await database).update(_tableTodo, todo.toJson(),
        where: '$_columnId = ?', whereArgs: [todo.id]);
  }

  Future close() async => await (await database).close();
}
