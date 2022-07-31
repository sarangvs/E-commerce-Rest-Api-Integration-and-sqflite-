class ProductModel {
  ProductModel({
    this.prodImage,
    this.prodId,
    this.prodCode,
    this.barCode,
    this.prodName,
    this.uom,
    this.unitId,
    this.prodCombo,
    this.isFocused,
    this.groupIds,
    this.categoryIds,
    this.unitFromValue,
    this.unitToValue,
    this.uomAlternateName,
    this.uomAlternateId,
    this.underWarranty,
    this.groupId,
    this.catId,
    this.prodHsnId,
    this.prodHsnCode,
    this.prodShortName,
    this.prodPrice,
    this.prodMrp,
    this.prodBuy,
    this.prodSell,
    this.prodFreeItem,
    this.prodRkPrice,
  });

  String? prodImage;
  String? prodId;
  String? prodCode;
  String? barCode;
  String? prodName;
  String? uom;
  String? unitId;
  String? prodCombo;
  String? isFocused;
  String? groupIds;
  String? categoryIds;
  String? unitFromValue;
  String? unitToValue;
  String? uomAlternateName;
  String? uomAlternateId;
  String? underWarranty;
  String? groupId;
  String? catId;
  String? prodHsnId;
  String? prodHsnCode;
  String? prodShortName;
  String? prodPrice;
  String? prodMrp;
  String? prodBuy;
  String? prodSell;
  String? prodFreeItem;
  String? prodRkPrice;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        prodImage: json["prodImage"],
        prodId: json["prodId"],
        prodCode: json["prodCode"],
        barCode: json["barCode"],
        prodName: json["prodName"],
        uom: json["UOM"],
        unitId: json["unit_id"],
        prodCombo: json["prod_combo"],
        isFocused: json["is_focused"],
        groupIds: json["group_ids"],
        categoryIds: json["category_ids"],
        unitFromValue: json["unit_from_value"],
        unitToValue: json["unit_to_value"],
        uomAlternateName: json["uom_alternate_name"],
        uomAlternateId: json["uom_alternate_id"],
        underWarranty: json["under_warranty"],
        groupId: json["groupId"],
        catId: json["catId"],
        prodHsnId: json["prodHsnId"],
        prodHsnCode: json["prodHsnCode"],
        prodShortName: json["prodShortName"],
        prodPrice: json["prodPrice"],
        prodMrp: json["prodMrp"],
        prodBuy: json["prodBuy"],
        prodSell: json["prodSell"],
        prodFreeItem: json["prodFreeItem"],
        prodRkPrice: json["prodRkPrice"],
      );

  Map<String, dynamic> toJson() => {
        "prodId": prodId,
        "prodImage": prodImage,
        "prodCode": prodCode,
        "prodName": prodName,
        "prodPrice": prodPrice,
        "prodMrp": prodMrp,
      };
}
