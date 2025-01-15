
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tools_to_go_app/core/helpers/extensions.dart';
import 'package:tools_to_go_app/core/models/tool.dart';


import '../../../../core/models/appointment.dart';
import '../../../../core/models/notification_model.dart';
import '../../../../core/models/user_model.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/utils/app_constant.dart';
import '../../../../core/utils/string_manager.dart';
import '../../../../core/widgets/constants_widgets.dart';

import '../../core/controllers/firebase/firebase_fun.dart';
import '../../notification/controller/notifications_controller.dart';
import '../../profile/controller/profile_controller.dart';


class CustomerBookingToolController extends GetxController{


  String? uid,nameCustomer;
  Appointment? appointment;
  ToolModel? tool;

  @override
  void onInit() {
    // provider=null;
    ProfileController profileController=Get.put(ProfileController());

    uid= profileController.currentUser.value?.uid;
    nameCustomer= profileController.currentUser.value?.name;

    super.onInit();
    }


  addAppointment(BuildContext context) async {
    ConstantsWidgets.showLoading();

    // String description=descriptionController.value.text;
    String id= '${tool?.name}000000'.substring(0,6)+'${Timestamp.now().microsecondsSinceEpoch}';
    appointment??=Appointment();
    appointment?.idUser=uid;
    appointment?.idTool=tool?.id;
    appointment?.id=id;
    appointment?.nameTool=tool?.name;
    appointment?.nameCustomer=nameCustomer;
    var result=await FirebaseFun.addRequestAppointment(appointment:appointment!);

    ConstantsWidgets.closeDialog();
    if(result['status']){
      //TODO dd notification
      Get.put(NotificationsController()).addNotification(context, notification: NotificationModel(idUser: "", subtitle: StringManager.notificationSubTitleNewAppointment+' '+(nameCustomer??''), dateTime: DateTime.now(), title: StringManager.notificationTitleNewAppointment, message: ''));

      // context.pushNamed(
      //     Routes.paymentSuccessfulRoute
      // );
      // provider=userModel;
      // context.pushNamed(
      //     Routes.paymentSuccessfulRoute
      // );
      Get.back();
      Get.back();
      ConstantsWidgets.TOAST(context,textToast: "تم الحجز بنجاح",state: result['status']);

    }else
    ConstantsWidgets.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()),state: result['status']);
    return result;
  }

 bool validateBook(BuildContext context){
    String? error;
    if(appointment?.selectDate==null){
      error="الرجاء تحديد التاريخ";
    }
    else if(appointment?.deliveryAddress==null){
      error="الرجاء اختيار موقع من الخريطة";
    }
    else if(appointment?.withDelivery==true&&appointment?.idWorker==null){
      error="الرجاء اختيار عامل التوصيل";
    }

    if(error!=null)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(error)),
    );
    return error==null;
  }

  updateAppointment(BuildContext context) async {
    ConstantsWidgets.showLoading();

    var result=await FirebaseFun.updateAppointment(appointment:appointment!);

    ConstantsWidgets.closeDialog();
    ConstantsWidgets.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()),state: result['status']);
    if(result['status']){
      //TODO update notification
      Get.put(NotificationsController()).addNotification(context, notification: NotificationModel(
        typeUser:AppConstants.collectionOwner,
        idUser: "", subtitle: StringManager.notificationSubTitleUpdateAppointment+' '+(Get.put(ProfileController())?.currentUser.value?.name??''), dateTime: DateTime.now(), title: StringManager.notificationTitleUpdateAppointment, message: '',));
    }
    return result;
  }




  //
  // addReview(context,{required int rate,String? text}) async {
  //   ConstantsWidgets.showLoading();
  //   ReviewModel review=ReviewModel(
  //     idUser: uid,
  //       professionalReview:rate.toDouble(),
  //     timeScaleReview:rate.toDouble(),
  //     punctualityReview:rate.toDouble(),
  //       text:text
  //   );
  //   appointment?.review=review;
  //   var result1=await FirebaseFun.rateProvider(idProvider: appointment!.idProvider??"",review:review!);
  //   var result2=await FirebaseFun.updateAppointment(appointment:appointment!);
  //   Get.back();
  //   Get.back();
  //   ConstantsWidgets.TOAST(context,textToast: FirebaseFun.findTextToast(result1['message'].toString()),state: result1['status']);
  //   return result1;
  // }
  //



  @override
  void dispose() {
    super.dispose();
  }


}
