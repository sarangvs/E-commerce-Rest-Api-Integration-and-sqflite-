import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:retailer_app/controllers/product_purchase_view_controller.dart';
import 'package:get/get.dart';
import 'package:retailer_app/models/product_model.dart';
import 'package:retailer_app/service/prodect_service.dart';
import 'package:retailer_app/view/cart_view.dart';
import 'package:retailer_app/widgets/add_to_cart.dart';
import 'package:retailer_app/widgets/product_header.dart';
import 'package:velocity_x/velocity_x.dart';

class PurchaseProductView extends StatefulWidget {
  const PurchaseProductView({Key? key}) : super(key: key);

  @override
  State<PurchaseProductView> createState() => _PurchaseProductViewState();
}

class _PurchaseProductViewState extends State<PurchaseProductView> {
  final purchaseProductViewController =
      Get.put(PurchaseProductViewController());

  late int state;

  @override
  void initState() {
    super.initState();

    purchaseProductViewController.fetchCartCount();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Theme.of(context).canvasColor,
        floatingActionButton: GetBuilder<PurchaseProductViewController>(
          id: "cartCount",
          builder: (controller) {
            return Badge(
              badgeColor: Colors.white,
              padding: const EdgeInsets.all(8),
              badgeContent: Text(
                "${controller.cartCount}",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: FloatingActionButton(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  onPressed: () {
                    Get.to(() => const CartView());
                  },
                  child: const Icon(
                    CupertinoIcons.cart,
                    color: Colors.white,
                  )),
            );
          },
        ),
        body: SafeArea(
          child: Container(
            padding: Vx.m32,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CatalogHeader(),
                Expanded(
                  child: FutureBuilder(
                    future: ProductService.getProducts(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<ProductModel>?> snapshot) {
                      if (snapshot.hasData && snapshot.data != null) {
                        final products = snapshot.data!;
                        if (products.isNotEmpty) {
                          return ListView.separated(
                            padding: const EdgeInsets.all(6),
                            itemCount: products.length,
                            itemBuilder: (context, index) {
                              final product = snapshot.data![index];

                              return ProductCard(
                                productModel: product,
                                controller: purchaseProductViewController,
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const SizedBox(height: 10);
                            },
                          );
                        } else {
                          return const Center(
                            child: Text("Empty"),
                          );
                        }
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return const Center(child: Text("ERROR"));
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

class ProductCard extends StatelessWidget {
  final ProductModel productModel;
  final PurchaseProductViewController controller;

  const ProductCard({
    Key? key,
    required this.productModel,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var children2 = [
      SizedBox(
        width: 150,
        height: 60,
        child: Image.network(
          productModel.prodImage ?? "",
          errorBuilder: (context, error, stackTrace) => Image.asset(
            "assets/images/error-image.jpeg",
          ),
        ),
      ),
      30.widthBox.box.make(),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          10.heightBox.box.make(),
          '${productModel.prodName}'
              .text
              .lg
              .color(context.accentColor)
              .bold
              .make(),
          "₹${productModel.prodPrice}".text.bold.xl.make(),
          20.heightBox.box.make(),
          AddToCart(
            controller: controller,
            productModel: productModel,
          )
        ],
      ).p(context.isMobile ? 0 : 16)
    ];
    return VxBox(
      child: Row(
        children: children2,
      ),
    ).color(context.cardColor).rounded.square(150).make().py16();
  }
}
