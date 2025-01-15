import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
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
import '../../../../../core/models/appointment.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/widgets/constants_widgets.dart';
import '../../../../../core/widgets/image_user_provider.dart';
import '../../../../../core/widgets/no_data_found_widget.dart';
import '../../../auth/controller/auth_controller.dart';
import '../../../profile/controller/profile_controller.dart';
import '../controller/worker_appointments_controller.dart';

class OrderTakerHomeScreen extends StatefulWidget {
  const OrderTakerHomeScreen({super.key});

  @override
  State<OrderTakerHomeScreen> createState() => _OrderTakerHomeScreenState();
}

class _OrderTakerHomeScreenState extends State<OrderTakerHomeScreen> {
  late WorkerAppointmentsController controller;
  void initState() {
    controller = Get.put(WorkerAppointmentsController());
    controller.onInit();
    super.initState();
  }
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
                                'عامل توصيل' ,
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
        ),
        body:

        StreamBuilder<QuerySnapshot>(
            stream: controller.getAppointments,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return   ConstantsWidgets.circularProgress();
              } else if (snapshot.connectionState ==
                  ConnectionState.active) {
                if (snapshot.hasError) {
                  return  Text('Error');
                } else if (snapshot.hasData) {
                  ConstantsWidgets.circularProgress();
                  controller.appointments.items.clear();
                  if (snapshot.data!.docs.length > 0) {

                    controller.appointments.items =
                        Appointments.fromJson(snapshot.data?.docs).items;
                  }
                  controller.filter(term: controller.searchController.value.text);
                  return
                    GetBuilder<WorkerAppointmentsController>(
                        builder: (WorkerAppointmentsController workerAppointmentsController)=>


                        buildAppointments(context, controller));
                } else {
                  return SliverToBoxAdapter(child: const Text('Empty data'));
                }
              } else {
                return Text('State: ${snapshot.connectionState}');
              }
            }),


      ),
    );
  }
  Widget buildAppointments(BuildContext context,WorkerAppointmentsController workerAppointmentsController){
    return
      CustomScrollView(
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
                              '${workerAppointmentsController.concludedAppointments.items.length}',
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
                              '${workerAppointmentsController.currentAppointments.items.length}',
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

          (workerAppointmentsController.currentAppointments.items.isEmpty ?? true)
              ?
          SliverFillRemaining(child: Center(child: NoDataFoundWidget(text: "لا يوجد طلبات حالية")))
              :
          SliverList.separated(
            itemBuilder: (context, index) => OrderTakerOrderWidget(
              index: 1+index,
              item:workerAppointmentsController.currentAppointments.items[index]
            ),
            separatorBuilder: (_, __) => Divider(),
            itemCount: workerAppointmentsController.currentAppointments.items.length,
          )
        ],
      );

  }

}
