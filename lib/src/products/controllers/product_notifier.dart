import 'package:fashion/src/products/models/products_model.dart';
import 'package:flutter/material.dart';

class ProductNotifier with ChangeNotifier {
  ProductModel? product;
  void setProduct(ProductModel p) {
    product = p;
    notifyListeners();
  }

  bool _viewMore = false;
  bool get viewMore => _viewMore;
  void setViewMore() {
    _viewMore = !_viewMore;
    notifyListeners();
  }

  void resetViewMore() {
    _viewMore = false;
  }
}
