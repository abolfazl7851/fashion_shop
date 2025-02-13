import 'package:fashion/common/services/storage.dart';
import 'package:fashion/common/utils/kcolors.dart';
import 'package:fashion/common/widgets/login_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (Storage().getString('accessToken') == null) {
          loginBottomSheet(context);
        } else {
          context.push('/notification');
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 12),
        child: CircleAvatar(
          backgroundColor: Kolors.kGray.withOpacity(0.1),
          child: const Badge(
            label: Text('4'),
            child: Icon(
              Ionicons.notifications,
              color: Kolors.kPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
