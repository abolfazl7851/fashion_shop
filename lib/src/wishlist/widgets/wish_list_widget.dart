import 'package:fashion/common/services/storage.dart';
import 'package:fashion/common/widgets/empty_screen_widget.dart';
import 'package:fashion/common/widgets/login_bottom_sheet.dart';
import 'package:fashion/common/widgets/shimmers/list_shimmer.dart';
import 'package:fashion/src/products/widgets/staggered_tile.dart';
import 'package:fashion/src/wishlist/controllers/wishList_notifier.dart';
import 'package:fashion/src/wishlist/hooks/fetch_wishList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class WishListWidget extends HookWidget {
  const WishListWidget({super.key});

 @override
  Widget build(BuildContext context) {
   String? accessToken = Storage().getString('accessToken');

    final results = fetchWishList();
    final products = results.products;
    final isLoading = results.isLoading;
    final refetch = results.refetch;
    final error = results.error;

    if (isLoading) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: const ListShimmer(),
      );
    }
    
    
    return products.isEmpty
        ? const EmptyScreenWidget()
        : Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.h),
            child: StaggeredGrid.count(
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              crossAxisCount: 4,
              children: List.generate(products.length, (i) {
                final double mainAxisCellCount = (i % 2 == 0 ? 2.3 : 2.5);
                final product = products[i];
                return StaggeredGridTile.count(
                    crossAxisCellCount: 2,
                    mainAxisCellCount: mainAxisCellCount,
                    child: StaggeredTile(
                      i: i,
                      product: product,
                      onTap: () {
                        if (accessToken == null) {
                          loginBottomSheet(context);
                        } else {
                          context
                              .read<WishlistNotifier>()
                              .addRemoveWishList(product.id, refetch);
                        }
                      },
                    ));
              }),
            ),
          );
  }
}
