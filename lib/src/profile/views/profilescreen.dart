import 'package:easy_localization/easy_localization.dart';
import 'package:fashion/common/services/storage.dart';
import 'package:fashion/common/utils/kcolors.dart';
import 'package:fashion/common/widgets/app_style.dart';
import 'package:fashion/common/widgets/custom_button.dart';
import 'package:fashion/common/widgets/help_bottom_sheet.dart';
import 'package:fashion/common/widgets/reusable_text.dart';
import 'package:fashion/src/auth/controller/auth_notifier.dart';
import 'package:fashion/src/auth/models/profile_model.dart';
import 'package:fashion/src/auth/views/login_screen.dart';
import 'package:fashion/src/entrypoint/controllers/bottom_nav_bar_notifier.dart';
import 'package:fashion/src/profile/widgets/profile_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String? accessToken = Storage().getString('accessToken');
    if (accessToken == null) {
      return const LoginScreen();
    }
    return Scaffold(
        body: Consumer<AuthNotifier>(builder: (context, authNotifier, child) {
      ProfileModel? user = authNotifier.getUserData();

      return ListView(
        children: [
          Column(
            children: [
              SizedBox(
                height: 30.h,
              ),
              const CircleAvatar(
                radius: 45,
                backgroundColor: Kolors.kOffWhite,
                backgroundImage: NetworkImage(
                    'https://xltguhyfbgejftmxbhaa.supabase.co/storage/v1/object/public/profileImage/IMG_20240411_1024485.jpg?t=2024-08-08T15%3A49%3A09.204Z'),
              ),
              SizedBox(
                height: 15.h,
              ),
              ReusableText(
                  text: user!.email,
                  style: appStyle(11, Kolors.kGray, FontWeight.normal)),
              SizedBox(
                height: 5.h,
              ),
              ReusableText(
                  text: user.username,
                  style: appStyle(14, Kolors.kDark, FontWeight.w600)),
            ],
          ),
          SizedBox(
            height: 30.h,
          ),
          Column(
            children: [
              ProfileTile(
                title: 'My Orders',
                leading: Octicons.checklist,
                onTap: () {
                  context.push('/myOrders');
                },
              ),
              ProfileTile(
                title: 'My Payments',
                leading: MaterialIcons.payments,
                onTap: () {
                  context.push('/myPayments');
                },
              ),
              ProfileTile(
                title: 'Shipping Address',
                leading: MaterialIcons.location_pin,
                onTap: () {
                  context.push('/shippingAddress');
                },
              ),
              ProfileTile(
                title:
                    'Change Language: ${context.locale == const Locale('en') ? 'English' : 'Persian'}',
                leading: MaterialIcons.language,
                onTap: () {
                  if (context.locale == const Locale('en')) {
                    context.setLocale(const Locale('fr'));
                  } else {
                    context.setLocale(const Locale('en'));
                  }
                },
              ),
              ProfileTile(
                title: 'Privacy Policy',
                leading: MaterialIcons.policy,
                onTap: () {
                  context.push('/policy');
                },
              ),
              ProfileTile(
                title: 'Help Center',
                leading: AntDesign.customerservice,
                onTap: () => showHelpCenterBottomSheet(context),
              ),
            ],
          ),
          SizedBox(
            height: 30.h,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: CustomButton(
              text: "Logout".toUpperCase(),
              btnColor: Kolors.kRed,
              btnWidth: ScreenUtil().screenWidth,
              btnHieght: 45,
              onTap: () {
                Storage().removeKey('accessToken');
                Storage().removeKey('${accessToken}_wishList');
                context.read<TabIndexNotifier>().setIndex(0);
                context.go('/home');
              },
            ),
          )
        ],
      );
    }));
  }
}
