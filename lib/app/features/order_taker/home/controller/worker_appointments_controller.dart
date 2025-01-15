
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

class WorkerAppointmentsController extends GetxController{

  final searchController = TextEditingController();
  Appointments appointments=Appointments(items: []);
  Appointments currentAppointments=Appointments(items: []);
  Appointments concludedAppointments=Appointments(items: []);

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
        .where("idWorker",isEqualTo: uid)
        .snapshots();

    return result;
  }
  filter({required String term}) async {
    currentAppointments.items.clear();
    concludedAppointments.items.clear();
    appointments.items.forEach((element) {

      if(element.getState!=null&&element.getState!=ColorAppointments.Pending)
      switch(element.getStateInt){
        case 1:
          currentAppointments.items.add(element);
        case 0:
          currentAppointments.items.add(element);
        case -1:
          concludedAppointments.items.add(element);
        default:
          currentAppointments.items.add(element);
      }

    });
     update();
  }


  concludeAppointments(BuildContext context ,Appointment? appointment) async {
    var result;
    appointment?.state=ColorAppointments.Concluded.name;
    ConstantsWidgets.showLoading();
    {
      result=await FirebaseFun.updateAppointment(appointment:appointment!);


        //TODO dd notification
        // if(result['status'])
        //   context.read<NotificationProvider>().addNotification(context, notification: models.Notification(idUser: users[index].uid, subtitle: AppConstants.notificationSubTitleNewChat+' '+(profileProvider?.user?.firstName??''), dateTime: DateTime.now(), title: AppConstants.notificationTitleNewChat, message: ''));

        if(result['status']){
          Get.put(NotificationsController()).addNotification(context, notification: NotificationModel(
              typeUser: AppConstants.collectionUser,
              idUser: appointment?.idUser, subtitle: StringManager.notificationSubTitleDoneDeliveryAppointment+' '+("(${appointment.nameTool??''})"), dateTime: DateTime.now(), title: StringManager.notificationTitleDoneDeliveryAppointment, message: ''));

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
