// ignore_for_file: use_build_context_synchronously

import 'package:fashion/common/models/api_error_model.dart';
import 'package:fashion/common/services/storage.dart';
import 'package:fashion/common/utils/environment.dart';
import 'package:fashion/common/widgets/error_modal.dart';
import 'package:fashion/src/addresses/models/address_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddressNotifier with ChangeNotifier {
  AddressModel? address;
  void setAddress(AddressModel a) {
    address = a;
    notifyListeners();
  }

  void clearAddress() {
    address = null;
    notifyListeners();
  }

  List<String> addressTypes = ['HOME', 'SCHOOL', 'OFFICE'];
  String _addressType = '';

  String get addressType => _addressType;

  void clearAddressType() {
    _addressType = '';
  }

  bool _defaultToggle = false;
  void setDefaultToggle(bool d) {
    _defaultToggle = d;
    notifyListeners();
  }

  bool get defaultToggle => _defaultToggle;

  void clearDefaultToggle() {
    _defaultToggle = false;
  }

  void setAsDefault(int id, Function refetch, BuildContext context) async {
    String? accessToken = Storage().getString('accessToken');
    try {
      Uri url =
          Uri.parse('${Environment.appBaseUrl}/api/address/default/?id=$id');
      final response = await http.patch(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Token $accessToken',
      });

      if (response.statusCode == 200) {
        refetch();
      } else if (response.statusCode == 404 || response.statusCode == 400) {
        var data = apiErrorFromJson(response.body);
        showErrorPopup(context, data.message, 'Error Changing Address', true);
        print('Error: $data');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void deleteAddress(int id, Function refetch, BuildContext context) async {
    String? accessToken = Storage().getString('accessToken');
    try {
      Uri url =
          Uri.parse('${Environment.appBaseUrl}/api/address/delete/?id=$id');
      final response = await http.delete(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Token $accessToken',
      });

      if (response.statusCode == 200) {
        refetch();
      } else if (response.statusCode == 404 || response.statusCode == 400) {
        var data = apiErrorFromJson(response.body);
        showErrorPopup(context, data.message, 'Error Deleting Address', true);
        print('Error: $data');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
