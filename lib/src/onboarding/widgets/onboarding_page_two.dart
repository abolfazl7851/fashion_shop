import 'package:fashion/common/utils/kcolors.dart';
import 'package:fashion/common/utils/kstrings.dart';
import 'package:fashion/common/widgets/app_style.dart';
import 'package:fashion/const/resource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class onBoardingScreenTwo extends StatelessWidget {
  const onBoardingScreenTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ScreenUtil().screenWidth,
      height: ScreenUtil().screenHeight,
      child: Stack(
        children: [
          Image.asset(
            R.ASSETS_IMAGES_WISHLIST_PNG,
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: 200,
            left: 30,
            right: 30,
            child: Text(
              AppText.kOnboardWishListMessage,
              textAlign: TextAlign.center,
              style: appStyle(12, Kolors.kGray, FontWeight.normal),
            ),
          )
        ],
      ),
    );
  }
}
