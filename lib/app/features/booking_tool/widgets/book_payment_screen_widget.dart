import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tools_to_go_app/app/features/auth/screens/change_password_screen.dart';
import 'package:tools_to_go_app/core/helpers/spacing.dart';

import '../../../../core/utils/style_manager.dart';

class BookPaymentScreenWidget extends StatelessWidget {
  const BookPaymentScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'اختر طريقة الدفع',
          style: StyleManager.font14SemiBold(),
        ),
        verticalSpace(10.h),
        RadioListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            title: Text('بطاقة ائتمان'),
            value: false,
            groupValue: [],
            onChanged: (value) {}),
        RadioListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            title: Text('Apple Pay'),
            value: true,
            groupValue: [],
            onChanged: (value) {}),
      ],
    );
  }
}
