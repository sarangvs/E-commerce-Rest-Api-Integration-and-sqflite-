import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CatalogHeader extends StatelessWidget {
  final String retailerName;
  const CatalogHeader({Key? key, required this.retailerName});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        retailerName.text.xl5.bold
            .color(context.theme.colorScheme.secondary)
            .make(),
        "Trending products".text.xl2.make(),
      ],
    );
  }
}
