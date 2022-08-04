import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:retailer_app/db/database_handler.dart';
import 'package:retailer_app/view/no_order_view.dart';
import 'package:retailer_app/view/purchase_product_view.dart';

class RetailerView extends StatelessWidget {
  final String retailerName;
  const RetailerView({Key? key, required this.retailerName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Column(
        children: [
          Container(
            color: Colors.white,
            width: Get.width,
            height: 50,
            child: Text(
              retailerName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Get.to(() => PurchaseProductView(
                        retailername: retailerName,
                      ));
                },
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.check_box,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const Text(
                      "Book Order",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(width: 10),
              InkWell(
                onTap: () {
                  Get.to(() => const NoOrderView());
                },
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      child: const Center(
                          child: Icon(
                        Icons.remove_circle,
                        color: Colors.white,
                      )),
                    ),
                    const Text(
                      "No Order",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(width: 10),
              InkWell(
                onTap: () async {
                  await DatabaseHelper.deleteCartDb();

                  await Get.defaultDialog(
                      title: "Alert",
                      content: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Center(
                            child: Text("Checkout $retailerName Success"),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: const Text("Ok"))
                        ],
                      ));
                },
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.logout_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const Text(
                      "Check Out",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      )),
    );
  }
}
