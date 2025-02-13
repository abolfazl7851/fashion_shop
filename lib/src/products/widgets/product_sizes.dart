import 'package:fashion/common/utils/kcolors.dart';
import 'package:fashion/common/widgets/app_style.dart';
import 'package:fashion/src/products/controllers/product_notifier.dart';
import 'package:fashion/src/products/models/colors_sizes_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ProductSizes extends StatelessWidget {
  const ProductSizes({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ColorsSizesNotifier>(
        builder: (context, controllers, child) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
              context.read<ProductNotifier>().product!.sizes.length, (i) {
            String s = context.read<ProductNotifier>().product!.sizes[i];
            return GestureDetector(
              onTap: () {
                controllers.setSizes(s);
              },
              child: Container(
                padding: EdgeInsets.only(right: 20.w, left: 20.w),
                margin: EdgeInsets.only(right: 20.w),
                decoration: BoxDecoration(
                    color: controllers.sizes == s
                        ? Kolors.kPrimary
                        : Kolors.kGrayLight,
                    borderRadius: BorderRadius.circular(5)),
                child: Center(
                  child: Text(
                    s,
                    style: appStyle(20, Kolors.kWhite, FontWeight.bold),
                  ),
                ),
              ),
            );
          }),
        ),
      );
    });
  }
}
