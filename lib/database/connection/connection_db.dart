import 'dart:io';

import 'package:local_storage/database/models/product_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

import '../global/global_field.dart';

class ConnectionDB {
  Future<Database> initDatabase() async {
    final Directory tempDir = await getTemporaryDirectory();
    final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'procducts.db'),
      onCreate: (database, version) async {
        await database.execute(
          'CREATE TABLE $productTable($fId INTEGER PRIMARY KEY, $fName TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> insertProduct(ProductModel pro) async {
    var db = await initDatabase();
    await db.insert(productTable, pro.toMap());
  }
}
