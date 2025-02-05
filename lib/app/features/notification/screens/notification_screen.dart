import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tools_to_go_app/app/features/notification/widgets/notification_item_widget.dart';
import 'package:tools_to_go_app/core/utils/string_manager.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/models/notification_model.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/style_manager.dart';
import '../../../../core/widgets/constants_widgets.dart';
import '../controller/notifications_controller.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late NotificationsController controller;
  void initState() {
    controller = Get.put(NotificationsController());
    controller.onInit();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      child: Scaffold(
        appBar: AppBar(
          title: Text(StringManager.notificationText),
        ),
        body:
        StreamBuilder<QuerySnapshot>(
            stream: controller.getNotifications,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return    ConstantsWidgets.circularProgress();
              } else if (snapshot.connectionState ==
                  ConnectionState.active) {
                if (snapshot.hasError) {
                  return  Text('Error');
                } else if (snapshot.hasData) {
                  ConstantsWidgets.circularProgress();
                  controller.notifications.items.clear();
                  if (snapshot.data!.docs.length > 0) {
                    controller.notifications.items =
                        Notifications.fromJson(snapshot.data?.docs).items;

                  }
                  controller.filterNotification();
                  return
                    GetBuilder<NotificationsController>(
                        builder: (NotificationsController notificationsController)=>
                        (notificationsController.unSeenNotifications.items.isEmpty ?? true)
                            ?
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              AssetsManager.noNotificationIMG,
                              color: ColorManager.orangeColor,
                              width: 140.w,
                              height: 140.h,
                            ),
                            verticalSpace(30.h),
                            Text(
                              StringManager.noNotificationText,
                              textAlign: TextAlign.center,
                              style:
                              StyleManager.font14Regular(
                                  color: ColorManager.blackColor
                              ),
                            ),
                          ],
                        )
                            :

                        buildNotification(context, controller.unSeenNotifications.items ?? []));
                } else {
                  return const Text('Empty data');
                }
              } else {
                return Text('State: ${snapshot.connectionState}');
              }
            })


      ),
    );
  }
  Widget buildNotification(BuildContext context,List<NotificationModel> items){
    return

      ListView.separated(
          itemBuilder: (context, index) => NotificationItemWidget(
            item:items[index]
          ),
          separatorBuilder: (_, __) => Divider(),
          itemCount: items.length);
  }


}
