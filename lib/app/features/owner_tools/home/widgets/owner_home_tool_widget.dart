import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tools_to_go_app/core/dialogs/delete_dialog.dart';
import 'package:tools_to_go_app/core/utils/assets_manager.dart';
import 'package:tools_to_go_app/core/utils/color_manager.dart';
import 'package:tools_to_go_app/core/utils/string_manager.dart';

import '../../../../../core/dialogs/delete_user_dialog.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/utils/style_manager.dart';

class OwnerHomeToolWidget extends StatelessWidget {
  const OwnerHomeToolWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
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
                  child: Image.asset(
                    AssetsManager.completeOrdersIcon,
                    width: 50.sp,
                    height: 50.sp,
                  ),
                ),
                Flexible(
                  child: ListTile(
                    dense: true,
                    title: Text(
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
                            '20 ريال',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          verticalSpace(10.h),
                          Text('xx'),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
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
                  onDeleteTap: () {},
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
