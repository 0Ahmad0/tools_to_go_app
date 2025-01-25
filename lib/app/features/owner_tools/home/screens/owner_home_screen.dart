import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tools_to_go_app/app/features/auth/controller/auth_controller.dart';
import 'package:tools_to_go_app/app/features/navbar/widgets/chat_item_widget.dart';
import 'package:tools_to_go_app/app/features/owner_tools/home/widgets/owner_home_tool_widget.dart';
import 'package:tools_to_go_app/core/dialogs/delete_dialog.dart';
import 'package:tools_to_go_app/core/helpers/extensions.dart';
import 'package:tools_to_go_app/core/helpers/spacing.dart';
import 'package:tools_to_go_app/core/routing/routes.dart';
import 'package:tools_to_go_app/core/utils/color_manager.dart';
import 'package:tools_to_go_app/core/utils/string_manager.dart';
import 'package:tools_to_go_app/core/utils/style_manager.dart';
import 'package:tools_to_go_app/core/widgets/app_padding.dart';

import '../../../../../core/models/tool.dart';
import '../../../../../core/utils/assets_manager.dart';
import '../../../../../core/widgets/constants_widgets.dart';
import '../../../../../core/widgets/image_user_provider.dart';
import '../../../../../core/widgets/no_data_found_widget.dart';
import '../../../profile/controller/profile_controller.dart';
import '../controller/tools_controller.dart';

class OwnerHomeScreen extends StatefulWidget {
  const OwnerHomeScreen({super.key});

  @override
  State<OwnerHomeScreen> createState() => _OwnerHomeScreenState();
}

class _OwnerHomeScreenState extends State<OwnerHomeScreen> {
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
        appBar: AppBar(
          title: Text(StringManager.homeText),
          actions: [
            Image.asset(
              AssetsManager.logoIMG,
            ),
          ],
        ),
        drawer: Drawer(
          child: Stack(
            children: [
              Column(
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
                      context.pushNamed(Routes.ownerToolsRequestsRoute);
                    },
                    leading: Icon(Icons.shopping_cart),
                    title: Text(
                      StringManager.requestsText,
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
                            color: ColorManager.whiteColor
                        ),
                      ),
                    ),
                  ),

                ],
              ),
              SafeArea(
                  child: AppPaddingWidget(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10.sp),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              color: ColorManager.whiteColor
                          ),
                          child: Text(
                            'Owner',
                          ),
                        ),
                      ],
                    ),
                  )),

            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            context.pushNamed(Routes.ownerAddToolRoute);
          },
          label: Text(StringManager.addNewToolsText),
          icon: Icon(
            Icons.add,
          ),
        ),
        body: AppPaddingWidget(
          child:  StreamBuilder<QuerySnapshot>(
              stream: controller.getTools,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return    ConstantsWidgets.circularProgress();
                } else if (snapshot.connectionState ==
                    ConnectionState.active) {
                  if (snapshot.hasError) {
                    return  Text('Error');
                  } else if (snapshot.hasData) {
                    ConstantsWidgets.circularProgress();
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
                          Center(child: NoDataFoundWidget(text: StringManager.noToolsText))
                              :
                              buildTools(context, toolsController.tools.items));
                  } else {
                    return const Text('Empty data');
                  }
                } else {
                  return Text('State: ${snapshot.connectionState}');
                }
              }),
        ),
      ),
    );
  }
  Widget buildTools(BuildContext context,List<ToolModel> items){
    return
      ListView.separated(
          padding: EdgeInsets.only(bottom: 70.h),
          itemBuilder: (context, index) => OwnerHomeToolWidget(tool:items[index]),
          separatorBuilder: (_, __) => verticalSpace(20.h),
          itemCount: items.length);
  }

}
