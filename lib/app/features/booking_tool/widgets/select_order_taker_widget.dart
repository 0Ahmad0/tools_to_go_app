import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tools_to_go_app/app/features/booking_tool/controller/workers_controller.dart';
import 'package:tools_to_go_app/app/features/owner_tools/tools_requests/widgets/order_taker_item_widget.dart';
import 'package:tools_to_go_app/core/models/user_model.dart';

import '../../../../core/widgets/constants_widgets.dart';
import '../../../../core/widgets/no_data_found_widget.dart';

class SelectOrderTakerWidget extends StatefulWidget {
  const SelectOrderTakerWidget({super.key, this.confirmLocation});
  final Function(UserModel? selectedWorker)? confirmLocation;

  @override
  State<SelectOrderTakerWidget> createState() => _SelectOrderTakerWidgetState();
}

class _SelectOrderTakerWidgetState extends State<SelectOrderTakerWidget> {
  late WorkersController controller;

  void initState() {
    controller = Get.put(WorkersController());
    controller.onInit();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: SingleChildScrollView(
        child:
        StreamBuilder<QuerySnapshot>(
            stream: controller.getWorkers,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return    ConstantsWidgets.circularProgress();
              } else if (snapshot.connectionState ==
                  ConnectionState.active) {
                if (snapshot.hasError) {
                  return  Text('Error');
                } else if (snapshot.hasData) {
                  ConstantsWidgets.circularProgress();
                  controller.workers.items.clear();
                  if (snapshot.data!.docs.length > 0) {

                    controller.workers.items =
                        Users.fromJson(snapshot.data?.docs).items;
                  }
                  // controller.filterProviders(term: controller.searchController.value.text);
                  return
                    GetBuilder<WorkersController>(
                        builder: (WorkersController workersController)=>
                        (workersController.workers.items.isEmpty ?? true)
                            ?
                        NoDataFoundWidget(
                          text: "لا يوجد عاملين",
                          // text: tr(LocaleKeys.home_no_faces_available))
                          // text: StringManager.infoNotFacesYet
                        )
                            :

                        buildWorkers(context, controller.workers.items ?? []));
                } else {
                  return const Text('Empty data');
                }
              } else {
                return Text('State: ${snapshot.connectionState}');
              }
            }),
      ),
    );
  }
  Widget buildWorkers(BuildContext context,List<UserModel> items){
    return
      Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
            items.length,
              (index) => OrderTakerItemWidget(index: 1+index,
                worker: items[index],
                confirmLocation: (worker)=>widget.confirmLocation!=null?widget.confirmLocation!(worker):"",
              ),
        ),
      );

  }
}
