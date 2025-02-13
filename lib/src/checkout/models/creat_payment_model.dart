// To parse this JSON data, do
//
//     final paymentModel = paymentModelFromJson(jsonString);

import 'package:fashion/src/cart/models/cart_model.dart';
import 'dart:convert';

CreatPaymentModel createPaymentModelFromJson(String str) =>
    CreatPaymentModel.fromJson(json.decode(str));

String creatPaymentModelToJson(CreatPaymentModel data) =>
    json.encode(data.toJson());

class CreatPaymentModel {
  final List<int> userCarts;
  final double price;
  final double deliveryFee;
  final double totalCost;
  final DateTime? createdAt;
  final String? orderNumber;
  final String? status;
  final int userId;
  final int userAddressId;

  CreatPaymentModel({
    required this.userCarts,
    required this.price,
    required this.deliveryFee,
    required this.totalCost,
    this.createdAt,
    this.orderNumber,
    this.status,
    required this.userId,
    required this.userAddressId
  });

  factory CreatPaymentModel.fromJson(Map<String, dynamic> json) =>
      CreatPaymentModel(
        userCarts:
            List<int>.from(json["userCarts"].map((x) => CartModel.fromJson(x))),
        price: json["price"],
        createdAt: DateTime.parse(json["createdAt"]),
        orderNumber: json["order_number"],
        status: json["status"],
        userId: json["userId"],
        deliveryFee: json['deliveryFee'],
        totalCost: json['totalCost'],
          userAddressId: json['userAddressId']
      );

  Map<String, dynamic> toJson() => {
        "userCarts": List<int>.from(userCarts.map((x) => x)),
        "price": price,
        "deliveryFee": deliveryFee,
        "totalCost": totalCost,
        "userId": userId,
        "userAddressId":userAddressId,
      };
}
