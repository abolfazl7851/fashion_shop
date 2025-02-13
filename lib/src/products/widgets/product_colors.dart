import 'package:fashion/common/utils/kcolors.dart';
import 'package:fashion/common/widgets/app_style.dart';
import 'package:fashion/common/widgets/reusable_text.dart';
import 'package:fashion/src/products/controllers/product_notifier.dart';
import 'package:fashion/src/products/models/colors_sizes_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ProductColors extends StatelessWidget {
  const ProductColors({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ColorsSizesNotifier>(
        builder: (context, controllers, child) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
              context.read<ProductNotifier>().product!.colors.length, (i) {
            String c = context.read<ProductNotifier>().product!.colors[i];
            return GestureDetector(
              onTap: () {
                controllers.setColors(c);
              },
              child: Container(
                padding: EdgeInsets.only(right: 20.w, left: 20.w),
                margin: EdgeInsets.only(right: 20.w),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: c == controllers.colors
                        ? Kolors.kPrimary
                        : Kolors.kGrayLight),
                child: ReusableText(
                    text: c,
                    style: appStyle(20, Kolors.kWhite, FontWeight.bold)),
              ),
            );
          }),
        ),
      );
    });
  }
}
