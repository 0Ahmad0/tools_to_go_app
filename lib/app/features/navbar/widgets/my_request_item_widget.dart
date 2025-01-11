import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:tools_to_go_app/app/features/auth/controller/auth_controller.dart';
import 'package:tools_to_go_app/core/helpers/extensions.dart';
import 'package:tools_to_go_app/core/helpers/spacing.dart';
import 'package:tools_to_go_app/core/routing/routes.dart';
import 'package:tools_to_go_app/core/utils/color_manager.dart';
import 'package:tools_to_go_app/core/utils/string_manager.dart';
import 'package:tools_to_go_app/core/utils/style_manager.dart';
import 'package:tools_to_go_app/core/widgets/app_button.dart';

import '../../../../../core/dialogs/delete_dialog.dart';

class MyRequestItemWidget extends StatelessWidget {
  const MyRequestItemWidget({super.key});

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'اسم المنتج',
            style: StyleManager.font14SemiBold(),
          ),
          Divider(),
          ListTile(
            dense: true,
            isThreeLine: true,
            contentPadding: EdgeInsets.zero,
            title: Text(
              'اسم عالم التوصيل : ',
              style: StyleManager.font14SemiBold(),
            ),
            trailing: IconButton(
              onPressed: () {
                context.pushNamed(Routes.messagesRoute);
              },
              icon: Icon(
                Icons.chat,
              ),
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
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: ColorManager.orangeColor,
              borderRadius: BorderRadius.circular(100.r),
            ),
            child: Text(
              'حالة الطلب',
              style: StyleManager.font10Bold(
                color: ColorManager.whiteColor
              ),
            ),
          ),
        ],
      ),
    );
  }
}
