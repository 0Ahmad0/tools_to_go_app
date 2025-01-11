import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:tools_to_go_app/core/dialogs/general_dialog.dart';
import 'package:tools_to_go_app/core/helpers/spacing.dart';
import 'package:tools_to_go_app/core/utils/color_manager.dart';
import 'package:tools_to_go_app/core/utils/string_manager.dart';
import 'package:tools_to_go_app/core/utils/style_manager.dart';
import 'package:tools_to_go_app/core/widgets/app_button.dart';

import '../../../../../core/dialogs/delete_dialog.dart';

class OwnerToolsRequestsWidget extends StatelessWidget {
  const OwnerToolsRequestsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: ColorManager.whiteColor,
        border: Border.all(
          color: ColorManager.primaryColor,
        ),
        borderRadius: BorderRadius.circular(
          14.r,
        ),
      ),
      child: Column(
        children: [
          Text(
            'اسم المنتج',
            style: StyleManager.font14SemiBold(),
          ),
          Divider(),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              'اسم العميل',
              style: StyleManager.font14SemiBold(),
            ),
            subtitle: Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(children: [
                      TextSpan(
                          text: StringManager.dateOfBookText + ' : ',
                          style: StyleManager.font14SemiBold()),
                      TextSpan(
                        text: DateFormat.yMd().add_jm().format(
                          DateTime.now(),
                        ),
                      ),
                    ]),
                  ),
                  verticalSpace(10.h),
                  Text.rich(
                    TextSpan(children: [
                      TextSpan(
                          text: StringManager.locationBookText,
                          style: StyleManager.font14SemiBold()),
                      TextSpan(
                        text: 'الرياض - الشارع الرئيسي 123',
                      ),
                    ]),
                  ),
                ],
              ),
            ),
          ),
          verticalSpace(10.h),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) =>
                          GeneralDialog(
                            title: StringManager.approvedRequestText,
                            subTitle: StringManager.areYouSureApprovedRequestText,
                            onOkTap: () {},
                          ),
                    );
                  },
                  borderRadius: BorderRadius.circular(8.r),
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 10.h,
                    ),
                    decoration: BoxDecoration(
                      color: ColorManager.successColor,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      StringManager.approvedRequestText,
                      style: StyleManager.font14Regular(
                          color: ColorManager.whiteColor),
                    ),
                  ),
                ),
              ),
              horizontalSpace(10.w),
              Expanded(
                child: InkWell(
                  borderRadius: BorderRadius.circular(8.r),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) =>
                          DeleteDialog(
                            title: StringManager.cancelRequestText,
                            subTitle: StringManager.areYouSureCancelRequestText,
                            onDeleteTap: () {},
                          ),
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 10.h,
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: ColorManager.errorColor,
                        ),
                        borderRadius: BorderRadius.circular(8.r)),
                    child: Text(
                      StringManager.cancelRequestText,
                      style: StyleManager.font14Regular(
                          color: ColorManager.errorColor),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
