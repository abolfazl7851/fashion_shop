import 'package:fashion/common/utils/kcolors.dart';
import 'package:fashion/common/widgets/app_style.dart';
import 'package:fashion/common/widgets/tab_widget.dart';
import 'package:fashion/src/home/views/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeTabs extends StatelessWidget {
  const HomeTabs({super.key, required TabController tabController})
      : _tabController = tabController;

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 22.h,
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
            color: Kolors.kPrimary, borderRadius: BorderRadius.circular(5)),
        labelPadding: EdgeInsets.zero,
        labelColor: Kolors.kWhite,
        dividerColor: Colors.transparent,
        tabAlignment: TabAlignment.start,
        isScrollable: true,
        labelStyle: appStyle(11, Kolors.kPrimary, FontWeight.w600),
        unselectedLabelStyle: appStyle(10, Kolors.kGray, FontWeight.w400),
        tabs: List.generate(
            homeTabs.length,
            (i) => Tab(
                  child: TabWidget(
                    text: homeTabs[i],
                  ),
                )),
      ),
    );
  }
}
