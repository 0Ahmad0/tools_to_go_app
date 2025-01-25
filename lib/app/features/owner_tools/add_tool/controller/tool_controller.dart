

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tools_to_go_app/core/models/tool.dart';


import '../../../../../core/utils/string_manager.dart';
import '../../../../../core/widgets/constants_widgets.dart';
import '../../../core/controllers/firebase/firebase_constants.dart';
import '../../../core/controllers/firebase/firebase_fun.dart';
import '../../../notification/controller/notifications_controller.dart';
import '../../../profile/controller/profile_controller.dart';


class ToolController extends GetxController{


  String? uid;
  ToolModel? tool;
  int currentProgress=0;
  int fullProgress=0;
  @override
  void onInit() {
    ProfileController profileController=Get.put(ProfileController());
    uid= profileController.currentUser.value?.uid;

    super.onInit();
    }
  updateTool(BuildContext context,{T,List<File?>? images,File? image,String? name,num? fee,String? description,String? specifications}) async {

    _calculateProgress(images?.length??0);
    Get.dialog(
      GetBuilder<ToolController>(
          builder: (ToolController controller) =>
              ConstantsWidgets.showProgress(controller.currentProgress/controller.fullProgress)
      ),
      barrierDismissible: false,
    );

    String id= '${name}00000'.substring(0,5)+'${Timestamp.now().microsecondsSinceEpoch}';
    List<String> files=[];
    for(File? file in images??[]){
      if(file!=null){
        String? url=await FirebaseFun.uploadImage(image:XFile(file.path??''),folder: FirebaseConstants.collectionTool+'/$id');
        if(url!=null){
          tool?.images?.add(url);
        }
      }
      _plusProgress();

    }
    String? imagePath;
    if(image!=null){
      imagePath=await FirebaseFun.uploadImage(image:XFile(image.path),folder: FirebaseConstants.collectionTool+'/$name');
    }
    tool??=ToolModel();
    tool?.name=name??tool?.name;
    tool?.description=description;
    tool?.specifications=specifications;
    tool?.images= files.isNotEmpty?files:tool?.images??[];
    tool?.fee=fee;
    tool?.photoUrl=imagePath??tool?.photoUrl;


    var result=await FirebaseFun.updateTool(tool:tool!);

    ConstantsWidgets.closeDialog();
    ConstantsWidgets.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()),state: result['status']);
    if(result['status']){
      //TODO update notification
      // Get.put(NotificationsController()).addNotification(context, notification: NotificationModel(idUser: appointment?.idProvider, subtitle: StringManager.notificationSubTitleUpdateAppointment+' '+(Get.put(ProfileController())?.currentUser.value?.name??''), dateTime: DateTime.now(), title: StringManager.notificationTitleUpdateAppointment, message: ''));
    }
    return result;
  }
  addTool(context,{List<File?>? images,File? image,String? name,num? fee,String? description,String? specifications}) async {
    // ConstantsWidgets.showProgress(progress);
    _calculateProgress(images?.length??0);
    Get.dialog(
      GetBuilder<ToolController>(
          builder: (ToolController controller) =>
              ConstantsWidgets.showProgress(controller.currentProgress/controller.fullProgress)
      ),
      barrierDismissible: false,
    );

    String id= '${name}000000'.substring(0,6)+'${Timestamp.now().microsecondsSinceEpoch}';
    List<String> files=[];
    for(File? file in images??[]){
      if(file!=null){
        String? url=await FirebaseFun.uploadImage(image:XFile(file.path??''),folder: FirebaseConstants.collectionTool+'/$id');
        if(url!=null){
          files.add(url);
        }
      }
        _plusProgress();

    }
    String? imagePath;
    if(image!=null){
      imagePath=await FirebaseFun.uploadImage(image:XFile(image.path),folder: FirebaseConstants.collectionTool+'/$name');
    }
    ToolModel toolModel=ToolModel(
      id: id,
      description:description,
        specifications:specifications,
      images: files??[],
      name: name,
        fee: fee,
      photoUrl: imagePath,
        idOwner: uid
    );
    var result=await FirebaseFun.addTool(tool:toolModel);

    ConstantsWidgets.closeDialog();
    if(result['status']){
      //TODO dd notification
      // Get.put(NotificationsController()).addNotification(context, notification: NotificationModel(idUser: id,typeUser: AppConstants.collectionWorker
      //     , subtitle: StringManager.notificationSubTitleNewProblem+' '+(Get.put(ProfileController())?.currentUser.value?.name??''), dateTime: DateTime.now(), title: StringManager.notificationTitleNewProblem, message: ''));

      Get.back();
    }
    ConstantsWidgets.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()),state: result['status']);
    return result;
  }
  _calculateProgress(int length){
    currentProgress=0;
    fullProgress=1;
    fullProgress+=length;
    update();
  }
  _plusProgress(){
    currentProgress++;
    if(currentProgress>fullProgress)
      currentProgress=fullProgress;
    update();
  }


  @override
  void dispose() {
    super.dispose();
  }


}
