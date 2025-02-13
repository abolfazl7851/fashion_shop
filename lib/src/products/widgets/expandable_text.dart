import 'package:fashion/common/utils/kcolors.dart';
import 'package:fashion/common/widgets/app_style.dart';
import 'package:fashion/src/products/controllers/product_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpandableText extends StatelessWidget {
  const ExpandableText({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          textAlign: TextAlign.justify,
          maxLines: !context.watch<ProductNotifier>().viewMore ? 2 : 10,
          style: appStyle(13, Kolors.kGray, FontWeight.normal),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: () {
                context.read<ProductNotifier>().setViewMore();
              },
              child: Text(
                !context.watch<ProductNotifier>().viewMore
                    ? "Read More"
                    : "View Less",
                style: appStyle(11, Kolors.kPrimaryLight, FontWeight.normal),
              ),
            )
          ],
        ),
      ],
    );
  }
}
