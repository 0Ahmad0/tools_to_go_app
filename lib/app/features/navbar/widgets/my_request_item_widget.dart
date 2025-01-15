import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:tools_to_go_app/app/features/auth/controller/auth_controller.dart';
import 'package:tools_to_go_app/core/helpers/extensions.dart';
import 'package:tools_to_go_app/core/helpers/spacing.dart';
import 'package:tools_to_go_app/core/models/appointment.dart';
import 'package:tools_to_go_app/core/routing/routes.dart';
import 'package:tools_to_go_app/core/utils/color_manager.dart';
import 'package:tools_to_go_app/core/utils/string_manager.dart';
import 'package:tools_to_go_app/core/utils/style_manager.dart';
import 'package:tools_to_go_app/core/widgets/app_button.dart';

import '../../../../../core/dialogs/delete_dialog.dart';
import '../../../../core/helpers/get_color_status_appointments.dart';

class MyRequestItemWidget extends StatelessWidget {
  const MyRequestItemWidget({super.key, this.item});
final Appointment? item;
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
            item?.nameTool??
            'اسم المنتج',
            style: StyleManager.font14SemiBold(),
          ),
          Divider(),
          ListTile(
            dense: true,
            isThreeLine: true,
            contentPadding: EdgeInsets.zero,
            title: Text(

              'اسم عالم التوصيل : '+"${ item?.nameWorker??""}",
              style: StyleManager.font14SemiBold(),
            ),
            trailing:
            item?.idWorker!=null&&([ColorAppointments.Ongoing,ColorAppointments.StartingSoon,ColorAppointments.Concluded].contains(item?.getState))?
            IconButton(
              onPressed: () {
                context.pushNamed(Routes.messagesRoute);
              },
              icon: Icon(
                Icons.chat,
              ),
            )
            :SizedBox.shrink()

            ,
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
                          item?.selectDate??
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
                        text:   item?.deliveryAddress?.address??'الرياض - الشارع الرئيسي 123',
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
              color:
              getColorStatusAppointments(item?.getState??ColorAppointments.Pending),
              // ColorManager.orangeColor,
              borderRadius: BorderRadius.circular(100.r),
            ),
            child: Text(
              item?.getStateArabic??
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
