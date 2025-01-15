import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tools_to_go_app/app/features/auth/controller/auth_controller.dart';
import 'package:tools_to_go_app/app/features/auth/screens/change_password_screen.dart';
import 'package:tools_to_go_app/core/dialogs/general_dialog.dart';
import 'package:tools_to_go_app/core/helpers/extensions.dart';
import 'package:tools_to_go_app/core/helpers/get_color_status_appointments.dart';
import 'package:tools_to_go_app/core/helpers/spacing.dart';
import 'package:tools_to_go_app/core/utils/color_manager.dart';
import 'package:tools_to_go_app/core/utils/string_manager.dart';
import 'package:tools_to_go_app/core/utils/style_manager.dart';

import '../../../../../core/models/appointment.dart';
import '../controller/worker_appointments_controller.dart';

class OrderTakerOrderWidget extends StatelessWidget {
  const OrderTakerOrderWidget({super.key, required this.index, this.item});

  final int index;
  final Appointment? item;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap:item?.getState!=ColorAppointments.Ongoing?
      null: () {

        showDialog(
            context: context,
            builder: (context) => GeneralDialog(
                  title: StringManager.deliveryProductText,
                  subTitle: StringManager.areYouSureDeliveredProductToCustomerText,
                  onOkTap: () {
                    context.pop();
                    Get.put(WorkerAppointmentsController()).concludeAppointments(context, item);
                  },
              cancelText: StringManager.noText,
                ));
      },
      leading: CircleAvatar(
        backgroundColor: ColorManager.primaryColor,
        child: FittedBox(
          child: Text(

            '# ${index}',
            style: StyleManager.font16SemiBold(color: ColorManager.whiteColor),
          ),
        ),
      ),
      title: Text(
        item?.nameTool??
        'مثقاب كهربائي',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Padding(
        padding: EdgeInsets.only(top: 8.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.location_pin,
                  size: 16.sp,
                ),
                horizontalSpace(10.w),
                Text(
                  '123, الشارع الرئيسي الرياض',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
            verticalSpace(10.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
              decoration: BoxDecoration(
                color:
                getColorStatusAppointments(item?.getState??ColorAppointments.Pending),
                // ColorManager.orangeColor,
                borderRadius: BorderRadius.circular(100.r),
              ),
              child: Text(
                item?.getStateArabic??
                'في الانتظار',
                style:
                    StyleManager.font12Regular(color: ColorManager.whiteColor),
              ),
            )
          ],
        ),
      ),
      trailing: Visibility(
          visible: item?.getState==ColorAppointments.Ongoing,
          child: Icon(Icons.arrow_forward_ios)),
    );
  }
}
