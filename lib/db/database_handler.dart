import 'dart:developer';
import 'dart:io';

import 'package:retailer_app/models/cart_model.dart';
import 'package:retailer_app/models/product_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static List<Map<String, Object?>> queryResult = [];

  static Future<Database> initializeDB() async {
    final String dbPath = await getDatabasesPath();

    await deleteDatabase(dbPath);

    // Create the writable database file from the bundled demo database file:
    try {
      await Directory(dirname(dbPath)).create(recursive: true);
    } catch (_) {
      log("Db Error");
    }

    return openDatabase(
      join(dbPath, 'database.db'),
      version: 1,
      onCreate: (
        database,
        version,
      ) async {
        await database.execute(
            'CREATE TABLE products(prodId TEXT, isEffected INTEGER DEFAULT 0, prodImage TEXT, prodCode TEXT, prodName TEXT, prodPrice TEXT, prodMrp TEXT, isAddedToCart TEXT)');
        await database.execute(
            'CREATE TABLE cart(prodId TEXT, prodImage TEXT, prodCode TEXT, prodName TEXT, prodPrice TEXT, prodMrp TEXT, itemCount INTEGER DEFAULT 1)');
      },
    );
  }

// insert data to product table
  static Future<int> insertProductItem(List<ProductModel> productModel) async {
    int result = 0;
    Database db = await DatabaseHelper.initializeDB();
    for (var product in productModel) {
      result = await db.insert(
        'products',
        product.toJson(),
      );
      log("result $result");
    }
    return result;
  }

// insert data to cart table
  static Future<int> insert(List<CartModel> cartModel) async {
    int result = 0;
    Database db = await DatabaseHelper.initializeDB();
    for (var product in cartModel) {
      result = await db.insert(
        'cart',
        product.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      // log("result $result");
    }
    return result;
  }

// retrive data from cart table
  static Future<List<CartModel>> retrieveData() async {
    final Database db = await initializeDB();
    queryResult = await db.query('cart');
    return queryResult
        .map((e) => CartModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

// retrive data from product table
  static Future<List<ProductModel>> retrieveProductData() async {
    final Database db = await initializeDB();
    queryResult = await db.query('products');

    final products = queryResult
        .map((e) => ProductModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
    log("${products.map((e) => e.isEffected)}");

    return products;
  }

//update data to cart table
  static Future<int> updateCart(CartModel cartModel) async {
    log("${cartModel.toJson()}");
    final db = await DatabaseHelper.initializeDB();
    final result = await db.update(
      'cart',
      cartModel.toJson(),
      where: 'prodId = ?',
      whereArgs: [cartModel.prodId],
    );
    log("${cartModel.itemCount}");
    return result;
  }

// update data to Product table
  static Future<int> updateProduct(ProductModel productModel) async {
    // log("model : ${productModel.toJson()}");
    final db = await DatabaseHelper.initializeDB();

    final value = await db.update(
      'products',
      productModel.toJson(),
      where: 'prodId = ?',
      whereArgs: [productModel.prodId],
    );

    return value;
  }

// delete data in cart table
  static Future<void> deleteData(int id) async {
    final db = await initializeDB();
    await db.delete('cart', where: 'prodId = ?', whereArgs: [id]);
    log("deleted");
  }

  static Future<void> deleteProduct(int id) async {
    final db = await initializeDB();
    await db.delete('products', where: 'prodId = ?', whereArgs: [id]);
    log("deleted");
  }

  static Future<void> deleteCartDb() async {
    final db = await initializeDB();
    await db.delete('cart');
  }
}
