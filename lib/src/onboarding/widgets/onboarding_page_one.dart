import 'package:fashion/common/utils/kcolors.dart';
import 'package:fashion/common/utils/kstrings.dart';
import 'package:fashion/common/widgets/app_style.dart';
import 'package:fashion/const/resource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class onBoardingScreenOne extends StatelessWidget {
  const onBoardingScreenOne({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ScreenUtil().screenWidth,
      height: ScreenUtil().screenHeight,
      child: Stack(
        children: [
          Image.asset(
            R.ASSETS_IMAGES_EXPERIENCE_PNG,
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: 180,
            left: 30,
            right: 30,
            child: Text(
              AppText.kOnboardHome,
              textAlign: TextAlign.center,
              style: appStyle(12, Kolors.kGray, FontWeight.normal),
            ),
          )
        ],
      ),
    );
  }
}
