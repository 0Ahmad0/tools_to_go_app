import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tools_to_go_app/app/features/auth/controller/auth_controller.dart';
import 'package:tools_to_go_app/core/helpers/extensions.dart';
import 'package:tools_to_go_app/core/models/tool.dart';
import 'package:tools_to_go_app/core/routing/routes.dart';
import 'package:tools_to_go_app/core/widgets/image_tool.dart';
import '/core/helpers/spacing.dart';
import '/core/utils/style_manager.dart';

import '../../../../core/utils/color_manager.dart';

class SearchItemWidget extends StatelessWidget {
  const SearchItemWidget({super.key, required this.index, this.tool});

  final int index;
  final ToolModel? tool;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12.r),
      onTap: (){
        context.pushNamed(Routes.toolDetailsRoute,arguments: {'tool':tool});
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: ColorManager.whiteColor,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: ColorManager.hintTextColor),
        ),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Icon(Icons.arrow_forward_ios),
              horizontalSpace(10.w),
              Flexible(
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  title: Text(
                    tool?.name??
                    'مثقاب كهربائي${index}',
                    style: StyleManager.font14SemiBold(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpace(10.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.star_outline,
                            color: ColorManager.rateStarColor,
                          ),
                          horizontalSpace(10.w),
                          Text(
                            '4.5 (20 تقييم)',
                            style: StyleManager.font12SemiBold(),
                          )
                        ],
                      ),
                      verticalSpace(10.h),
                      Text(
                        '${ tool?.fee??''} ريال/يوم',
                        // '25 ريال/يوم',
                      ),
                    ],
                  ),
                ),
              ),
              horizontalSpace(10.w),
              Container(
                constraints: BoxConstraints( maxHeight: 100.h),
                width: 80.w,

                decoration: BoxDecoration(
                    color: ColorManager.grayColor,
                    borderRadius: BorderRadius.circular(8.r)
                ),
                child: ImageTool(
                  width: 80.w,

                  url:  tool?.photoUrl,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
