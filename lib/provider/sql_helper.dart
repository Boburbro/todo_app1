import 'package:sqflite/sqflite.dart' as sql;

class SqlHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute(
        "CREATE TABLE items (id TEXT, title TEXT, date TEXT, isDone TEXT)");
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase('baza.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTables(database);
    });
  }

  static Future<int> createItem(
    String id,
    String title,
    String date,
    String isDone,
  ) async {
    final db = await SqlHelper.db();
    final data = {'id': id, 'title': title, 'date': date, 'isDone': isDone};
    final intId = await db.insert('items', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return intId;
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SqlHelper.db();
    return db.query('items', orderBy: 'id');
  }

  static Future<List<Map<String, dynamic>>> getItem(String id) async {
    final db = await SqlHelper.db();
    return db.query('item', where: 'id = ?', whereArgs: [id], limit: 1);
  }

  static Future<int> updateItem(
    String id,
    String title,
    String date,
    String isDone,
  ) async {
    final db = await SqlHelper.db();
    final data = {'id': id, 'title': title, 'date': date, 'isDone': isDone};
    final result = db.update('items', data, where: 'id = ?', whereArgs: [id]);
    return result;
  }

  static Future<void> deleteItem(String id) async {
    final db = await SqlHelper.db();
    try {
      await db.delete('items', where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      rethrow;
    }
  }
}
