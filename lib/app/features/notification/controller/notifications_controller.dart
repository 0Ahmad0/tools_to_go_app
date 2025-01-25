


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../core/models/notification_model.dart';
import '../../../../core/utils/app_constant.dart';
import '../../core/controllers/firebase/firebase_constants.dart';
import '../../core/controllers/firebase/firebase_fun.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../profile/controller/profile_controller.dart';

class NotificationsController extends GetxController{

  Notifications notifications=Notifications(items: []);
  Notifications seenNotifications=Notifications(items: []);
  Notifications unSeenNotifications=Notifications(items: []);
  String? uid;
  String? typeUser;
  var getNotifications;

  @override
  void onInit() {
   ProfileController profileController=Get.put(ProfileController());
   uid= profileController.currentUser.value?.uid;
   typeUser= profileController.currentUser.value?.typeUser;
   getNotificationsFun();
    super.onInit();
    }

  getNotificationsFun() async {
    getNotifications =_fetchNotificationsStream();
    return getNotifications;
  }
  @override
  void dispose() {
    super.dispose();
  }


  _fetchNotificationsStream() {

    final result= FirebaseFirestore.instance
        .collection(FirebaseConstants.collectionNotification)
        .where('typeUser',isEqualTo: typeUser)
        .snapshots();
    return result;
  }


  filterNotification(){
    notifications.items.sort((n1,n2)=>(n2.dateTime??DateTime.now()).compareTo(n1.dateTime??DateTime.now()));
    seenNotifications.items.clear();
    unSeenNotifications.items.clear();
    notifications.items.forEach((element) {
      if(element.idUser==uid)
      // if(AppConstants.collectionOwner==typeUser||element.idUser==uid)
      if(element.checkRec)
        seenNotifications.items.add(element);
      else
        unSeenNotifications.items.add(element);
    });
  }

  addNotification(BuildContext context ,{ required NotificationModel notification}) async {
    var result;
    // ConstantsWidgets.showLoading();
    // notification.idUser??=uid??Get.put(ProfileController()).currentUser.value?.uid;
    result =await FirebaseFun.addNotification(notification: notification);
    //print(result);
    //   Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
    // ConstantsWidgets.closeDialog();
  }

  updateNotification(context,{ required NotificationModel notification}) async {
    var result;
    result =await FirebaseFun.updateNotification(notification: notification);

    // Const.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()));
    return result;
  }

}
