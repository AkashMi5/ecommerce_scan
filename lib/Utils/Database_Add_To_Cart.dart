import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class Database_Add_To_Cart {
  static final _databaseName = "Cart.db";
  static final _databaseVersion = 1;
  static final table = 'cart_table';
  static final columnId = 'id';
  static final columnName = 'name';
  static final columnprice = 'price';
  static final columnqty = 'qty';
  static final columnCartQty = 'age';
  String path;

  Database_Add_To_Cart._privateConstructor();

  static final Database_Add_To_Cart instance =
      Database_Add_To_Cart._privateConstructor();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  Future<List> getAllNotes() async {
    var dbClient = await _database;
    var result =
        await dbClient.query(table, columns: [columnId, columnName, columnCartQty]);
    return result.toList();
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
        '''CREATE TABLE $table ($columnId INTEGER PRIMARY KEY, $columnName TEXT NOT NULL,
        $columnprice TEXT NOT NULL, $columnqty TEXT NOT NULL, $columnCartQty INTEGER NOT NULL)''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  Future<int> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }


  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> getRow(int id) async {
    Database db = await instance.database;
    var result = await db.rawQuery('SELECT qty FROM $table WHERE $columnId=?', [id]);
    print(result.toString());
    return result ;
  }


  Future cleanDatabase() async {
    try {
      await _database.transaction((txn) async {
        var batch = txn.batch();
        batch.delete(table);
        await batch.commit();
      });
    } catch (error) {
      throw Exception('DbBase.cleanDatabase: ' + error.toString());
    }
  }
}
