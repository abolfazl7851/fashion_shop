import 'package:fashion/common/utils/kcolors.dart';
import 'package:fashion/common/widgets/app_style.dart';
import 'package:fashion/common/widgets/reusable_text.dart';
import 'package:fashion/src/addresses/controller/address_notifier.dart';
import 'package:fashion/src/addresses/models/address_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SelectAddressTile extends StatelessWidget {
  const SelectAddressTile({
    super.key,
    required this.address,
  });

  final AddressModel address;

  @override
  Widget build(BuildContext context) {
    return Consumer<AddressNotifier>(
      builder: (BuildContext context, addressNotifier, child) {
        return ListTile(
            onTap: () {
              addressNotifier.setAddress(address);
              context.pop();
            },
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
                text: address.addressTypes.toUpperCase(),
                style: appStyle(13, Kolors.kDark, FontWeight.w600)),
            subtitle: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ReusableText(
                    text: address.address,
                    style: appStyle(13, Kolors.kPrimary, FontWeight.w400)),
                ReusableText(
                    text: address.phone,
                    style: appStyle(11, Kolors.kPrimary, FontWeight.w400)),
              ],
            ),
            trailing: ReusableText(
                text: addressNotifier.address != null &&
                        addressNotifier.address!.id == address.id
                    ? "Selected"
                    : "Select",
                style: appStyle(13, Kolors.kPrimary, FontWeight.w600)));
      },
    );
  }
}
