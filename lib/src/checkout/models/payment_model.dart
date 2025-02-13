// To parse this JSON data, do
//
//     final paymentModel = paymentModelFromJson(jsonString);

import 'package:fashion/src/addresses/models/address_model.dart';
import 'package:fashion/src/cart/models/cart_model.dart';
import 'dart:convert';

List<PaymentModel> paymentModelFromJson(String str) => List<PaymentModel>.from(
    json.decode(str).map((x) => PaymentModel.fromJson(x)));

String paymentModelToJson(List<PaymentModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PaymentModel {
  final int id;
  final List<CartModel> userCarts;
  final AddressModel userAddressId;
  final double price;
  final double deliveryFee;
  final double totalCost;
  final DateTime createdAt;
  final String orderNumber;
  final String status;
  final int userId;

  PaymentModel({
    required this.id,
    required this.userCarts,
    required this.price,
    required this.deliveryFee,
    required this.totalCost,
    required this.createdAt,
    required this.orderNumber,
    required this.status,
    required this.userId,
    required this.userAddressId
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
        id: json["id"],
        userCarts: List<CartModel>.from(
            json["userCarts"].map((x) => CartModel.fromJson(x))),
        price: double.parse(json["price"]),
        deliveryFee: double.parse(json["deliveryFee"]),
        totalCost: double.parse(json["totalCost"]),
        createdAt: DateTime.parse(json["createdAt"]),
        orderNumber: json["order_number"],
        status: json["status"],
        userId: json["userId"],
      userAddressId: AddressModel.fromJson(json["userAddressId"])
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userCarts": List<dynamic>.from(userCarts.map((x) => x.toJson())),
        "price": price,
        "deliveryFee":deliveryFee,
        "totalCost":totalCost,
        "createdAt": createdAt.toIso8601String(),
        "order_number": orderNumber,
        "status": status,
        "userId": userId,
        "userAddressId": userAddressId.id,
      };
}
