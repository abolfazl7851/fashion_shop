import 'package:flutter/material.dart';

class CategoryNotifier with ChangeNotifier {
  String category = '';
  int _id = 0;

  int get id => _id;

  void setCategory(String str, int id) {
    _id = id;
    category = str;
    notifyListeners();
  }
}
