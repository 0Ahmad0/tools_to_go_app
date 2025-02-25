import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tools_to_go_app/app/features/auth/screens/change_password_screen.dart';
import 'package:tools_to_go_app/core/helpers/spacing.dart';
import 'package:tools_to_go_app/core/models/appointment.dart';

import 'my_request_item_widget.dart';

class CompletedRequestsScreenWidget extends StatelessWidget {
  const CompletedRequestsScreenWidget({super.key, required this.items});
  final List<Appointment> items;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: EdgeInsets.symmetric(
          horizontal: 12.w,
          vertical: 10.h
        ),
        itemBuilder: (context, index) => MyRequestItemWidget(item: items[index],),
        separatorBuilder: (_, __) => verticalSpace(10.h),
        itemCount: items.length);
  }
}
