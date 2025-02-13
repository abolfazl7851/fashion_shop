import 'package:fashion/common/utils/kcolors.dart';
import 'package:fashion/common/widgets/app_style.dart';
import 'package:fashion/common/widgets/change_address_modal.dart';
import 'package:fashion/common/widgets/reusable_text.dart';
import 'package:fashion/src/addresses/controller/address_notifier.dart';
import 'package:fashion/src/addresses/models/address_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';

class AddressTile extends StatelessWidget {
  const AddressTile(
      {super.key,
      required this.address,
      required this.isCheckout,
      this.setDefault,
      this.onDelete});

  final AddressModel address;
  final bool isCheckout;
  final void Function()? setDefault;
  final void Function()? onDelete;

  @override
  Widget build(BuildContext context) {
    return Consumer<AddressNotifier>(
      builder: (BuildContext context, addressNotifier, child) {
        return ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const CircleAvatar(
            backgroundColor: Kolors.kSecondaryLight,
            radius: 28,
            child: Icon(
              MaterialIcons.location_pin,
              size: 30,
              color: Kolors.kPrimary,
            ),
          ),
          title: ReusableText(
              text: addressNotifier.address == null
                  ? address.addressTypes.toUpperCase()
                  : addressNotifier.address!.addressTypes.toUpperCase(),
              style: appStyle(13, Kolors.kDark, FontWeight.w600)),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ReusableText(
                  text: addressNotifier.address == null
                      ? address.address
                      : addressNotifier.address!.address,
                  style: appStyle(13, Kolors.kPrimary, FontWeight.w400)),
              ReusableText(
                  text: addressNotifier.address == null
                      ? address.phone
                      : addressNotifier.address!.phone,
                  style: appStyle(11, Kolors.kPrimary, FontWeight.w400)),
            ],
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  if (isCheckout == true) {
                    changeAddressBottomSheet(context);
                  } else {
                    address.isDefault ? () {} : setDefault!();
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    color: isCheckout
                        ? Kolors.kPrimary
                        : addressNotifier.address == null
                            ? address.isDefault == true
                                ? Colors.green
                                : Kolors.kGrayLight
                            : addressNotifier.address!.isDefault == true
                                ? Colors.green
                                : Kolors.kGrayLight,
                  ),
                  child: ReusableText(
                      text: isCheckout == true
                          ? "Change"
                          : addressNotifier.address == null
                              ? address.isDefault == true
                                  ? "Default"
                                  : "Set Default"
                              : addressNotifier.address!.isDefault != true
                                  ? "Default"
                                  : "Set Default",
                      style: appStyle(14, Kolors.kWhite, FontWeight.w400)),
                  // CircleAvatar(
                  //   backgroundColor: isCheckout
                  //       ? Kolors.kSecondaryLight
                  //       : addressNotifier.address == null
                  //           ? address.isDefault == true
                  //               ? Colors.green
                  //               : Kolors.kSecondaryLight
                  //           : addressNotifier.address!.isDefault != true
                  //               ? Colors.green
                  //               : Kolors.kSecondaryLight,
                  //   radius: 18,
                  //   child: Icon(
                  //     isCheckout == true
                  //         ? MaterialIcons.edit
                  //         : addressNotifier.address == null
                  //             ? address.isDefault != true
                  //                 ? MaterialIcons.headset
                  //                 : MaterialIcons.lock_clock
                  //             : addressNotifier.address!.isDefault != true
                  //                 ? MaterialIcons.headset
                  //                 : MaterialIcons.lock_clock,
                  //     size: 22,
                  //     color: Kolors.kPrimary,
                  //   ),
                  // ),
                ),
              ),
              isCheckout == true || address.isDefault
                  ? const SizedBox.shrink()
                  : GestureDetector(
                      onTap: onDelete,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        decoration: const BoxDecoration(
                            color: Kolors.kRed,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: ReusableText(
                            text: "Delete",
                            style:
                                appStyle(14, Kolors.kWhite, FontWeight.w400)),
                      ),
                    )
            ],
          ),
        );
      },
    );
  }
}
