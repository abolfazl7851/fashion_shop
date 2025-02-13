import 'package:fashion/src/products/models/products_model.dart';
import 'package:flutter/material.dart';

class FetchProducts {
  final List<ProductModel> products;
  final bool isLoading;
  final String? error;
  final VoidCallback refetch;

  FetchProducts(
      {required this.products,
      required this.isLoading,
      required this.error,
      required this.refetch});

      
}
