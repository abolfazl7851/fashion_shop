// ignore_for_file: unused_element
import 'package:fashion/src/auth/views/login_screen.dart';
import 'package:fashion/src/auth/views/registeration_screen.dart';
import 'package:fashion/src/categories/views/categoriesscreen.dart';
import 'package:fashion/src/categories/views/categorypage.dart';
import 'package:fashion/src/checkout/views/checkoutScreen.dart';
import 'package:fashion/src/checkout/views/my_payments.dart';
import 'package:fashion/src/checkout/views/verifyPaymentScreen.dart';
import 'package:fashion/src/entrypoint/views/entrypoint.dart';
import 'package:fashion/src/notification/views/notificationscreen.dart';
import 'package:fashion/src/onboarding/views/onboarding_page.dart';
import 'package:fashion/src/products/views/product_screen.dart';
import 'package:fashion/src/profile/widgets/my_orders_screen.dart';
import 'package:fashion/src/profile/widgets/policy_screen.dart';
import 'package:fashion/src/addresses/views/shipping_address_screen.dart';
import 'package:fashion/src/search/views/searchscreen.dart';
import 'package:fashion/src/splashscreen/views/splashscreen_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final GoRouter _router = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => AppEntrypoint(),
    ),
    GoRoute(
      path: '/onBoarding',
      builder: (context, state) => const OnBoardingScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterationScreen(),
    ),
    GoRoute(
      path: '/notification',
      builder: (context, state) => const NotificationScreen(),
    ),
    GoRoute(
      path: '/search',
      builder: (context, state) => const SearchScreen(),
    ),
    GoRoute(
      path: '/categories',
      builder: (context, state) => const CategoriesScreen(),
    ),
    GoRoute(
      path: '/category',
      builder: (context, state) => const CategoryPage(),
    ),
    GoRoute(
      path: '/policy',
      builder: (context, state) => const PolicyScreen(),
    ),
    GoRoute(
      path: '/myOrders',
      builder: (context, state) => const MyOrdersScreen(),
    ),
    GoRoute(
      path: '/shippingAddress',
      builder: (context, state) => const ShippingAddressScreen(),
    ),
    GoRoute(
      path: '/product/:id',
      builder: (BuildContext context, GoRouterState state) {
        final productId = state.pathParameters['id'];
        return ProductScreen(productId: productId.toString());
      },
    ),
    GoRoute(
      path: '/checkout',
      builder: (context, state) => const Checkoutscreen(),
    ),
    GoRoute(
      path: '/myPayments',
      builder: (context, state) => const MyPayments(),
    ),
    GoRoute(
      path: '/verifyPayment',
      builder: (context, state) => const VerifyPaymentScreen(),
    ),
  ],
);

GoRouter get router => _router;
