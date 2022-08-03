import 'dart:developer';

import 'package:get/get.dart';
import 'package:retailer_app/db/database_handler.dart';
import 'package:retailer_app/models/cart_model.dart';
import 'package:retailer_app/models/product_model.dart';
import 'package:retailer_app/service/prodect_service.dart';

class PurchaseProductViewController extends GetxController {
  List<ProductModel>? _products = [];
  List<ProductModel> _cartProducts = [];
  List<CartModel> _finalProducts = [];

  int _cartCount = 0;

  bool _isLoading = false;

  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    update();
  }

  int get cartCount => _cartCount;
  set cartCount(int value) {
    _cartCount = value;
    update(["cartCount"]);
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

  List<CartModel> get finalProducts => _finalProducts;
  set finalProducts(List<CartModel> value) {
    _finalProducts = value;
    update();
  }

  Future<void> getProducts() async {
    isLoading = true;
    products = await ProductService.getProducts();
    isLoading = false;
    update();
  }

  Future<void> fetchCartCount() async {
    final value = await DatabaseHelper.retrieveData();
    cartCount = value.length;
  }

  Future<void> addProductToCart({
    required ProductModel productModel,
  }) async {
    if (productModel.isEffected == 0) {
      log("Product added");

      cartCount += 1;
      productModel.isEffected = 1;

      await DatabaseHelper.updateProduct(productModel);
      await insertToDb(
        prodCode: productModel.prodCode!,
        prodId: productModel.prodId!,
        prodImage: productModel.prodImage!,
        prodMrp: productModel.prodMrp!,
        prodName: productModel.prodName!,
        prodPrice: productModel.prodPrice!,
      );
      update(["addToCart"]);
    }
  }

  Future insertToDb({
    required String prodImage,
    required String prodId,
    required String prodCode,
    required String prodName,
    required String prodPrice,
    required String prodMrp,
  }) async {
    final cartModel = CartModel(
      prodImage: prodImage,
      prodId: prodId,
      prodCode: prodCode,
      prodName: prodName,
      prodPrice: prodPrice,
      prodMrp: prodMrp,
    );

    final List<CartModel> cart = [cartModel];

    await DatabaseHelper.insert(cart);
    update();
  }
}
