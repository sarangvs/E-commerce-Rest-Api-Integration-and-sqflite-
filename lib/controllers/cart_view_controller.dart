import 'package:get/get.dart';
import 'package:retailer_app/controllers/product_purchase_view_controller.dart';
import 'package:retailer_app/db/database_handler.dart';
import 'package:retailer_app/models/cart_model.dart';

class CartViewController extends GetxController {
  final productPurchaseViewController =
      Get.find<PurchaseProductViewController>();

  int count = 0;

  @override
  void onInit() {
    super.onInit();

    getCount();
    count = DatabaseHelper.queryResult.length;
    print("$count");
  }

  Future<List<CartModel>> getCount() async {
    return await DatabaseHelper.retrieveData();
  }

  List<CartModel?> cartList = [];

  List<int> itemCount = [];
}
