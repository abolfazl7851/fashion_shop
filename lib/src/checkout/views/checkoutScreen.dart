import 'package:fashion/common/utils/kcolors.dart';
import 'package:fashion/common/widgets/app_style.dart';
import 'package:fashion/common/widgets/back_button.dart';
import 'package:fashion/common/widgets/reusable_text.dart';
import 'package:fashion/const/constants.dart';
import 'package:fashion/src/addresses/controller/address_notifier.dart';
import 'package:fashion/src/addresses/hooks/fetch_default.dart';
import 'package:fashion/src/addresses/widgets/address_block.dart';
import 'package:fashion/src/cart/controllers/cart_notifier.dart';
import 'package:fashion/src/checkout/controller/payment_notifier.dart';
import 'package:fashion/src/checkout/models/creat_payment_model.dart';
import 'package:fashion/src/checkout/widgets/checkoutTile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class Checkoutscreen extends HookWidget {
  const Checkoutscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final result = fetchDefaultAddress();
    final address = result.address;
    final refetch = result.refetch;


    final isLoading = result.isLoading;

    const double deliveryFee = 3.0;


    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: ReusableText(
            text: "CheckOut",
            style: appStyle(16, Kolors.kPrimary, FontWeight.bold)),
        leading: AppBackButton(
          onTap: () {
            //clear the address
            context.read<AddressNotifier>().clearAddress();
            context.pop();
          },
        ),
      ),
      body: Consumer<CartNotifier>(builder: (context, cartNotifier, child) {
        return ListView(
          padding: EdgeInsets.symmetric(
            horizontal: 12.w,
          ),
          children: [
            // add address block
            isLoading
                ? const SizedBox.shrink()
                : address == null ? const Center(child: Text('Please choes an address'),) : AddressBlock(
                    address: address,
                  ),
            SizedBox(
              height: 10.h,
            ),
            Column(
              children:
                  List.generate(cartNotifier.selectedCartItems.length, (i) {
                return CheckoutTile(
                  cart: cartNotifier.selectedCartItems[i],
                );
              }),
            ),
            SizedBox(
              height: 10.h,
            ),
            const Divider(
              color: Kolors.kGrayLight,
              height: 1,
              thickness: 1,
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReusableText(
                        text: 'Order Total:',
                        style: appStyle(14, Kolors.kGray, FontWeight.w600)),
                    SizedBox(
                      height: 10.h,
                    ),
                    ReusableText(
                        text: 'Number of items ordered:',
                        style: appStyle(14, Kolors.kGray, FontWeight.w600)),
                    SizedBox(
                      height: 10.h,
                    ),
                    ReusableText(
                        text: 'Delivery fee:',
                        style: appStyle(14, Kolors.kGray, FontWeight.w600)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ReusableText(
                        text:
                            '\$ ${cartNotifier.totalPrice.toStringAsFixed(2)}',
                        style: appStyle(16, Kolors.kDark, FontWeight.w700)),
                    SizedBox(
                      height: 10.h,
                    ),
                    ReusableText(
                        text: cartNotifier.totalQty.toString(),
                        style: appStyle(16, Kolors.kDark, FontWeight.w700)),
                    SizedBox(
                      height: 10.h,
                    ),
                    ReusableText(
                        text: '\$ ${deliveryFee.toStringAsFixed(2)}',
                        style: appStyle(16, Kolors.kDark, FontWeight.w700)),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 50.h,
            ),
            const Divider(
              color: Kolors.kGrayLight,
              height: 1,
              thickness: 1,
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ReusableText(
                    text: 'Total Cost:',
                    style: appStyle(18, Kolors.kDark, FontWeight.w600)),
                ReusableText(
                    text: '\$ ${cartNotifier.totalPrice + deliveryFee}',
                    style: appStyle(20, Kolors.kDark, FontWeight.w600))
              ],
            ),
            SizedBox(
              height: 10.h,
            )
          ],
        );
      }),
      bottomNavigationBar: Consumer<CartNotifier>(
        builder: (context, cartNotifier, child) {
          return GestureDetector(
            onTap: () {
              if (address == null) {
                context.go('/shippingAddress');
              } else {
                // context
                //     .read<PaymentNotifier>()
                //     .failedAllUserPendingPayment(address.userId, refetch);

                CreatPaymentModel paymentModel = CreatPaymentModel(
                    userCarts: cartNotifier.selectedCartItemsId,
                    price: cartNotifier.totalPrice,
                    deliveryFee: deliveryFee,
                    totalCost: deliveryFee + cartNotifier.totalPrice,
                    userId: address.userId, userAddressId: address.id);

                context.read<PaymentNotifier>().addPayment(
                    creatPaymentModelToJson(paymentModel), context, refetch);



              }
            },
            child: Container(
              height: 55,
              width: ScreenUtil().screenWidth,
              decoration: BoxDecoration(
                  color: Kolors.kPrimaryLight, borderRadius: kRadiusTop),
              child: Center(
                child: ReusableText(
                  text: address == null ? "Please an address" : "Payment",
                  style: appStyle(16, Kolors.kWhite, FontWeight.w600),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
