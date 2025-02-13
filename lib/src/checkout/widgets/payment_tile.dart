import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fashion/common/utils/kcolors.dart';
import 'package:fashion/common/widgets/app_style.dart';
import 'package:fashion/common/widgets/reusable_text.dart';
import 'package:fashion/src/checkout/controller/payment_notifier.dart';
import 'package:fashion/src/checkout/models/payment_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class PaymentTile extends StatelessWidget {
  const PaymentTile({
    super.key,
    required this.payment,
    this.onPay,
  });

  final PaymentModel payment;
  final void Function()? onPay;

  @override
  Widget build(BuildContext context) {
    return Consumer<PaymentNotifier>(
        builder: (context, paymentNotifier, child) {
      return GestureDetector(
          onTap: () {},
          child: Container(
              padding: const EdgeInsets.all(8),
              width: ScreenUtil().screenWidth,
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 2.0),
                    blurRadius: 3.0,
                  ),
                ],
                color: Kolors.kWhite,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                          text: TextSpan(
                              text: "order code: ",
                              style:
                                  appStyle(14, Kolors.kGray, FontWeight.w400),
                              children: <InlineSpan>[
                            TextSpan(
                                text: payment.orderNumber,
                                style:
                                    appStyle(16, Kolors.kDark, FontWeight.w600))
                          ])),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: payment.status == 'pending'
                                ? Kolors.kGold
                                : payment.status == 'successful'
                                    ? Colors.green
                                    : payment.status == 'failed'
                                        ? Kolors.kRed
                                        : Kolors.kGrayLight,
                            borderRadius: BorderRadius.circular(10)),
                        child: ReusableText(
                            text: payment.status,
                            style:
                                appStyle(11, Kolors.kWhite, FontWeight.w600)),
                      )
                    ],
                  ),
                  RichText(
                      text: TextSpan(
                          text: "order price: ",
                          style: appStyle(14, Kolors.kGray, FontWeight.w400),
                          children: <InlineSpan>[
                        TextSpan(
                            text: payment.price.toString(),
                            style: appStyle(16, Kolors.kDark, FontWeight.w600)),
                        TextSpan(
                            text: ' \$',
                            style: appStyle(16, Kolors.kDark, FontWeight.w600))
                      ])),
                  RichText(
                      text: TextSpan(
                          text: "order time: ",
                          style: appStyle(14, Kolors.kGray, FontWeight.w400),
                          children: <InlineSpan>[
                        TextSpan(
                            text: DateFormat("yyyy-MM-dd HH:mm")
                                .format(payment.createdAt)
                                .toString(),
                            style: appStyle(16, Kolors.kDark, FontWeight.w600)),
                      ])),
                  RichText(
                      text: TextSpan(
                          text: "shipping address: ",
                          style: appStyle(14, Kolors.kGray, FontWeight.w400),
                          children: <InlineSpan>[
                        TextSpan(
                            text: '${payment.userAddressId.addressTypes.toUpperCase()} - ${payment.userAddressId.address}',
                            style: appStyle(16, Kolors.kDark, FontWeight.w600)),
                      ])),
                  Scrollbar(
                    child: SizedBox(
                      width: ScreenUtil().screenWidth,
                      height: 50,
                      child: ListView.separated(
                          itemCount: payment.userCarts.length,
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (context, index) {
                            return const VerticalDivider(
                              thickness: 1,
                              width: 1,
                              color: Kolors.kGray,
                            );
                          },
                          padding: const EdgeInsets.all(3),
                          itemBuilder: (context, i) {
                            final cart = payment.userCarts[i];
                            return CachedNetworkImage(
                                height: 50,
                                width: 50,
                                fit: BoxFit.cover,
                                imageUrl: cart.product.imageUrls[0]);
                          }),
                    ),
                  ),
                  payment.status == 'failed' || payment.status == 'successful'
                      ? const SizedBox()
                      : GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: ScreenUtil().screenWidth,
                            height: 40,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: Kolors.kPrimaryLight,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: ReusableText(
                                  text: 'Payment',
                                  style: appStyle(
                                      16, Kolors.kWhite, FontWeight.w700)),
                            ),
                          )),
                ],
              )));
    });
  }
}
