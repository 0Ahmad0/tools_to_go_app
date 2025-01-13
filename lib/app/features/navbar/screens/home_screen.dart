import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tools_to_go_app/app/features/navbar/widgets/home_tool_item_widget.dart';
import 'package:tools_to_go_app/core/helpers/extensions.dart';
import 'package:tools_to_go_app/core/helpers/spacing.dart';
import 'package:tools_to_go_app/core/utils/color_manager.dart';
import 'package:tools_to_go_app/core/utils/string_manager.dart';
import 'package:tools_to_go_app/core/utils/style_manager.dart';
import 'package:tools_to_go_app/core/widgets/app_padding.dart';

import '../../../../core/dialogs/delete_dialog.dart';
import '../../../../core/models/tool.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/widgets/constants_widgets.dart';
import '../../../../core/widgets/image_user_provider.dart';
import '../../../../core/widgets/no_data_found_widget.dart';
import '../../auth/controller/auth_controller.dart';
import '../../owner_tools/home/controller/tools_controller.dart';
import '../../profile/controller/profile_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ToolsController controller;
  void initState() {
    controller = Get.put(ToolsController());
    controller.onInit();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      child: Scaffold(
        drawer: Drawer(
          child: Column(
            children: [
              GetBuilder<ProfileController>(
                  init: Get.put(ProfileController()),
                  builder: (controller) {
                    return
                      UserAccountsDrawerHeader(
                        margin: EdgeInsets.zero,
                        decoration: BoxDecoration(
                          color: ColorManager.orangeColor,
                        ),
                        accountName: Text(
                          controller.currentUser.value?.name ??
                          'ياسر',
                          style: StyleManager.font14SemiBold(),
                        ),
                        accountEmail: Text(
                          controller.currentUser.value?.email ??
                          'email@gmail.com',
                          style: StyleManager.font12SemiBold(),
                        ),
                        currentAccountPicture:
                        ImageUserProvider(
                          url: controller.currentUser.value?.photoUrl,
                        )
                        // CircleAvatar(
                        //   child: Icon(FontAwesomeIcons.userLarge),
                        // ),
                      );
                  }
              )
             ,
              ListTile(
                dense: true,
                onTap: () {

                  context.pushNamed(Routes.customerRequestsRoute);
                },
                leading: Icon(
                  Icons.shopping_cart,
                ),
                title: Text(
                  StringManager.myRequestsText,
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
                  context.pushNamed(Routes.customerSearchRoute);
                },
                leading: Icon(
                  Icons.search,
                ),
                title: Text(
                  StringManager.searchText,
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
                  context.pushNamed(Routes.customerSettingRoute);
                },
                leading: Icon(
                  Icons.settings,
                ),
                title: Text(
                  StringManager.settingText,
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
                trailing: Badge.count(
                  count: 1,
                  textStyle: StyleManager.font10Bold(),
                ),
                leading: Icon(Icons.notifications),
                title: Text(
                  StringManager.notificationText,
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
                          context.pop();
                          Get.lazyPut(() => AuthController());
                          AuthController.instance.signOut(context);
                          // context.pushReplacement(Routes.loginRoute);
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
                        color: ColorManager.whiteColor),
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

                StreamBuilder<QuerySnapshot>(
                    stream: controller.getTools,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return   SliverToBoxAdapter(child: ConstantsWidgets.circularProgress(),) ;
                      } else if (snapshot.connectionState ==
                          ConnectionState.active) {
                        if (snapshot.hasError) {
                          return  SliverToBoxAdapter(child: Text('Error'));
                        } else if (snapshot.hasData) {
                          SliverToBoxAdapter(child: ConstantsWidgets.circularProgress(),);
                          controller.tools.items.clear();
                          if (snapshot.data!.docs.length > 0) {

                            controller.tools.items =
                                Tools.fromJson(snapshot.data?.docs).items;
                          }
                          // controller.classification();
                          return
                            GetBuilder<ToolsController>(
                                builder: (ToolsController toolsController)=>

                                (toolsController.tools.items.isEmpty ?? true)
                                    ?
                                SliverFillRemaining(child: Center(child: NoDataFoundWidget(text: StringManager.noToolsText)))
                                    :
                                buildTools(context, toolsController.tools.items));
                        } else {
                          return SliverToBoxAdapter(child: const Text('Empty data'));
                        }
                      } else {
                        return SliverToBoxAdapter(child: Text('State: ${snapshot.connectionState}'));
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget buildTools(BuildContext context,List<ToolModel> items){
    return
      SliverList.separated(
        itemBuilder: (context, index) => HomeToolItemWidget(
          index: index+1,
            tool:items[index]
        ),
        separatorBuilder: (_, __) => verticalSpace(10.h),
        itemCount: items.length,
      );
  }

}
