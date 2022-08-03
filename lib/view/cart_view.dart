import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:retailer_app/controllers/cart_view_controller.dart';
import 'package:retailer_app/db/database_handler.dart';
import 'package:retailer_app/models/cart_model.dart';

class CartView extends StatelessWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartViewController = Get.put(CartViewController());
    return Scaffold(
      appBar: _buildAppBar(context, cartViewController),
      body: GetBuilder<CartViewController>(
        builder: (controller) {
          controller.itemCount.clear();
          for (int i = 0;
              i < controller.productPurchaseViewController.cartProducts.length;
              i++) {
            controller.itemCount.add(1);
          }
          return Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: FutureBuilder<List<CartModel>>(
                      future: DatabaseHelper.retrieveData(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<CartModel>> snapshot) {
                        if (snapshot.hasData) {
                          return ListView.separated(
                            padding: const EdgeInsets.all(16),
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              final model = snapshot.data![index];
                              controller.cartList = snapshot.data!;

                              return Dismissible(
                                background: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Row(
                                    children: const [
                                      Spacer(),
                                      Icon(CupertinoIcons.trash),
                                    ],
                                  ),
                                ),
                                key: Key(model.prodId!),
                                onDismissed: (direction) {
                                  DatabaseHelper.deleteData(
                                    int.parse(model.prodId!),
                                  );
                                  SnackBar snackBar = const SnackBar(
                                      content: Text("Item has been deleted"));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                },
                                child: CartCard(
                                  cartModel: model,
                                  controller: cartViewController,
                                  index: index,
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(height: 10);
                            },
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  width: Get.width / 1,
                  height: 100,
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
                            color: Theme.of(context).colorScheme.secondary,
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

  
  }

  AppBar _buildAppBar(BuildContext context, CartViewController controller) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new),
        onPressed: () {
          Get.back();
        },
      ),
      backgroundColor: Colors.transparent,
      centerTitle: true,
      title: Column(
        children: [
          const Text(
            "Your Cart",
            style: TextStyle(color: Colors.black),
          ),
          Text(
            "${controller.productPurchaseViewController.cartCount} items",
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }


class CartCard extends StatelessWidget {
  final int index;
  final CartModel cartModel;
  final CartViewController controller;
  const CartCard({
    Key? key,
    required this.cartModel,
    required this.index,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(12),
      color: Colors.grey[200],
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 88,
                child: AspectRatio(
                  aspectRatio: 0.88,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Image.network(
                      cartModel.prodImage ?? "",
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          "assets/images/error-image.jpeg",
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: Get.width / 1.8,
                    child: Text(
                      cartModel.prodName!,
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                      maxLines: 2,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "₹${cartModel.prodPrice}",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                ],
              )
            ],
          ),
          GetBuilder<CartViewController>(
              id: "count",
              builder: (controller) {
                controller.itemCount.clear();
                for (int i = 0;
                    i <
                        controller
                            .productPurchaseViewController.cartProducts.length;
                    i++) {
                  controller.itemCount.add(1);
                }
                return Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.remove,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    Text(
                      "${2}",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        controller.itemCount[index]++;
                        controller.update(["count"]);
                      },
                      icon: Icon(Icons.add,
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                  ],
                );
              }),
        ],
      ),
    );
  }
}
