import 'package:retailer_app/models/product_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Future<Database> initDb() async {
    var dbPath = await getDatabasesPath();
    String path = join(dbPath, 'products.db');
    return openDatabase(path, version: 1, onCreate: _onCreate);
  }

  static void _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE cart(prodId TEXT, prodImage TEXT, prodCode TEXT, prodName TEXT, prodPrice TEXT, prodMrp TEXT)');
  }

  static Future<int> insert(List<ProductModel> productModel) async {
    int result = 0;
    Database db = await DatabaseHelper.initDb();
    // for (var product in productModel) {
    result = await db.insert('cart', productModel.first.toJson());
    // }
    return result;
  }

  // static Future<int?> createProducts(CartModel cartModel) async {
  //   log("add to db fuction called");
  //   Database db = await DatabaseHelper.initDb();
  //   // log("add to db ${productModels.map((e) => e.toJson())}");
  //   // return null;
  //   final data = {'data': productModels.map((e) => e.toJson()).toList()};
  //   log(data.toString());
  //   // return null;
  //   final response = await db.insert('Products', data);
  //   log("add to db $response");
  //   return null;
  //   // return response;
  // }

  static Future<List<ProductModel>> readProducts() async {
    Database db = await DatabaseHelper.initDb();
    var product = await db.query('Products', orderBy: 'prodName');
    List<ProductModel> productList = product.isNotEmpty
        ? product.map((e) => ProductModel.fromJson(e)).toList()
        : [];
    return productList;
  }

  static Future<int> update(ProductModel productModel) async {
    Database db = await DatabaseHelper.initDb();
    return await db.update('Products', productModel.toJson(),
        where: 'prodId = ?', whereArgs: [productModel.prodId]);
  }

  static Future<int> deleteProducts(ProductModel productModel) async {
    Database db = await DatabaseHelper.initDb();
    return await db.delete('Products',
        where: 'prodId = ?', whereArgs: [productModel.prodId]);
  }
}
