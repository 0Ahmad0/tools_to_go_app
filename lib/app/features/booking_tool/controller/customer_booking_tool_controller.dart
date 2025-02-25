
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tools_to_go_app/app/features/booking_tool/controller/payment_controller.dart';
import 'package:tools_to_go_app/core/helpers/extensions.dart';
import 'package:tools_to_go_app/core/models/tool.dart';


import '../../../../core/models/appointment.dart';
import '../../../../core/models/notification_model.dart';
import '../../../../core/models/review_model.dart';
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
  bool isPayment=false;
  @override
  void onInit() {
    // provider=null;
    ProfileController profileController=Get.put(ProfileController());

    uid= profileController.currentUser.value?.uid;
    nameCustomer= profileController.currentUser.value?.name;
    isPayment=false;
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
    appointment?.idOwner=tool?.idOwner;
    var result=await FirebaseFun.addRequestAppointment(appointment:appointment!);

    ConstantsWidgets.closeDialog();
    if(result['status']){
      //TODO dd notification
      Get.put(NotificationsController()).addNotification(context, notification: NotificationModel(
          typeUser: AppConstants.collectionOwner,
          idUser: tool?.idOwner, subtitle: StringManager.notificationSubTitleNewAppointment+' '+(nameCustomer??''), dateTime: DateTime.now(), title: StringManager.notificationTitleNewAppointment, message: ''));

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
      isPayment=false;
    }else
    ConstantsWidgets.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()),state: result['status']);
    return result;
  }

 Future<bool> validateBook(BuildContext context) async {
    String? error;
    if(appointment?.selectDate==null){
      error="الرجاء تحديد التاريخ";
    }
    else if(appointment?.deliveryAddress==null){
      error="الرجاء اختيار موقع من الخريطة";
    }
    // else if(appointment?.withDelivery==true&&appointment?.idWorker==null){
    //   error="الرجاء اختيار عامل التوصيل";
    // }

    if( !isPayment&&error==null)

    try {
      PaymentController paymentController = PaymentController();
      await paymentController.processPayment(
          (tool?.fee?.toInt()??
          0)*100, nameCustomer??"Test User"); // 50.00 دولار أمريكي
      isPayment=true;
    } catch (e) {
      print("Error: $e");
      error="لم تكتمل عملية الدفع، حاول مرة أخرى";
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





  addReview(context,{required double rate,String? text}) async {
    ConstantsWidgets.showLoading();
    ReviewModel review=ReviewModel(
      idUser: uid,
       review: rate,
        text:text
    );
    tool?.reviews??=[];
    if(tool?.reviews?.where((e)=>e.idUser==review.idUser)?.firstOrNull==null)
      tool?.reviews?.add(review);
    else

      for(ReviewModel element in tool?.reviews??[]){

        if(element.idUser==review.idUser){
          tool?.reviews?.elementAt(tool?.reviews?.indexOf(element)??0).review=rate;
          element=review;
          element.review=rate;
        }

      }
    // var result1=await FirebaseFun.rateProvider(idProvider: appointment!.idProvider??"",review:review!);
    // var result2=await FirebaseFun.updateAppointment(appointment:appointment!);
    var result=await FirebaseFun.updateTool(tool:tool!);
    Get.back();
    Get.back();
    ConstantsWidgets.TOAST(context,textToast: FirebaseFun.findTextToast("تم التقييم بنجاح"),state: result['status']);
    return result;
  }




  @override
  void dispose() {
    super.dispose();
  }


}
