class CartModel {
  String? prodImage;
  String? prodId;
  String? prodCode;
  String? prodName;
  String? prodPrice;
  String? prodMrp;
  int itemCount;

  CartModel({
    this.prodImage,
    this.prodId,
    this.prodCode,
    this.prodName,
    this.prodPrice,
    this.prodMrp,
    this.itemCount = 1,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        prodImage: json["prodImage"],
        prodId: json["prodId"],
        prodCode: json["prodCode"],
        prodName: json["prodName"],
        prodPrice: json["prodPrice"],
        prodMrp: json["prodMrp"],
      );

  Map<String, dynamic> toJson() => {
        "prodImage": prodImage,
        "prodId": prodId,
        "prodCode": prodCode,
        "prodName": prodName,
        "prodPrice": prodPrice,
        "prodMrp": prodMrp,
        "itemCount": itemCount,
      };
}
