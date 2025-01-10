import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tools_to_go_app/app/features/auth/screens/change_password_screen.dart';
import 'package:tools_to_go_app/app/features/owner_tools/tools_requests/widgets/owner_tools_requests_widget.dart';
import 'package:tools_to_go_app/core/helpers/spacing.dart';
import 'package:tools_to_go_app/core/utils/string_manager.dart';

class OwnerToolsRequestsScreen extends StatelessWidget {
  const OwnerToolsRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            StringManager.requestsText,
          ),
        ),
        body: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            itemBuilder: (context, index) => OwnerToolsRequestsWidget(),
            separatorBuilder: (_, __) => verticalSpace(20.h),
            itemCount: 4),
      ),
    );
  }
}
