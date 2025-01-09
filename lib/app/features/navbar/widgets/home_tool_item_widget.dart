import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tools_to_go_app/app/features/auth/controller/auth_controller.dart';
import 'package:tools_to_go_app/core/helpers/extensions.dart';
import 'package:tools_to_go_app/core/utils/style_manager.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/utils/color_manager.dart';

class HomeToolItemWidget extends StatelessWidget {
  const HomeToolItemWidget({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12.r),
      onTap: (){
        context.pushNamed(Routes.toolDetailsRoute);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: ColorManager.whiteColor,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: ColorManager.hintTextColor),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          dense: true,
          leading: Container(
            width: 50.w,
            height: 50.h,
            decoration: BoxDecoration(
                color: ColorManager.grayColor,
                borderRadius: BorderRadius.circular(8.r)),
          ),
          title: Text(
            "معدات ${index}",
            style: StyleManager.font14SemiBold(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            'وصف قصير',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
