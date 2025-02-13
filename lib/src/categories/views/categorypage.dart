import 'package:fashion/common/utils/kcolors.dart';
import 'package:fashion/common/widgets/app_style.dart';
import 'package:fashion/common/widgets/back_button.dart';
import 'package:fashion/common/widgets/reusable_text.dart';
import 'package:fashion/src/categories/controller/category_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/products_by_category.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: ReusableText(
            text: context.read<CategoryNotifier>().category,
            style: appStyle(16, Kolors.kPrimary, FontWeight.bold)),
        centerTitle: true,
      ),
      body: const ProductsByCategory(),
    );
  }
}
 