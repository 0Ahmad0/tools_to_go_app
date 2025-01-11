import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tools_to_go_app/app/features/auth/screens/change_password_screen.dart';
import 'package:tools_to_go_app/app/features/order_taker/home/widgets/order_taker_order_widget.dart';
import 'package:tools_to_go_app/core/helpers/extensions.dart';
import 'package:tools_to_go_app/core/helpers/spacing.dart';
import 'package:tools_to_go_app/core/utils/assets_manager.dart';
import 'package:tools_to_go_app/core/utils/color_manager.dart';
import 'package:tools_to_go_app/core/utils/string_manager.dart';
import 'package:tools_to_go_app/core/utils/style_manager.dart';
import 'package:tools_to_go_app/core/widgets/app_padding.dart';

import '../../../../../core/dialogs/delete_dialog.dart';
import '../../../../../core/routing/routes.dart';

class OrderTakerHomeScreen extends StatelessWidget {
  const OrderTakerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      child: Scaffold(
        appBar: AppBar(
          title: Text(StringManager.homeText),
        ),
        drawer: Drawer(
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                margin: EdgeInsets.zero,
                decoration: BoxDecoration(
                  color: ColorManager.orangeColor,
                ),
                accountName: Text(
                  'عامل توصيل',
                  style: StyleManager.font14SemiBold(),
                ),
                accountEmail: Text(
                  'email@gmail.com',
                  style: StyleManager.font12SemiBold(),
                ),
                currentAccountPicture: CircleAvatar(
                  child: Icon(FontAwesomeIcons.userLarge),
                ),
              ),
              ListTile(
                dense: true,
                onTap: () {
                  context.pop();
                  context.pushNamed(Routes.profileRoute);
                },
                leading: Icon(
                  Icons.person,
                ),
                title: Text(
                  StringManager.profileText,
                  style: StyleManager.font14SemiBold(),
                ),
              ),
              Divider(
                height: 0,
              ),
              ListTile(
                dense: true,
                onTap: () {
                  context.pop();
                  context.pushNamed(Routes.showLocationOnMapRoute);
                },
                leading: Icon(Icons.map),
                title: Text(
                  StringManager.mapViewText,
                  style: StyleManager.font14SemiBold(),
                ),
              ),
              Divider(
                height: 0,
              ),
              ListTile(
                dense: true,
                onTap: () {
                  context.pop();
                  context.pushNamed(Routes.customerChatsRoute);
                },
                leading: Icon(
                  Icons.chat_sharp,
                ),
                trailing: Badge.count(
                  count: 1,
                  textStyle: StyleManager.font10Bold(),
                ),
                title: Text(
                  StringManager.chatScreenText,
                  style: StyleManager.font14SemiBold(),
                ),
              ),
              Divider(
                height: 0,
              ),
              ListTile(
                dense: true,
                onTap: () {
                  context.pop();
                  context.pushNamed(Routes.notificationRoute);
                },
                leading: Icon(Icons.notifications),
                title: Text(
                  StringManager.notificationText,
                  style: StyleManager.font14SemiBold(),
                ),
              ),
              const Spacer(),
              Container(
                color: ColorManager.orangeColor,
                child: ListTile(
                  dense: true,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => DeleteDialog(
                        title: StringManager.logoutText,
                        subTitle: StringManager.areYouSureLogoutText,
                        onDeleteTap: () {
                          context.pushReplacement(Routes.loginRoute);
                        },
                      ),
                    );
                  },
                  leading: Icon(
                    Icons.logout,
                    color: ColorManager.whiteColor,
                  ),
                  title: Text(
                    StringManager.logoutText,
                    style: StyleManager.font14SemiBold(
                      color: ColorManager.whiteColor
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
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
      ),
    );
  }
}
