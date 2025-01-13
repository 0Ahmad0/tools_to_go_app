
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:get/get_core/src/get_main.dart';
import 'package:tools_to_go_app/core/models/tool.dart';

import '../../../../../core/widgets/constants_widgets.dart';
import '../../../core/controllers/firebase/firebase_constants.dart';
import '../../../core/controllers/firebase/firebase_fun.dart';
import '../../../profile/controller/profile_controller.dart';

class ToolsController extends GetxController{

  final searchController = TextEditingController();
  Tools tools=Tools(items: []);
  Tools toolsWithFilter=Tools(items: []);
  String? uid;
  var getTools;

  @override
  void onInit() {
   searchController.clear();
   ProfileController profileController=Get.put(ProfileController());
   uid= profileController.currentUser.value?.uid;
   getToolsFun();
    super.onInit();
    }

  getToolsFun() async {
    getTools =_fetchToolsStream();
    return getTools;
  }
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }


  _fetchToolsStream() {
    final result = FirebaseFirestore.instance.collection(FirebaseConstants.collectionTool)
    .snapshots()
    ;
    return result;
  }
  filterTools({required String term}) async {

    toolsWithFilter.items=[];

    tools.items.forEach((element) {

      if(
      (element.name?.toLowerCase().contains(term.toLowerCase())??false)||
      (element.fee?.toString()?.toLowerCase().contains(term.toLowerCase())??false)||
      (element.id?.toLowerCase().contains(term.toLowerCase())??false)
      )
        toolsWithFilter.items.add(element);
    });
     update();
  }

  deleteTool(BuildContext context ,ToolModel? tool) async {
    var result;
    if(tool==null)
      return;
    ConstantsWidgets.showLoading();
    result = await FirebaseFun.deleteTool(idTool: tool?.id??"");
    ConstantsWidgets.closeDialog();
    if(result['status']){
      ConstantsWidgets.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()),state: result['status']);
    }
    else
      ConstantsWidgets.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()),state: result['status']);

  }

// solveProblem(BuildContext context ,ProblemModel problem) async {
  //   var result;
  //   // ConstantsWidgets.showLoading();
  //   problem.state=StateProblem.solved.name;
  //   result = await FirebaseFun.updateProblem(problem: problem);
  //   // ConstantsWidgets.closeDialog();
  //   ConstantsWidgets.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()),state: result['status']);
  //
  // }


}
