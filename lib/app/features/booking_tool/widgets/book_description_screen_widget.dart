import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tools_to_go_app/core/helpers/spacing.dart';
import 'package:tools_to_go_app/core/utils/style_manager.dart';
import 'package:tools_to_go_app/core/widgets/app_textfield.dart';

class BookDescriptionScreenWidget extends StatelessWidget {
  const BookDescriptionScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('عنوان التوصيل',style: StyleManager.font14SemiBold(),),
        verticalSpace(10.h),
        AppTextField(),
        verticalSpace(20.h),
        Text('تعليمات خاصة',style: StyleManager.font14SemiBold(),),
        verticalSpace(10.h),
        AppTextField(),

      ],
    );
  }
}
