import 'dart:convert';

import 'package:fashion/common/services/storage.dart';
import 'package:fashion/common/utils/environment.dart';
import 'package:fashion/common/utils/kstrings.dart';
import 'package:fashion/common/widgets/error_modal.dart';
import 'package:fashion/src/auth/models/access_token_model.dart';
import 'package:fashion/src/auth/models/profile_model.dart';
import 'package:fashion/src/entrypoint/controllers/bottom_nav_bar_notifier.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AuthNotifier with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool _isRLoading = false;

  bool get isRLoading => _isRLoading;

  void setRLoading(bool value) {
    _isRLoading = value;
    notifyListeners();
  }

  void loginFunc(String data, BuildContext ctx) async {
    setLoading(true);

    try {
      var url = Uri.parse('${Environment.appBaseUrl}/auth/token/login');

      var response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
          },
          body: data);

      if (response.statusCode == 200) {
        String accessToken = accessTokenModelFromJson(response.body).authToken;

        getUser(accessToken, ctx);
      } else {
        setLoading(false);
        showErrorPopup(ctx, AppText.kErrorLogin, null, null);
      }
    } catch (e) {
      setLoading(false);

      showErrorPopup(ctx, e.toString(), null, null);
    }
  }

  void registrationFunc(String data, BuildContext ctx) async {
    setRLoading(true);
    try {
      var url = Uri.parse('${Environment.appBaseUrl}/auth/users/');
      var response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
          },
          body: data);

      if (response.statusCode == 201) {
        setRLoading(false);

        ctx.pop();
      } else if (response.statusCode == 400) {
        setRLoading(false);
        var data = jsonDecode(response.body);

        showErrorPopup(ctx, data['password'][0], null, null);
      } else {
        setRLoading(false);
      }
    } catch (e) {
      setRLoading(false);

      showErrorPopup(ctx, AppText.kErrorLogin, null, null);
    }
  }

  void getUser(String accessToken, BuildContext ctx) async {
    try {
      var url = Uri.parse('${Environment.appBaseUrl}/auth/users/me/');

      var response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $accessToken',
        },
      );

      if (response.statusCode == 200) {
        Storage().setString('accessToken', accessToken);

        Storage().setString(accessToken, response.body);

        setLoading(false);
        ctx.read<TabIndexNotifier>().setIndex(0);
        ctx.go('/home');
      } else {
        setLoading(false);
      }
    } catch (e) {
      setLoading(false);

      showErrorPopup(ctx, e.toString(), null, null);
    }
  }

  ProfileModel? getUserData() {
    String? accessToken = Storage().getString('accessToken');

    if (accessToken != null) {
      var data = Storage().getString(accessToken);
      if (data != null) {
        return profileModelFromJson(data);
      }
    }
    return null;
  }
}
