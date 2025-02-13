import 'package:cached_network_image/cached_network_image.dart';
import 'package:fashion/common/utils/kcolors.dart';
import 'package:fashion/common/widgets/app_style.dart';
import 'package:fashion/common/widgets/reusable_text.dart';
import 'package:fashion/src/products/controllers/product_notifier.dart';
import 'package:fashion/src/products/models/products_model.dart';
import 'package:fashion/src/wishlist/controllers/wishList_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class StaggeredTile extends HookWidget {
  const StaggeredTile(
      {super.key, required this.i, required this.product, this.onTap});

  final int i;
  final ProductModel product;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<ProductNotifier>().setProduct(product);
        context.push('/product/${product.id}');
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          color: Kolors.kOffWhite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: i % 2 == 0 ? 163.h : 180.h,
                color: Colors.transparent,
                child: Stack(
                  children: [
                    CachedNetworkImage(
                      height: i % 2 == 0 ? 163.h : 180.h,
                      width: double.infinity,
                      imageUrl: product.imageUrls[0],
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                        right: 10.h,
                        top: 10.h,
                        child: Consumer<WishlistNotifier>(
                            builder: (context, wishListNotifier, child) {
                          return GestureDetector(
                            onTap: onTap,
                            child: CircleAvatar(
                              backgroundColor: Kolors.kSecondaryLight,
                              child: Icon(
                                AntDesign.heart,
                                color: wishListNotifier.wishList
                                        .contains(product.id)
                                    ? Kolors.kRed
                                    : Kolors.kGray,
                                size: 18,
                              ),
                            ),
                          );
                        }))
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: Text(
                        product.title,
                        overflow: TextOverflow.ellipsis,
                        style: appStyle(13, Kolors.kDark, FontWeight.w600),
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(
                          AntDesign.star,
                          color: Kolors.kGold,
                          size: 14,
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        ReusableText(
                            text: product.rating.toStringAsFixed(1),
                            style:
                                appStyle(13, Kolors.kGray, FontWeight.normal))
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                child: ReusableText(
                    text: '\$ ${product.price.toStringAsFixed(2)}',
                    style: appStyle(17, Kolors.kDark, FontWeight.w500)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
