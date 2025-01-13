import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tools_to_go_app/app/features/auth/controller/auth_controller.dart';
import 'package:tools_to_go_app/app/features/owner_tools/add_tool/controller/tool_controller.dart';
import 'package:tools_to_go_app/core/dialogs/delete_dialog.dart';
import 'package:tools_to_go_app/core/helpers/extensions.dart';
import 'package:tools_to_go_app/core/utils/assets_manager.dart';
import 'package:tools_to_go_app/core/utils/color_manager.dart';
import 'package:tools_to_go_app/core/utils/string_manager.dart';

import '../../../../../core/dialogs/delete_user_dialog.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/models/tool.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/utils/style_manager.dart';
import '../../../../../core/widgets/image_tool.dart';
import '../controller/tools_controller.dart';

class OwnerHomeToolWidget extends StatelessWidget {
  const OwnerHomeToolWidget({super.key, this.tool});
  final ToolModel? tool;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(14.r),
          onTap: (){
            context.pushNamed(Routes.ownerAddToolRoute,arguments: {"tool":tool});
          },
          child: Container(
            // padding: EdgeInsets.symmetric(
            //   horizontal: 12.w,
            //   vertical: 10.h
            // ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14.r),
                border: Border.all(color: ColorManager.primaryColor)),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(14.sp),
                    margin: EdgeInsets.all(8.sp),
                    width: 80.w,
                    decoration: BoxDecoration(
                      color: ColorManager.grayColor,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child:
                    ImageTool(
                      url:  tool?.photoUrl,

  width: 50.sp,
                        height: 50.sp,
                    )
                    // Image.asset(
                    //   AssetsManager.completeOrdersIcon,
                    //   width: 50.sp,
                    //   height: 50.sp,
                    // ),
                  ),
                  Flexible(
                    child: ListTile(
                      dense: true,
                      title: Text(
                        tool?.name??""??
                        'مثقاب كهربائي',
                        style: StyleManager.font14SemiBold(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Padding(
                        padding: EdgeInsets.only(top: 6.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${tool?.fee??"?"} ريال',
                              // '20 ريال',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            verticalSpace(10.h),
                            Text(tool?.description??'xx'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        PositionedDirectional(
          end: 0,
          child: IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => DeleteDialog(
                  title: StringManager.deleteProductText,
                  subTitle: StringManager.areYouSureDeleteProductText,
                  onDeleteTap: () {
                    context.pop();
                    Get.put(ToolsController()).deleteTool(context, tool);
                  },
                ),
              );
            },
            icon: CircleAvatar(
              radius: 16.sp,
              backgroundColor: ColorManager.errorColor,
              child: Icon(
                Icons.delete,
                size: 18.sp,
                color: ColorManager.whiteColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
