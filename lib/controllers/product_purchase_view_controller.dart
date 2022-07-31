import 'package:get/get.dart';
import 'package:retailer_app/db/database_handler.dart';
import 'package:retailer_app/models/product_model.dart';
import 'package:retailer_app/service/prodect_service.dart';

class PurchaseProductViewController extends GetxController {
  List<ProductModel>? _products = [];
  List<ProductModel> _cartProducts = [];

  bool _isLoading = false;

  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    update();
  }

  List<ProductModel>? get products => _products;
  set products(List<ProductModel>? value) {
    _products = value;
    update();
  }

  List<ProductModel> get cartProducts => _cartProducts;
  set cartProducts(List<ProductModel> value) {
    _cartProducts = value;
    update();
  }

  Future<void> getProducts() async {
    isLoading = true;
    products = await ProductService.getProducts();
    isLoading = false;
    update();
  }

  Future insertToDb(List<ProductModel> products) async {
    // cartProducts.add(products);
    await DatabaseHelper.insert(products);
    update();
  }
}
