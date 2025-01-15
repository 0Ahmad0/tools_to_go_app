import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tools_to_go_app/app/features/navbar/controller/user_appointments_controller.dart';
import 'package:tools_to_go_app/app/features/navbar/widgets/completed_requests_screen_widget.dart';
import 'package:tools_to_go_app/app/features/navbar/widgets/current_request_screen_widget.dart';
import 'package:tools_to_go_app/core/utils/string_manager.dart';

import '../../../../core/models/appointment.dart';
import '../../../../core/widgets/constants_widgets.dart';

class CustomersRequestsScreen extends StatefulWidget {
  const CustomersRequestsScreen({super.key});

  @override
  State<CustomersRequestsScreen> createState() => _CustomersRequestsScreenState();
}

class _CustomersRequestsScreenState extends State<CustomersRequestsScreen> {
  late UserAppointmentsController controller;

  void initState() {
    controller = Get.put(UserAppointmentsController());
    controller.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(StringManager.myRequestsText),
            bottom: TabBar(
              tabs: [
                Tab(
                  text: StringManager.myCompletedOrdersText,
                ),

                Tab(
                  text: StringManager.myCurrentRequestsText,
                ),
                // Tab(
                //   text: StringManager.myUpcomingOrdersText,
                // ),
              ],
            ),
          ),
          body:
          StreamBuilder<QuerySnapshot>(
              stream: controller.getAppointments,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return    ConstantsWidgets.circularProgress();
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
                    controller.classification();
                    return
                      GetBuilder<UserAppointmentsController>(
                          builder: (UserAppointmentsController userAppointmentsController)=>

                              buildAppointments(context, userAppointmentsController));
                  } else {
                    return const Text('Empty data');
                  }
                } else {
                  return Text('State: ${snapshot.connectionState}');
                }
              })


        ),
      ),
    );
  }
  Widget buildAppointments(BuildContext context,UserAppointmentsController userAppointmentsController){
    return
      TabBarView(
        children: [
          CompletedRequestsScreenWidget(items: userAppointmentsController.prevAppointments.items,),
          // CurrentRequestScreenWidget(items: userAppointmentsController.currAppointments.items,),
          CurrentRequestScreenWidget(items: userAppointmentsController.upAppointments.items,)
        ],
      );
  }

}
