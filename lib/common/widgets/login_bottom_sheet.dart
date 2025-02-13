import 'package:fashion/common/utils/kcolors.dart';
import 'package:fashion/common/utils/kstrings.dart';
import 'package:fashion/common/widgets/app_style.dart';
import 'package:fashion/common/widgets/custom_button.dart';
import 'package:fashion/common/widgets/reusable_text.dart';
import 'package:fashion/const/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

Future<dynamic> loginBottomSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: 200,
        decoration: BoxDecoration(borderRadius: kRadiusTop),
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            SizedBox(
              height: 10.h,
            ),
            Center(
                child: ReusableText(
                    text: AppText.kLogin,
                    style: appStyle(16, Kolors.kPrimary, FontWeight.w500))),
            SizedBox(
              height: 10.h,
            ),
            Divider(
              color: Kolors.kGrayLight,
              thickness: 0.5.h,
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Center(
                  child: ReusableText(
                      text: AppText.kLoginText,
                      style: appStyle(12, Kolors.kGray, FontWeight.w500))),
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: CustomButton(
                text: 'Proceed to Login',
                textSize: 16,
                onTap: () {
                  context.go('/login');
                },
                btnHieght: 50,
                radius: 7,
                btnWidth: ScreenUtil().screenWidth * 0.5,
              ),
            )
          ],
        ),
      );
    },
  );
}
