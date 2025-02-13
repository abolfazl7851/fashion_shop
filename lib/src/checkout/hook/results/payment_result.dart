import 'package:fashion/src/checkout/models/payment_model.dart';
import 'package:flutter/material.dart';

class FetchPayment {
  final List<PaymentModel> payments;
  final bool isLoading;
  final String? error;
  final VoidCallback refetch;

  FetchPayment(
      {required this.payments,
      required this.isLoading,
      required this.error,
      required this.refetch});
}
