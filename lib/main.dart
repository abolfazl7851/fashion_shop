import 'package:easy_localization/easy_localization.dart';
import 'package:fashion/common/utils/app_routes.dart';
import 'package:fashion/common/utils/environment.dart';
import 'package:fashion/common/utils/kstrings.dart';
import 'package:fashion/src/addresses/controller/address_notifier.dart';
import 'package:fashion/src/auth/controller/auth_notifier.dart';
import 'package:fashion/src/auth/controller/password_notifier.dart';
import 'package:fashion/src/cart/controllers/cart_notifier.dart';
import 'package:fashion/src/categories/controller/category_notifier.dart';
import 'package:fashion/src/checkout/controller/payment_notifier.dart';
import 'package:fashion/src/entrypoint/controllers/bottom_nav_bar_notifier.dart';
import 'package:fashion/src/home/controllers/home_tab_notifier.dart';
import 'package:fashion/src/onboarding/controllers/onboarding_notifier.dart';
import 'package:fashion/src/products/controllers/product_notifier.dart';
import 'package:fashion/src/products/models/colors_sizes_notifier.dart';
import 'package:fashion/src/search/controller/search_notifier.dart';
import 'package:fashion/src/splashscreen/views/splashscreen_page.dart';
import 'package:fashion/src/wishlist/controllers/wishList_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: Environment.fileName);

  await GetStorage.init();

  await EasyLocalization.ensureInitialized();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => OnboardingNotifier()),
      ChangeNotifierProvider(create: (_) => TabIndexNotifier()),
      ChangeNotifierProvider(create: (_) => CategoryNotifier()),
      ChangeNotifierProvider(create: (_) => HomeTabNotifier()),
      ChangeNotifierProvider(create: (_) => ProductNotifier()),
      ChangeNotifierProvider(create: (_) => ColorsSizesNotifier()),
      ChangeNotifierProvider(create: (_) => PasswordNotifier()),
      ChangeNotifierProvider(create: (_) => AuthNotifier()),
      ChangeNotifierProvider(create: (_) => SearchNotifier()),
      ChangeNotifierProvider(create: (_) => WishlistNotifier()),
      ChangeNotifierProvider(create: (_) => CartNotifier()),
      ChangeNotifierProvider(create: (_) => PaymentNotifier()),
      ChangeNotifierProvider(create: (_) => AddressNotifier()),
    ],
    child: EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('fr')],
        path: 'assets/language',
        fallbackLocale: const Locale('en'),
        child: const MyApp()),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return ScreenUtilInit(
        designSize: screenSize,
        minTextAdapt: true,
        splitScreenMode: false,
        useInheritedMediaQuery: true,
        builder: (_, child) {
          return MaterialApp.router(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            title: AppText.KAppName,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            routerConfig: router,
          );
        },
        child: const SplashScreen());
  }
}
