import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tools_to_go_app/app/features/navbar/widgets/home_tool_item_widget.dart';
import 'package:tools_to_go_app/core/helpers/extensions.dart';
import 'package:tools_to_go_app/core/helpers/spacing.dart';
import 'package:tools_to_go_app/core/utils/color_manager.dart';
import 'package:tools_to_go_app/core/utils/string_manager.dart';
import 'package:tools_to_go_app/core/utils/style_manager.dart';
import 'package:tools_to_go_app/core/widgets/app_padding.dart';

import '../../../../core/dialogs/delete_dialog.dart';
import '../../../../core/routing/routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      child: Scaffold(
        drawer: Drawer(
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                margin: EdgeInsets.zero,
                decoration: BoxDecoration(
                  color: ColorManager.orangeColor,
                ),
                accountName: Text(
                  'ياسر',
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
        appBar: AppBar(
          title: Text(StringManager.homeText),
        ),
        body: AppPaddingWidget(
          horizontalPadding: 12.w,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
            decoration: BoxDecoration(
                color: ColorManager.whiteColor,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: ColorManager.hintTextColor)),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Text(
                    StringManager.homeText,
                    style: StyleManager.font24Bold(),
                  ),
                ),
                SliverToBoxAdapter(
                  child: verticalSpace(20.h),
                ),
                SliverToBoxAdapter(
                  child: Row(
                    children: [
                      Flexible(
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10.r),
                          onTap: () {},
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 12.h),
                            decoration: BoxDecoration(
                                color: ColorManager.whiteColor,
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(
                                  color: ColorManager.hintTextColor,
                                )),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.build),
                                verticalSpace(20.h),
                                Text(
                                  StringManager.electricityText,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      horizontalSpace(10.w),
                      Flexible(
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10.r),
                          onTap: () {},
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 12.h),
                            decoration: BoxDecoration(
                                color: ColorManager.whiteColor,
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(
                                  color: ColorManager.hintTextColor,
                                )),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.location_on_rounded),
                                verticalSpace(20.h),
                                Text(
                                  StringManager.netherMeText,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: verticalSpace(20.h),
                ),
                SliverToBoxAdapter(
                  child: Text(
                    StringManager.vipToolsText,
                    style: StyleManager.font14SemiBold(),
                  ),
                ),
                SliverToBoxAdapter(
                  child: verticalSpace(20.h),
                ),
                SliverList.separated(
                  itemBuilder: (context, index) => HomeToolItemWidget(
                    index: ++index,
                  ),
                  separatorBuilder: (_, __) => verticalSpace(10.h),
                  itemCount: 10,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
