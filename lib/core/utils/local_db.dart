import 'dart:developer';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../feature/userlist/model/insert_model.dart';

class DatabaseHelper {
  static Database? _database;
  static const String dbName = 'user_database.db';

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await initDatabase();
      return _database!;
    }
  }

  Future<Database> initDatabase() async {
    // Get a location using path_provider
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, dbName);

    log("path is ${path.toString()}");

    // Open/create the database at a given path
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );
  }

  Future<void> _createDb(Database db, int version) async {
    // Create tables
    await db.execute('''
    CREATE TABLE userList (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      first TEXT,
      last TEXT,
      age INTEGER
    )
  ''');
  }

  Future<void> insertIntoTable(List<InserModel> insertModel) async {
    Database db = await database;
    // final batch = db.batch();
    try {
      for (var map in insertModel) {
        db.insert("userList", map.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
      // await batch.commit(noResult: true);
    } catch (e) {
      log("vhj ${e.toString()}");
    }
  }

  Future<List<Map<String, dynamic>>?> filterData(
      {required String age, required String endTime}) async {
    Database db = await database;
    String query = '''
    SELECT * FROM userList
    WHERE time(timestamp) BETWEEN time(?) AND time(?)
  ''';
    try {
      return await db.rawQuery(query, [age]);
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<List<Map<String, dynamic>>?> getData(String query) async {
    print("wuery--> $query");
    Database db = await database;
    try {
      return await db.rawQuery(
        'SELECT * FROM userList WHERE '
        'first LIKE ? OR '
        'last LIKE ? OR '
        'age LIKE ?',
        [
          '%$query%', // Wildcard for matching any text containing the query
          '%$query%',
          '%$query%',
        ],
      );
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
