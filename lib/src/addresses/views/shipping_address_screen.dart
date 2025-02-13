import 'package:fashion/common/utils/kcolors.dart';
import 'package:fashion/common/utils/kstrings.dart';
import 'package:fashion/common/widgets/app_style.dart';
import 'package:fashion/common/widgets/back_button.dart';
import 'package:fashion/common/widgets/reusable_text.dart';
import 'package:fashion/common/widgets/shimmers/list_shimmer.dart';
import 'package:fashion/const/constants.dart';
import 'package:fashion/src/addresses/controller/address_notifier.dart';
import 'package:fashion/src/addresses/hooks/fetch_address_list.dart';
import 'package:fashion/src/addresses/widgets/address_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ShippingAddressScreen extends HookWidget {
  const ShippingAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final result = fetchAddress();
    final isLoading = result.isLoading;
    final addresses = result.address;
    final refetch = result.refetch;

    if (isLoading) {
      return const Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: ListShimmer(),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        leading: AppBackButton(
          onTap: () {
            context.go('/home');
          },
        ),
        centerTitle: true,
        title: ReusableText(
            text: AppText.kAddresses,
            style: appStyle(16, Kolors.kPrimary, FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: ListView(
          children: List.generate(addresses.length, (i) {
            final address = addresses[i];
            return AddressTile(
              address: address,
              isCheckout: false,
              onDelete: () {
                context
                    .read<AddressNotifier>()
                    .deleteAddress(address.id, refetch, context);
              },
              setDefault: () {
                context
                    .read<AddressNotifier>()
                    .setAsDefault(address.id, refetch, context);
              },
            );
          }),
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          // navigate to add address page
        },
        child: Container(
          height: 55,
          width: ScreenUtil().screenWidth,
          decoration: BoxDecoration(
              color: Kolors.kPrimaryLight, borderRadius: kRadiusTop),
          child: Center(
            child: ReusableText(
                text: "Add Address",
                style: appStyle(16, Kolors.kWhite, FontWeight.w600)),
          ),
        ),
      ),
    );
  }
}
