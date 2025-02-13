// To parse this JSON data, do
//
//     final cartModel = cartModelFromJson(jsonString);

import 'dart:convert';

import 'package:fashion/src/products/models/products_model.dart';

List<CartModel> cartModelFromJson(String str) => List<CartModel>.from(json.decode(str).map((x) => CartModel.fromJson(x)));

String cartModelToJson(List<CartModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CartModel {
    final int id;
    final ProductModel product;
    final int quantity;
    final String size;
    final String color;

    CartModel({
        required this.id,
        required this.product,
        required this.quantity,
        required this.size,
        required this.color,
    });

    factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        id: json["id"],
        product: ProductModel.fromJson(json["product"]),
        quantity: json["quantity"],
        size: json["size"],
        color: json["color"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "product": product.toJson(),
        "quantity": quantity,
        "size": size,
        "color": color,
    };
}

