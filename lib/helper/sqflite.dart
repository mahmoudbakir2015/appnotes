// ignore_for_file: depend_on_referenced_packages

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqfDb {
  static String nameOfDataBase = 'notes';
  static Database? _db;
  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDb();
      return _db;
    } else {
      return _db;
    }
  }

  initialDb() async {
    String myDatabasePath = await getDatabasesPath();
    String path = join(myDatabasePath,
        '$nameOfDataBase.db'); //  path => database/nameOfDataBase.db
    Database myDb = await openDatabase(path,
        onCreate: _onCreate, version: 1, onUpgrade: _onUpgrade);
    return myDb;
  }

  _onCreate(Database db, int version) async {
    Batch batch = db.batch();

    batch.execute('''
    CREATE TABLE 'notes'(
    'id' INTEGER  NOT NULL PRIMARY KEY AUTOINCREMENT ,
    'headnote' TEXT NOT NULL   ,
    'note' INTEGER NOT NULL ,
    'date' INTEGER NOT NULL 
    )
    ''');

    await batch.commit();
    print("=================create succeed=======================");
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) {
    print('================upgrade success========================');
  }

  readData(String sql) async {
    Database? myDb = await db;
    List<Map> response = await myDb!.rawQuery(sql);
    return response;
  }

  insertData(String sql) async {
    Database? myDb = await db;
    int response = await myDb!.rawInsert(sql);
    return response;
  }

  updateData(String sql) async {
    Database? myDb = await db;
    int response = await myDb!.rawUpdate(sql);
    return response;
  }

  deleteData(String sql) async {
    Database? myDb = await db;
    int response = await myDb!.rawDelete(sql);
    return response;
  }

  myDeleteDatabase() async {
    String myDatabasePath = await getDatabasesPath();
    String path = join(myDatabasePath,
        '$nameOfDataBase.db'); //  path => database/nameOfDataBase.db
    await deleteDatabase(path);
  }
}
