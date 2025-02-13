import 'package:fashion/common/utils/kcolors.dart';
import 'package:fashion/common/widgets/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class ProfileTile extends StatelessWidget {
  const ProfileTile(
      {super.key, required this.title, this.onTap, required this.leading});

  final String title;
  final void Function()? onTap;
  final IconData leading;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Kolors.kOffWhite,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        visualDensity: VisualDensity.compact,
        onTap: onTap,
        leading: Icon(
          leading,
          color: Kolors.kGray,
        ),
        title: Text(
          title,
          style: appStyle(13, Kolors.kDark, FontWeight.normal),
        ),
        trailing: const Icon(
          AntDesign.right,
          color: Kolors.kDark,
          size: 16,
        ),
      ),
    );
  }
}
