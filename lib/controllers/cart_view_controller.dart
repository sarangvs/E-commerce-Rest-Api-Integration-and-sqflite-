import 'package:get/get.dart';
import 'package:retailer_app/controllers/product_purchase_view_controller.dart';
import 'package:retailer_app/db/database_handler.dart';
import 'package:retailer_app/models/cart_model.dart';

class CartViewController extends GetxController {
  final productPurchaseViewController =
      Get.find<PurchaseProductViewController>();

  int count = 0;

  double totalPrice = 0;

  @override
  void onInit() {
    super.onInit();

    getCount();
    retriveDbData();
    count = DatabaseHelper.queryResult.length;
    print("$count");
  }

  Future<List<CartModel>> getCount() async {
    return await DatabaseHelper.retrieveData();
  }

  List<CartModel> cartList = [];

  List<int> itemCount = [];

  void loadTotalPrice() {
    totalPrice = 0;
    if (cartList.length == itemCount.length) {
      for (int index = 0; index < cartList.length; index++) {
        final prodPrice = double.parse("${cartList[index].prodPrice}");
        final result = prodPrice * itemCount[index];
        totalPrice = totalPrice + result;
      }
    }
    update(["totalPrice"]);
  }

  Future<void> retriveDbData() async {
    final value = await DatabaseHelper.retrieveData();
    cartList = value;
    itemCount.clear();
    for (int i = 0; i < cartList.length; i++) {
      itemCount.add(1);
    }
    update(["getData"]);
    loadTotalPrice();
  }
}
