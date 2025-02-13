import 'package:fashion/common/services/storage.dart';
import 'package:fashion/common/utils/kcolors.dart';
import 'package:fashion/common/utils/kstrings.dart';
import 'package:fashion/common/widgets/app_style.dart';
import 'package:fashion/common/widgets/custom_button.dart';
import 'package:fashion/common/widgets/reusable_text.dart';
import 'package:fashion/const/resource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class WellcomeScreen extends StatelessWidget {
  const WellcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Kolors.kWhite,
        width: ScreenUtil().screenWidth,
        height: ScreenUtil().screenHeight,
        child: Column(
          children: [
            SizedBox(
              height: 100.h,
            ),
            Image.asset(
              R.ASSETS_IMAGES_GETSTARTED_PNG,
            ),
            SizedBox(
              height: 30.h,
            ),
            Text(
              AppText.kWelcomeHeader,
              style: appStyle(24, Kolors.kPrimary, FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20.h,
            ),
            SizedBox(
              width: ScreenUtil().screenWidth - 70,
              child: Text(
                AppText.kWelcomeMessage,
                style: appStyle(12, Kolors.kGray, FontWeight.normal),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            CustomButton(
              text: AppText.KGetStarted,
              textSize: 16,
              onTap: () {
                Storage().setBool('firstOpen', true);
                context.go('/home');
              },
              btnHieght: 50,
              radius: 7,
              btnWidth: ScreenUtil().screenWidth - 70,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ReusableText(
                    text: 'Already have an account?',
                    style: appStyle(12, Kolors.kDark, FontWeight.normal)),
                TextButton(
                    onPressed: () {
                      context.go('/login');
                    },
                    child: Text(
                      'Sign In.',
                      style: appStyle(14, Colors.blue, FontWeight.bold),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
