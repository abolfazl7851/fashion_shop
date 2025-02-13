import 'package:fashion/common/services/storage.dart';
import 'package:fashion/common/utils/kcolors.dart';
import 'package:fashion/common/utils/kstrings.dart';
import 'package:fashion/common/widgets/app_style.dart';
import 'package:fashion/common/widgets/reusable_text.dart';
import 'package:fashion/src/auth/views/login_screen.dart';
import 'package:fashion/src/wishlist/widgets/wish_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class Wishlistscreen extends HookWidget {
  const Wishlistscreen({super.key});

  @override
  Widget build(BuildContext context) {
    String? accessToken = Storage().getString('accessToken');
    if (accessToken == null) {
      return const LoginScreen();
    }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: ReusableText(
          text: AppText.kWishlist,
          style: appStyle(16, Kolors.kPrimary, FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: WishListWidget(),
      ),
    );
  }
}
