

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../core/models/user_model.dart';
import '../../../../core/utils/app_constant.dart';
import '../../core/controllers/firebase/firebase_constants.dart';

class WorkersController extends GetxController{

  final searchController = TextEditingController();
  Users workers=Users(items: []);
  Users workersWithFilter=Users(items: []);
  var getWorkers;

  @override
  void onInit() {
   searchController.clear();
   getWorkersFun();
    super.onInit();
    }

  getWorkersFun() async {
    getWorkers =_fetchWorkersStream();
    return getWorkers;
  }
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }


  _fetchWorkersStream() {
    final result= FirebaseFirestore.instance
        .collection(FirebaseConstants.collectionUser)
        .where('typeUser',isEqualTo:AppConstants.collectionWorker)
        .snapshots();
    return result;
  }
  filterWorkers({required String term}) async {

    workersWithFilter.items=[];
    workers.items.forEach((element) {

      if((element.name?.toLowerCase().contains(term.toLowerCase())??false))
        workersWithFilter.items.add(element);
    });
     update();
  }



}
