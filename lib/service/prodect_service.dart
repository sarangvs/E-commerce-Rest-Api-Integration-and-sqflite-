import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:retailer_app/db/database_handler.dart';
import 'package:retailer_app/models/product_model.dart';
import 'package:retailer_app/models/response_model.dart';

class ProductService {
  static Future<List<ProductModel>?> getProducts() async {
    final url = Uri.parse("https://jsonkeeper.com/b/YIDG");

    final response = await http.get(url);
    log("${response.statusCode}");
    if (response.statusCode == 200) {
      final responseModel = responseModelFromJson(response.body);
      final dbData = await DatabaseHelper.retrieveProductData();

      for (var product in responseModel.data!.products!) {
        final isContain =
            dbData.any((element) => element.prodId! == product.prodId!);
        if (!isContain) {
          await DatabaseHelper.insertProductItem([product]);
        }
      }
      return await DatabaseHelper.retrieveProductData();
    }
    return null;
  }
}
