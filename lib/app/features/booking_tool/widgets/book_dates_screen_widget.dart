import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tools_to_go_app/app/features/auth/screens/change_password_screen.dart';
import 'package:tools_to_go_app/core/helpers/sizer.dart';
import 'package:tools_to_go_app/core/helpers/spacing.dart';
import 'package:tools_to_go_app/core/utils/string_manager.dart';
import 'package:tools_to_go_app/core/utils/style_manager.dart';

class BookDatesScreenWidget extends StatelessWidget {
  const BookDatesScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        verticalSpace(10.h),
        Text(
          StringManager.selectBookDateText,
          style: StyleManager.font14SemiBold(),
        ),
        verticalSpace(10.h),
        SizedBox(
          width: double.infinity,
          height: getHeight(context) / 3,
          child: CupertinoDatePicker(
            onDateTimeChanged: (value) {},
          ),
        )
      ],
    );
  }
}
