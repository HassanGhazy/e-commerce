import 'dart:io';
import 'package:shop/models/product.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DBHelper {
  DBHelper._();
  static DBHelper dbhelper = DBHelper._();
  Database? database;
  static const String databaseName = 'products.db';
  static const String tableNameFavorite = 'Favorite';
  static const String tableNameCart = 'Cart';
  static const String idColumnName = 'id';
  static const String titleColumnName = 'title';
  static const String priceColumnName = 'price';
  static const String descriptionColumnName = 'description';
  static const String categoryColumnName = 'category';
  static const String imageColumnName = 'image';
  static const String quantityColumnName = 'quantity';

  // static const String countColumnName = 'count';

  Future<void> initDataBase() async {
    database = await getDatabase();
  }

  Future<Database> getDatabase() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = join(directory.path, databaseName);
    final Database databases = await openDatabase(
      filePath,
      version: 1,
      onCreate: (Database db, int version) {
        db.execute(
            '''create table $tableNameCart ($idColumnName INTEGER primary key, $titleColumnName Text, $priceColumnName num, $descriptionColumnName Text , $categoryColumnName Text ,$imageColumnName Text, $quantityColumnName num)''');
        db.execute(
            '''create table $tableNameFavorite ($idColumnName INTEGER primary key, $titleColumnName Text, $priceColumnName num, $descriptionColumnName Text , $categoryColumnName Text ,$imageColumnName Text, $quantityColumnName num)''');
      },
    );
    return databases;
  }

  Future<void> createCart(ProductModel pr) async {
    pr.quantity = 1;
    await database?.insert(tableNameCart, pr.toDbJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> createFavorite(ProductModel pr) async {
    await database?.insert(tableNameFavorite, pr.toDbJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<ProductModel>> getAllFavorites() async {
    final List<Map<String?, Object?>> res =
        await database!.query(tableNameFavorite);
    final List<ProductModel> pr = res.map((Map<String?, dynamic> e) {
      return ProductModel.fromDbJson(e);
    }).toList();
    return pr;
  }

  Future<List<ProductModel>> getAllCart() async {
    final List<Map<String?, Object?>> res =
        await database!.query(tableNameCart);
    final List<ProductModel> pr = res.map((Map<String?, dynamic> e) {
      return ProductModel.fromDbJson(e);
    }).toList();
    return pr;
  }

  Future<void> deleteFavorite(ProductModel product) async {
    await database?.delete(tableNameFavorite,
        where: 'id=?', whereArgs: <Object>['${product.id}']);
  }

  Future<void> deleteFromCart(ProductModel product) async {
    await database?.delete(tableNameCart,
        where: 'id=?', whereArgs: <Object>['${product.id}']);
  }

  Future<void> updateQuantityIncreasing(ProductModel product) async {
    product.quantity = (product.quantity ?? 0) + 1;

    await database?.update(tableNameCart, product.toDbJson(),
        where: 'id=?', whereArgs: <Object>['${product.id}']);
  }

  Future<void> updateQuantityDecreaing(ProductModel product) async {
    product.quantity = product.quantity! - 1;
    if (product.quantity! <= 0) {
      await database?.delete(tableNameCart,
          where: 'id=?', whereArgs: <Object>['${product.id}']);
    } else {
      await database?.update(tableNameCart, product.toDbJson(),
          where: 'id=?', whereArgs: <Object>['${product.id}']);
    }
  }
}
