import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:retailer_app/models/product_model.dart';
import 'package:retailer_app/models/response_model.dart';

class ProductService {
  static Future<List<ProductModel>?> getProducts() async {
    final url = Uri.parse("https://jsonkeeper.com/b/YIDG");

    final response = await http.get(url);
    log("${response.statusCode}");
    if (response.statusCode == 200) {
      final responseModel = responseModelFromJson(response.body);
      // DatabaseHelper.createProducts(responseModel.data!.products!);
      // log(response.body);
      return responseModel.data?.products;
    }
    return null;
  }
}
