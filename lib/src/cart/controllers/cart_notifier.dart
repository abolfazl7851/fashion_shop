// ignore_for_file: prefer_final_fields

import 'package:fashion/common/services/storage.dart';
import 'package:fashion/common/utils/environment.dart';
import 'package:fashion/src/cart/models/cart_model.dart';
import 'package:fashion/src/entrypoint/controllers/bottom_nav_bar_notifier.dart';
import 'package:fashion/src/products/models/colors_sizes_notifier.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class CartNotifier with ChangeNotifier {
  Function? refetchCount;
  void setRefetchCount(Function r) {
    refetchCount = r;
  }

  int _qty = 0;

  int get qty => _qty;

  void incrementQty() {
    _qty++;
    notifyListeners();
  }

  void decrementQty() {
    if (_qty > 1) {
      _qty--;
      notifyListeners();
    }
  }

  int? _selecteCart;
  int? get selectedCart => _selecteCart;
  void setSelectedCounter(int id, int q) {
    _selecteCart = id;
    _qty = q;

    notifyListeners();
  }

  void clearSelected() {
    _selecteCart = null;
    _selectedCartItems.clear();
    _selectedCartItemsId.clear();
    _qty = 0;

    notifyListeners();
  }

  Future<void> deleteCart(int id, void Function() refetch) async {
    String? accessToken = Storage().getString('accessToken');

    try {
      Uri url = Uri.parse('${Environment.appBaseUrl}/api/cart/delete/?id=$id');
      final response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $accessToken',
        },
      );

      if (response.statusCode == 204) {
        refetch();
        refetchCount!();
        clearSelected();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> updateCart(int id, void Function() refetch) async {
    String? accessToken = Storage().getString('accessToken');

    try {
      Uri url = Uri.parse(
          '${Environment.appBaseUrl}/api/cart/update/?id=$id&count=$qty');
      final response = await http.patch(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $accessToken',
        },
      );

      if (response.statusCode == 200) {
        refetch();
        clearSelected();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> addToCart(String data, BuildContext ctx) async {
    String? accessToken = Storage().getString('accessToken');

    try {
      Uri url = Uri.parse('${Environment.appBaseUrl}/api/cart/add/');
      final response = await http.post(
        url,
        body: data,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $accessToken',
        },
      );

      if (response.statusCode == 201) {
        refetchCount!();
        ctx.read<ColorsSizesNotifier>().setSizes('');
        ctx.read<ColorsSizesNotifier>().setColors('');
        ctx.read<TabIndexNotifier>().setIndex(2);
        ctx.go('/home');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  List<int> _selectedCartItemsId = [];
  List<int> get selectedCartItemsId => _selectedCartItemsId;
  List<CartModel> _selectedCartItems = [];
  List<CartModel> get selectedCartItems => _selectedCartItems;

  double totalPrice = 0.0;
  int totalQty = 0;

  void selectOrDeselect(int id, CartModel cartItem) {
    if (_selectedCartItemsId.contains(id)) {
      _selectedCartItemsId.remove(id);
      _selectedCartItems.removeWhere((i) => i.id == id);
      totalPrice = calculateTotalPriceAndQty(_selectedCartItems)[0];
      totalQty = calculateTotalPriceAndQty(_selectedCartItems)[1];
    } else {
      _selectedCartItemsId.add(id);
      _selectedCartItems.add(cartItem);
      totalPrice = calculateTotalPriceAndQty(_selectedCartItems)[0];
      totalQty = calculateTotalPriceAndQty(_selectedCartItems)[1];
    }
    notifyListeners();
  }

  List<dynamic> calculateTotalPriceAndQty(List<CartModel> items) {
    double tp = 0.0;
    int qty = 0;
    for (var item in items) {
      tp += item.product.price * item.quantity;
      qty += item.quantity;
    }
    return [tp,qty];
  }

  
}
