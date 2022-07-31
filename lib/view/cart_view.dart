import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:retailer_app/controllers/cart_view_controller.dart';
import 'package:retailer_app/models/product_model.dart';

class CartView extends StatelessWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CartViewController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart View"),
        centerTitle: true,
      ),
      body: GetBuilder<CartViewController>(
        builder: (controller) {
          controller.itemCount.clear();
          for (int i = 0;
              i < controller.productPurchaseViewController.cartProducts.length;
              i++) {
            controller.itemCount.add(1);
          }
          return Column(
            children: [
              SizedBox(
                height: 520,
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: controller
                      .productPurchaseViewController.cartProducts.length,
                  itemBuilder: (context, index) {
                    final model = controller
                        .productPurchaseViewController.cartProducts
                        .elementAt(index);
                    return _buildCard(model, controller, index);
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 10);
                  },
                ),
              ),
              const SizedBox(height: 100),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  width: Get.width / 1,
                  height: 80,
                  color: Colors.grey[300],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text("Total Price"),
                          SizedBox(height: 5),
                          Text(
                            "Rs: 10000",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          Get.defaultDialog(
                            titlePadding: const EdgeInsets.only(top: 20),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 20,
                            ),
                            title: "Order Purchased",
                            content: const Center(
                              child: Text(
                                "Order has been Placed successfully",
                              ),
                            ),
                          );
                        },
                        child: Container(
                          height: 40,
                          width: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black,
                          ),
                          child: const Center(
                            child: Text(
                              "Pay Now",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  GetBuilder<CartViewController> _buildCard(
      ProductModel model, CartViewController controller, int index) {
    return GetBuilder<CartViewController>(
        id: "count",
        builder: (controller) {
          return Container(
            height: 150,
            width: Get.width / 1.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey[300],
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    child: Image.network(
                      model.prodImage ?? "",
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          "assets/images/error-image.jpeg",
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${model.prodName}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text("${model.prodShortName}"),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Rs: ${model.prodPrice}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              if (controller.itemCount[index] > 0) {
                                controller.itemCount[index]--;
                                controller.update(['count']);
                              }
                            },
                            icon: const Icon(Icons.remove)),
                        Text("${controller.itemCount[index]}"),
                        IconButton(
                          onPressed: () {
                            controller.itemCount[index]++;
                            final countValue =
                                double.tryParse(model.prodPrice!);

                            if (countValue != null) {
                              countValue * controller.itemCount[index];
                              log("not null  $countValue");
                            }
                            log("$countValue");
                            controller.update(['count']);
                          },
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
