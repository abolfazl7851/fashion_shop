import 'package:fashion/common/utils/kcolors.dart';
import 'package:fashion/common/widgets/app_style.dart';
import 'package:fashion/common/widgets/reusable_text.dart';
import 'package:fashion/common/widgets/shimmers/categories_shimmer.dart';
import 'package:fashion/src/categories/controller/category_notifier.dart';
import 'package:fashion/src/categories/hook/fetch_home_categories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomeCategoriesList extends HookWidget {
  const HomeCategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    final results = fetchHomeCategories();
    final categories = results.categories;
    final isLoading = results.isLoading;
    final error = results.error;

    if (isLoading) {
      return const Padding(
        padding: EdgeInsets.all(5),
        child: CatergoriesShimmer(),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      child: SizedBox(
        width: 80.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(categories.length, (i) {
            final category = categories[i];
            return GestureDetector(
              onTap: () {
                context
                    .read<CategoryNotifier>()
                    .setCategory(category.title, category.id);
                context.push('/category');
              },
              child: SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatar(
                      backgroundColor: Kolors.kSecondaryLight,
                      child: Padding(
                        padding: EdgeInsets.all(4.h),
                        child: SvgPicture.network(
                          category.imageUrl,
                          width: 40.w,
                          height: 40.h,
                        ),
                      ),
                    ),
                    ReusableText(
                        text: category.title,
                        style: appStyle(11, Kolors.kGray, FontWeight.w500))
                    // AnimatedContainer(
                    //   width: 50,
                    //   padding: EdgeInsets.all(4.h),
                    //   height: 20,
                    //   decoration: BoxDecoration(
                    //     color: Kolors.kPrimary,
                    //     borderRadius: BorderRadius.circular(5),
                    //   ),
                    //   duration: const Duration(seconds: 3),
                    //   curve: Curves.fastOutSlowIn,
                    //   child: ReusableText(
                    //       text: 'hiiiiiiiii',
                    //       style:
                    //           appStyle(10, Kolors.kPrimary, FontWeight.normal)),
                    // ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
