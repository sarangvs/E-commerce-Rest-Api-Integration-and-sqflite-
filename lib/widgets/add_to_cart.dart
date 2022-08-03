import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:retailer_app/controllers/product_purchase_view_controller.dart';
import 'package:retailer_app/models/product_model.dart';
import 'package:velocity_x/velocity_x.dart';

class AddToCart extends StatelessWidget {
  final PurchaseProductViewController controller;
  final ProductModel productModel;
  const AddToCart({
    Key? key,
    required this.controller,
    required this.productModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PurchaseProductViewController>(
      id: "addToCart",
      builder: (controller) {
        return ElevatedButton(
          onPressed: () {
            controller.addProductToCart(productModel: productModel);
            controller.update(["addToCart"]);
          },
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  context.theme.colorScheme.secondary),
              shape: MaterialStateProperty.all(
                const StadiumBorder(),
              )),
          child: productModel.isEffected == 1
              ? const Icon(Icons.done)
              : Row(
                  children: [
                    'Add to Cart'.text.xs.bold.make(),
                    const SizedBox(width: 5),
                    const Icon(CupertinoIcons.cart_badge_plus, size: 20),
                  ],
                ),
        );
      },
    );
  }
  //isInCart ? Icon(Icons.done)
}
