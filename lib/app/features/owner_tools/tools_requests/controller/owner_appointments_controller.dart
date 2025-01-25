
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tools_to_go_app/core/helpers/get_color_status_appointments.dart';
import 'package:tools_to_go_app/core/utils/app_constant.dart';

import '../../../../../core/models/appointment.dart';
import '../../../../../core/models/notification_model.dart';
import '../../../../../core/utils/string_manager.dart';
import '../../../../../core/widgets/constants_widgets.dart';
import '../../../core/controllers/firebase/firebase_constants.dart';
import '../../../core/controllers/firebase/firebase_fun.dart';
import '../../../notification/controller/notifications_controller.dart';
import '../../../profile/controller/profile_controller.dart';

class OwnerAppointmentsController extends GetxController{

  final searchController = TextEditingController();
  Appointments appointments=Appointments(items: []);
  Appointments appointmentsWithFilter=Appointments(items: []);

  var getAppointments;
  String? uid;
  @override
  void onInit() {
   searchController.clear();
   ProfileController profileController=Get.put(ProfileController());
   uid= profileController.currentUser.value?.uid;
   getAppointmentsFun();
    super.onInit();
    }

  getAppointmentsFun() async {
    getAppointments =_fetchAppointmentsStream();
    return getAppointments;
  }
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }


  _fetchAppointmentsStream() {
    final result = FirebaseFirestore.instance
        .collection(FirebaseConstants.collectionAppointment)
        .where("idOwner",isEqualTo: uid)
        .snapshots();

    return result;
  }
  filter({required String term}) async {
    appointmentsWithFilter.items=[];
    appointments.items.forEach((element) {

      if(element.getState==null||element.getState==ColorAppointments.Pending)
      if((element.nameCustomer?.toLowerCase().contains(term.toLowerCase())??false)||
          (element.nameWorker?.toLowerCase().contains(term.toLowerCase())??false)||
          ((element.state??"Pending").toLowerCase().contains(term.toLowerCase())??false)
      )
          appointmentsWithFilter.items.add(element);

    });
     update();
  }


  acceptOrRejectedRequest(BuildContext context ,ColorAppointments? state,Appointment? appointment) async {
    var result;
    appointment?.state=state?.name;
    ConstantsWidgets.showLoading();
    {
      result=await FirebaseFun.updateAppointment(appointment:appointment!);


        //TODO dd notification
        // if(result['status'])
        //   context.read<NotificationProvider>().addNotification(context, notification: models.Notification(idUser: users[index].uid, subtitle: AppConstants.notificationSubTitleNewChat+' '+(profileProvider?.user?.firstName??''), dateTime: DateTime.now(), title: AppConstants.notificationTitleNewChat, message: ''));

        if(result['status']){
          if(state==ColorAppointments.Ongoing||state==ColorAppointments.StartingSoon){
            Get.put(NotificationsController()).addNotification(context, notification: NotificationModel(
              typeUser: AppConstants.collectionUser,
                idUser: appointment?.idUser, subtitle: StringManager.notificationSubTitleAcceptAppointment+' '+(appointment.nameTool??''), dateTime: DateTime.now(), title: StringManager.notificationTitleAcceptAppointment, message: ''));
//             Get.put(NotificationsController()).addNotification(context, notification: NotificationModel(
//                 typeUser: AppConstants.collectionWorker,
//                 idUser: appointment?.idWorker, subtitle: StringManager.notificationSubTitleNewDeliveryAppointment+' '+(appointment.nameCustomer??''), dateTime: DateTime.now(), title: StringManager.notificationTitleNewDeliveryAppointment, message: ''))
// ;
          }
          if(state==ColorAppointments.Concluded){
            Get.put(NotificationsController()).addNotification(context, notification: NotificationModel(
                typeUser: AppConstants.collectionUser,
                idUser: appointment?.idUser, subtitle: StringManager.notificationSubTitleDoneAppointment+' '+( Get.put(ProfileController()).currentUser.value?.name??'')+' ('+(appointment.nameTool??')'), dateTime: DateTime.now(), title: StringManager.notificationTitleDoneAppointment, message: ''));
          }
          else{
            Get.put(NotificationsController()).addNotification(context, notification: NotificationModel(
                typeUser: AppConstants.collectionUser,
                idUser: appointment?.idUser, subtitle: StringManager.notificationSubTitleCanceledAppointment+' '+(appointment.nameTool??''), dateTime: DateTime.now(), title: StringManager.notificationTitleCanceledAppointment, message: ''));

          }

          ConstantsWidgets.closeDialog();
          // if(result['status'])
          //    Get.to(ChatPage(), arguments: {'chat': controller.chat});
        }else{
          ConstantsWidgets.closeDialog();
          ConstantsWidgets.TOAST(null,
              textToast: StringManager.errorTryAgainLater
              // textToast:  tr(LocaleKeys.message_error_try_again_later)
              , state: false);
        }
      }
      // else{
      //   await LauncherHelper.launchWebsite(context,'https://wa.me/+966${person.phoneNumber?.replaceAll('+966', '')}');
      //   ConstantsWidgets.closeDialog();
      // }

    // }

  }


}
