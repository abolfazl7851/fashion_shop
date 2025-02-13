import 'package:fashion/common/services/storage.dart';
import 'package:fashion/common/utils/kcolors.dart';
import 'package:fashion/const/resource.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _navigator();
    super.initState();
  }

  _navigator() async {
    await Future.delayed(const Duration(milliseconds: 3000), () {
      if (Storage().getBool('firstOpen') == null) {
        GoRouter.of(context).go('/onBoarding');
      } else {
        GoRouter.of(context).go('/home');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Kolors.kWhite,
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(R.ASSETS_IMAGES_SPLASHSCREEN_PNG))),
      ),
    );
  }
}
