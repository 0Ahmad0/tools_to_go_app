
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

class ToolsFilterController extends GetxController{

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

  sortByDefault() async {
    toolsWithFilter.items.sort((tool1,tool2)=>tools.items.indexOf(tool2)-tools.items.indexOf(tool1));
    update();
  }
  sortByBestFee() async {
    toolsWithFilter.items.sort((tool1,tool2)=>(tool2?.fee?.toInt()??0)-(tool1?.fee?.toInt()??0));
    update();
  }
  sortByBestRate() async {
    toolsWithFilter.items.sort((tool1,tool2){
      double compare=(num.tryParse("${tool2?.getRate??''}")??0) -(double.tryParse("${tool1?.getRate??''}")??0);
      return compare>0?compare.ceil():compare.floor();
    });
    update();
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
