import 'package:sqflite/sqflite.dart';
import 'package:todoapp/models/category.dart';

  class DBHelper{
    static Database? _db;
    static final int _version =1;
    static final String _tableName="categories";

    static Future<void> initDb()async{
      if (_db !=null) {
        return;
      }
      try {
        String _path = await getDatabasesPath() + 'categories.db';
        _db = await openDatabase(
          _path,
          version: _version,
          onCreate: (db, version) {
            print("Creating a new one");
            return db.execute(
                "CREATE TABLE $_tableName("
                    "id INTEGER PRIMARY KEY AUTOINCREMENT,"
                    "cat STRING, description TEXT,date STRING ,"
                    "color INTEGER,"
                    "isCompleted INTEGER)",
            );
          }
        );
      }catch (e) {
        print(e);
      }

    }
    static Future<int> insert(Category? category) async {
      print("insert function called");
      return await _db?.insert(_tableName, category!.toJson())??1;
    }
    static Future<List<Map<String, dynamic>>> query() async{
      print("query function called");
      return await _db!.query(_tableName);
    }
    static delete(Category category)async{
     return await _db!.delete(_tableName, where: 'id=?', whereArgs: [category.id]);
    }
    static update(int id)async{
      return await _db!.rawUpdate('''
        UPDATE categories
        SET isCompleted = ?
        WHERE id =?
      ''',[1, id]);
    }
  }
