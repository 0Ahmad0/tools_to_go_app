import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:tools_to_go_app/app/features/navbar/widgets/completed_requests_screen_widget.dart';
import 'package:tools_to_go_app/app/features/navbar/widgets/current_request_screen_widget.dart';
import 'package:tools_to_go_app/core/utils/string_manager.dart';

class CustomersRequestsScreen extends StatelessWidget {
  const CustomersRequestsScreen({super.key});

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
              ],
            ),
          ),
          body: TabBarView(
            children: [
              CompletedRequestsScreenWidget(),
              CurrentRequestScreenWidget()
            ],
          ),
        ),
      ),
    );
  }
}
