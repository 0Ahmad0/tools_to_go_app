import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tools_to_go_app/app/features/auth/controller/auth_controller.dart';
import 'package:tools_to_go_app/core/helpers/extensions.dart';
import 'package:tools_to_go_app/core/utils/style_manager.dart';

import '../../../../core/models/tool.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/widgets/image_tool.dart';

class HomeToolItemWidget extends StatelessWidget {
  const HomeToolItemWidget({super.key, required this.index, this.tool});

  final int index;
  final ToolModel? tool;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12.r),
      onTap: (){
        context.pushNamed(Routes.toolDetailsRoute,arguments: {"tool":tool});
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
            child: ImageTool(
             fit: BoxFit.cover,
              url:   tool?.photoUrl,
            ),
          ),
          title: Text(
            tool?.name??
            "معدات ${index}",
            style: StyleManager.font14SemiBold(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            tool?.description??'وصف قصير',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
