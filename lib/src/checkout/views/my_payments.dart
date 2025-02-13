import 'package:fashion/common/services/storage.dart';
import 'package:fashion/common/utils/kcolors.dart';
import 'package:fashion/common/utils/kstrings.dart';
import 'package:fashion/common/widgets/app_style.dart';
import 'package:fashion/common/widgets/back_button.dart';
import 'package:fashion/common/widgets/reusable_text.dart';
import 'package:fashion/common/widgets/shimmers/list_shimmer.dart';
import 'package:fashion/src/auth/views/login_screen.dart';
import 'package:fashion/src/checkout/hook/fetch_payments.dart';
import 'package:fashion/src/checkout/widgets/payment_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class MyPayments extends HookWidget {
  const MyPayments({super.key});

  @override
  Widget build(BuildContext context) {
    String? accessToken = Storage().getString('accessToken');

    final results = fetchPayment();
    final payments = results.payments;
    final isLoading = results.isLoading;
    final refetch = results.refetch;
    final error = results.error;

    if (accessToken == null) {
      return const LoginScreen();
    }

    if (isLoading) {
      return const Scaffold(
        body: ListShimmer(),
      );
    }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: ReusableText(
          text: AppText.kPayment,
          style: appStyle(16, Kolors.kPrimary, FontWeight.bold),
        ),
        leading: AppBackButton(
          onTap: () {
            context.pop();
          },
        ),
        centerTitle: true,
      ),
      body: ListView.separated(
          itemCount: payments.length,
          scrollDirection: Axis.vertical,
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 10.w,
              
            );
          },
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          itemBuilder: (context, i) {
            final payment = payments[i];
            return PaymentTile(payment: payment);
          }),

      // bottomNavigationBar:
      //     Consumer<PaymentNotifier>(builder: (context, paymentNotifier, child) {
      //   return GestureDetector(
      //       onTap: () {

      //         // go to zarinpal

      //       },
      //       child: pa.selectedCartItems.isNotEmpty
      //           ? Container(
      //               height: 100,
      //               padding: EdgeInsets.fromLTRB(8.w, 0, 8.w, 55.h),
      //               decoration: BoxDecoration(
      //                 color: Kolors.kPrimaryLight,
      //                 borderRadius: kRadiusTop,
      //               ),
      //               child: Row(
      //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                 children: [
      //                   Padding(
      //                     padding: const EdgeInsets.all(8.0),
      //                     child: ReusableText(
      //                         text: "Click To CheckOut",
      //                         style:
      //                             appStyle(15, Kolors.kWhite, FontWeight.w600)),
      //                   ),
      //                   Padding(
      //                     padding: const EdgeInsets.all(8.0),
      //                     child: ReusableText(
      //                         text:
      //                             "\$ ${cartNotifier.totalPrice.toStringAsFixed(2)}",
      //                         style:
      //                             appStyle(16, Kolors.kWhite, FontWeight.w700)),
      //                   )
      //                 ],
      //               ),
      //             )
      //           : const SizedBox.shrink());
      // }),
    );
  }
}


// class _PaymentState extends State<PaymentScreen> {
  // PaymentRequest _paymentRequest = PaymentRequest();
  // Uri? paymentUrl;
  // final _applinks = AppLinks();

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();

    // _applinks.uriLinkStream.listen((paymentUrl) {
    //   print('hiiii');
    //   ZarinPal()
    //       .verificationPayment("Status", "Authority Call back", _paymentRequest,
    //           (isPaymentSuccess, refID, paymentRequest, data) {
    //     if (isPaymentSuccess) {
    //       // Payment Is Success
    //       print("Success");
    //     } else {
    //       // Error Print Status
    //       print("Error payment");
    //     }
    //   });
    //   print('test');
    // });
  // }