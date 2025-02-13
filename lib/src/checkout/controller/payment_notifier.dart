// ignore_for_file: prefer_final_fields

import 'dart:async';
import 'dart:convert';

import 'package:fashion/common/services/storage.dart';
import 'package:fashion/common/utils/environment.dart';
import 'package:fashion/common/widgets/error_modal.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

class PaymentNotifier with ChangeNotifier {
  Future<void> addPayment(
      String data, BuildContext ctx, void Function() refetch) async {
    String? accessToken = Storage().getString('accessToken');

    try {
      Uri url = Uri.parse('${Environment.appBaseUrl}/api/payment/add/');
      final response = await http.post(
        url,
        body: data,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $accessToken',
        },
      );

      if (response.statusCode == 201) {
        final retData = jsonDecode(response.body) as Map<String, dynamic>;
        final paymentId = retData['paymentId'].toString();

        requestPayment(int.parse(paymentId), accessToken, ctx);
      } else if (response.statusCode == 400) {
        showErrorPopup(ctx, response.body.toString(), 'Error', true);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }


  void requestPayment(
      int paymentId, String? accessToken, BuildContext ctx) async {
    try {
      Uri url = Uri.parse('${Environment.appBaseUrl}/api/payment/zarinpal/');
      final response = await http.post(
        url,
        body: jsonEncode({"paymentId": paymentId}),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $accessToken',
        },
      );

      final data = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode == 200 && data.containsKey('paymentUrl')) {
        Uri uri = Uri.parse(data['paymentUrl']);
        ctx.go('/verifyPayment');
      } else if (response.statusCode == 400) {
        showErrorPopup(ctx, data['message'], 'Error', true);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
