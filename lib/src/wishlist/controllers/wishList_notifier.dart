import 'dart:convert';

import 'package:fashion/common/services/storage.dart';
import 'package:fashion/common/utils/environment.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WishlistNotifier with ChangeNotifier {
  String? error;
  void setError(String e) {
    error = e;
    notifyListeners();
  }

  void addRemoveWishList(int id, Function refetch) async {
    final accessToken = Storage().getString('accessToken');

    try {
      Uri url =
          Uri.parse('${Environment.appBaseUrl}/api/wishlist/toggle/?id=$id');
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $accessToken',
        },
      );

      if (response.statusCode == 201) {
        setToWishList(id);
        refetch();
      } else if (response.statusCode == 204) {
        setToWishList(id);
        refetch();
      }
    } catch (e) {
      error = e.toString();
    }
  }

  List _wishList = [];

  List get wishList => _wishList;

  void setWishList(List w) {
    _wishList.clear();
    _wishList = w;
    notifyListeners();
  }

// add or remove product to wishlist and shared prefrences!
  void setToWishList(int v) {
    String? accessToken = Storage().getString('accessToken');
    String? wishList = Storage().getString('${accessToken}_wishList');


    if (wishList == null) {
      List wishList = [];
      wishList.add(v);
      setWishList(wishList);
      Storage().setString('${accessToken}_wishList', jsonEncode(wishList));
    } else {
      List w = jsonDecode(wishList);
      if (w.contains(v)) {
        w.removeWhere((e) => e == v);
        setWishList(w);
        Storage().setString('${accessToken}_wishList', jsonEncode(w));
      } else if (!w.contains(v)) {
        w.add(v);
        setWishList(w);
        Storage().setString('${accessToken}_wishList', jsonEncode(w));
      }
    }
  }
}
