// To parse this JSON data, do
//
//     final responseModel = responseModelFromJson(jsonString);

import 'dart:convert';

import 'package:retailer_app/models/product_model.dart';

ResponseModel responseModelFromJson(String str) =>
    ResponseModel.fromJson(json.decode(str));

String responseModelToJson(ResponseModel data) => json.encode(data.toJson());

class ResponseModel {
  ResponseModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  Data? data;

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  Data({
    this.products,
  });

  List<ProductModel>? products;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        products: List<ProductModel>.from(
          json["products"].map(
            (x) => ProductModel.fromJson(x),
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
        "products": List<dynamic>.from(
          products ??
              <ProductModel>[].map(
                (x) => x.toJson(),
              ),
        ),
      };
}
