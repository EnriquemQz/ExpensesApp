
import 'dart:io';
import 'package:expenses_app/models/expenses_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:path_provider/path_provider.dart';

class DBExpensesProvider {
  static Database _database;
  static final DBExpensesProvider db = DBExpensesProvider._();
  DBExpensesProvider._();

  Future<Database> get database async {
    if(_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentDirectory.path, 'ExpensesDB.db');
    print(path);
    return await openDatabase(path, version: 1, onOpen: (db){}, 
      onCreate: (Database db, int version) async {
        await db.execute('CREATE TABLE Expenses('
          'id INTEGER PRIMARY KEY,'
          'link INTEGER,'
          'year INTEGER,'
          'month INTEGER,'
          'day INTEGER,'
          'comment TEXT,'
          'expense DOUBLE'     
        ')');
      });
  }

  addNewExpense(ExpensesModel addNewExp) async {
    final db = await database;
    final res = await db.insert('Expenses', addNewExp.toJson());
    return res;
  }

  Future<List<ExpensesModel>> getByDate(int month, int year) async {
    final db = await database;
    final res = await db.query('Expenses', where: 'month = ? and year = ?',
      whereArgs: [month, year]);
    List<ExpensesModel> eList = res.isNotEmpty
      ? res.map((e) => ExpensesModel.fromJson(e)).toList()
      : [];
    return eList;
  }

}