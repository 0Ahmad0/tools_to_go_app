import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tools_to_go_app/app/features/auth/screens/change_password_screen.dart';
import 'package:tools_to_go_app/app/features/owner_tools/tools_requests/widgets/owner_tools_requests_widget.dart';
import 'package:tools_to_go_app/core/helpers/spacing.dart';
import 'package:tools_to_go_app/core/utils/string_manager.dart';
import 'package:tools_to_go_app/core/widgets/no_data_found_widget.dart';

import '../../../../../core/models/appointment.dart';
import '../../../../../core/widgets/constants_widgets.dart';
import '../controller/owner_appointments_controller.dart';

class OwnerToolsRequestsScreen extends StatefulWidget {
  const OwnerToolsRequestsScreen({super.key});

  @override
  State<OwnerToolsRequestsScreen> createState() => _OwnerToolsRequestsScreenState();
}

class _OwnerToolsRequestsScreenState extends State<OwnerToolsRequestsScreen> {
  late OwnerAppointmentsController controller;
  void initState() {
    controller = Get.put(OwnerAppointmentsController());
    controller.onInit();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            StringManager.requestsText,
          ),
        ),
        body:
        StreamBuilder<QuerySnapshot>(
            stream: controller.getAppointments,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return   ConstantsWidgets.circularProgress();
              } else if (snapshot.connectionState ==
                  ConnectionState.active) {
                if (snapshot.hasError) {
                  return  Text('Error');
                } else if (snapshot.hasData) {
                  ConstantsWidgets.circularProgress();
                  controller.appointments.items.clear();
                  if (snapshot.data!.docs.length > 0) {

                    controller.appointments.items =
                        Appointments.fromJson(snapshot.data?.docs).items;
                  }
                  controller.filter(term: controller.searchController.value.text);
                  return
                    GetBuilder<OwnerAppointmentsController>(
                        builder: (OwnerAppointmentsController ownerAppointmentsController)=>

                        (ownerAppointmentsController.appointmentsWithFilter.items.isEmpty ?? true)
                            ?
                        Center(child: NoDataFoundWidget(text: "لا يوجد طلبات"))
                            :

                        buildAppointments(context, controller.appointmentsWithFilter.items ?? []));
                } else {
                  return SliverToBoxAdapter(child: const Text('Empty data'));
                }
              } else {
                return Text('State: ${snapshot.connectionState}');
              }
            }),

      ),
    );
  }

  Widget buildAppointments(BuildContext context,List<Appointment> items){
    return
      ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          itemBuilder: (context, index) => OwnerToolsRequestsWidget(
            item:items[index]
          ),
          separatorBuilder: (_, __) => verticalSpace(20.h),
          itemCount: items.length);

  }
  // fetchLocalUser(BuildContext context,String idUser){
  //   return Get.put(ProcessController()).fetchUser(context, idUser: idUser);
  // }
}
