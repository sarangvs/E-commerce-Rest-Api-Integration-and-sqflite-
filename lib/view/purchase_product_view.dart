import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:retailer_app/controllers/product_purchase_view_controller.dart';
import 'package:get/get.dart';
import 'package:retailer_app/view/cart_view.dart';

class PurchaseProductView extends StatefulWidget {
  const PurchaseProductView({Key? key}) : super(key: key);

  @override
  State<PurchaseProductView> createState() => _PurchaseProductViewState();
}

class _PurchaseProductViewState extends State<PurchaseProductView> {
  final controller = Get.put(PurchaseProductViewController());

  @override
  void initState() {
    super.initState();
    controller.getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PurchaseProductViewController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Purchase Product"),
            centerTitle: true,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Badge(
                  badgeContent: Text(
                    "${controller.cartProducts.length}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  position: const BadgePosition(start: 30, bottom: 30),
                  child: IconButton(
                    onPressed: () {
                      Get.to(() => CartView);
                    },
                    icon: const Icon(Icons.shopping_cart),
                  ),
                ),
              ),
            ],
          ),
          body: controller.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(6),
                  itemBuilder: (context, index) {
                    final products = controller.products!.elementAt(index);
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: SizedBox(
                        width: 100,
                        child: Image.network(
                          products.prodImage ?? "",
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              "assets/images/error-image.jpeg",
                            );
                          },
                        ),
                      ),
                      title: Text(products.prodName ?? ""),
                      subtitle: Text(products.prodPrice ?? ""),
                      trailing: InkWell(
                        onTap: controller.cartProducts.contains(products)
                            ? null
                            : () async {
                                controller.cartProducts.add(products);

                                await controller
                                    .insertToDb(controller.cartProducts);
                                controller.update();
                              },
                        child: Container(
                          width: 70,
                          height: 27,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.blue,
                          ),
                          child: Center(
                            child: Text(
                              controller.cartProducts.contains(products)
                                  ? "Added"
                                  : "Add",
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: 10);
                  },
                  itemCount: controller.products!.length,
                ),
        );
      },
    );
  }
}
