import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tools_to_go_app/app/features/auth/screens/change_password_screen.dart';
import 'package:tools_to_go_app/app/features/order_taker/home/widgets/order_taker_order_widget.dart';
import 'package:tools_to_go_app/core/helpers/spacing.dart';
import 'package:tools_to_go_app/core/utils/assets_manager.dart';
import 'package:tools_to_go_app/core/utils/color_manager.dart';
import 'package:tools_to_go_app/core/utils/string_manager.dart';
import 'package:tools_to_go_app/core/utils/style_manager.dart';
import 'package:tools_to_go_app/core/widgets/app_padding.dart';

class OrderTakerHomeScreen extends StatelessWidget {
  const OrderTakerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringManager.homeText),
      ),
      drawer: Drawer(),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              width: double.maxFinite,
              decoration: BoxDecoration(color: ColorManager.grayColor),
              child: AppPaddingWidget(
                child: Row(
                  children: [
                    Flexible(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 10.h),
                        decoration: BoxDecoration(
                            color: ColorManager.whiteColor,
                            borderRadius: BorderRadius.circular(12.r),
                            boxShadow: [
                              BoxShadow(
                                  color: ColorManager.shadowColor,
                                  blurRadius: 8.sp)
                            ]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Image.asset(
                              AssetsManager.completeOrdersIcon,
                              width: 50.w,
                              height: 50.h,
                            ),
                            verticalSpace(10.h),
                            Text(
                              StringManager.completeOrderTodayText,
                              textAlign: TextAlign.center,
                              style: StyleManager.font12SemiBold(),
                            ),
                            verticalSpace(10.h),
                            Text(
                              '${4}',
                              textAlign: TextAlign.center,
                              style: StyleManager.font30Bold(
                                  color: ColorManager.errorColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                    horizontalSpace(20.w),
                    Flexible(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 10.h),
                        decoration: BoxDecoration(
                            color: ColorManager.whiteColor,
                            borderRadius: BorderRadius.circular(12.r),
                            boxShadow: [
                              BoxShadow(
                                  color: ColorManager.shadowColor,
                                  blurRadius: 8.sp)
                            ]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Image.asset(
                              AssetsManager.activeOrderIcon,
                              width: 50.w,
                              height: 50.h,
                            ),
                            verticalSpace(10.h),
                            Text(
                              StringManager.activeOrderText,
                              textAlign: TextAlign.center,
                              style: StyleManager.font12SemiBold(),
                            ),
                            verticalSpace(10.h),
                            Text(
                              '${13}',
                              textAlign: TextAlign.center,
                              style: StyleManager.font30Bold(
                                  color: ColorManager.successColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverList.separated(
            itemBuilder: (context, index) => OrderTakerOrderWidget(
              index: ++index,
            ),
            separatorBuilder: (_, __) => Divider(),
            itemCount: 14,
          )
        ],
      ),
    );
  }
}
