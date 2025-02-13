import 'package:fashion/common/utils/kcolors.dart';
import 'package:fashion/common/widgets/app_style.dart';
import 'package:fashion/src/cart/hooks/fetch_cart_count.dart';
import 'package:fashion/src/cart/views/cartscreen.dart';
import 'package:fashion/src/entrypoint/controllers/bottom_nav_bar_notifier.dart';
import 'package:fashion/src/home/views/homescreen.dart';
import 'package:fashion/src/profile/views/profilescreen.dart';
import 'package:fashion/src/wishlist/views/wishlistscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';

class AppEntrypoint extends HookWidget {
  AppEntrypoint({super.key});

  List<Widget> pageList = [
    const HomeScreen(),
    const Wishlistscreen(),
    const CartScreen(),
    const ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    final results = fetchCartCount(context);

    final data = results.count;
    return Consumer<TabIndexNotifier>(
        builder: (context, TabIndexNotifier, child) {
      return Scaffold(
        body: Stack(
          children: [
            pageList[TabIndexNotifier.index],
            Align(
              alignment: Alignment.bottomCenter,
              child: Theme(
                  data: Theme.of(context).copyWith(
                    canvasColor: Kolors.kOffWhite,
                  ),
                  child: BottomNavigationBar(
                    selectedFontSize: 12,
                    elevation: 0,
                    showSelectedLabels: true,
                    selectedLabelStyle:
                        appStyle(9, Kolors.kPrimary, FontWeight.w500),
                    selectedItemColor: Kolors.kPrimary,
                    unselectedItemColor: Kolors.kGray,
                    showUnselectedLabels: false,
                    currentIndex: TabIndexNotifier.index,
                    onTap: (i) {
                      TabIndexNotifier.setIndex(i);
                    },
                    unselectedIconTheme:
                        const IconThemeData(color: Colors.black38),
                    items: [
                      BottomNavigationBarItem(
                          icon: TabIndexNotifier.index == 0
                              ? const Icon(
                                  Ionicons.home,
                                  color: Kolors.kPrimary,
                                  size: 24,
                                )
                              : const Icon(
                                  Ionicons.home_outline,
                                  size: 24,
                                ),
                          label: 'Home'),
                      BottomNavigationBarItem(
                          icon: TabIndexNotifier.index == 1
                              ? const Icon(
                                  Ionicons.heart,
                                  color: Kolors.kPrimary,
                                  size: 24,
                                )
                              : const Icon(
                                  Ionicons.heart_outline,
                                  size: 24,
                                ),
                          label: 'WishList'),
                      BottomNavigationBarItem(
                          icon: TabIndexNotifier.index == 2
                              ? Badge(
                                  label: Text(data.cartCount.toString()),
                                  child: const Icon(
                                    MaterialCommunityIcons.shopping,
                                    color: Kolors.kPrimary,
                                    size: 24,
                                  ),
                                )
                              : Badge(
                                  label: Text(data.cartCount.toString()),
                                  child: const Icon(
                                    MaterialCommunityIcons.shopping_outline,
                                  ),
                                ),
                          label: 'Cart'),
                      BottomNavigationBarItem(
                          icon: TabIndexNotifier.index == 3
                              ? const Icon(
                                  Ionicons.person,
                                  color: Kolors.kPrimary,
                                  size: 24,
                                )
                              : const Icon(
                                  Ionicons.person_outline,
                                  size: 24,
                                ),
                          label: 'profile'),
                    ],
                  )),
            )
          ],
        ),
      );
    });
  }
}
