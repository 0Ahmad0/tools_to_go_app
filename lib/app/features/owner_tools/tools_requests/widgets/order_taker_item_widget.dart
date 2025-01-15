
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tools_to_go_app/app/features/auth/controller/auth_controller.dart';
import 'package:tools_to_go_app/app/features/auth/screens/change_password_screen.dart';
import 'package:tools_to_go_app/core/dialogs/delete_dialog.dart';
import 'package:tools_to_go_app/core/dialogs/general_dialog.dart';
import 'package:tools_to_go_app/core/helpers/extensions.dart';
import 'package:tools_to_go_app/core/models/user_model.dart';
import 'package:tools_to_go_app/core/utils/color_manager.dart';
import 'package:tools_to_go_app/core/utils/string_manager.dart';
import 'package:tools_to_go_app/core/utils/style_manager.dart';
import 'package:tools_to_go_app/core/widgets/image_user_provider.dart';

import '../../../booking_tool/controller/customer_booking_tool_controller.dart';

class OrderTakerItemWidget extends StatelessWidget {
  const OrderTakerItemWidget({super.key, required this.index, this.worker, this.confirmLocation});

  final int index;
  final UserModel? worker;
  final Function(UserModel? selectedWorker)? confirmLocation;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => GeneralDialog(
            title: StringManager.addOrderTakerText,
            subTitle: StringManager.areYouSureAddOrderTakerText,
            onOkTap: () {
              confirmLocation!=null?confirmLocation!(worker):"";
              context.pop();

            },
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 8.h
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: ColorManager.primaryColor,
              width: .5.sp
            )
          )
        ),
        child: ListTile(
          leading:
          worker?.photoUrl!=null?
          ImageUserProvider(
            backgroundColor: ColorManager.orangeColor,
            url: worker?.photoUrl,
          ):
          CircleAvatar(
            backgroundColor: ColorManager.orangeColor,
            child: Text('${index}'),
          ),
          dense: true,
          title: Text(
            worker?.name??
            'اسم عامل التوصيل',
            style: StyleManager.font14SemiBold(),
          ),
          trailing:

          Icon(
            Get.put(CustomerBookingToolController()).appointment?.idWorker==worker?.uid&&worker!=null?
            Icons.check_circle_outline_outlined:
            Icons.add_circle_outline,
            color: ColorManager.orangeColor,
          ),
        ),
      ),
    );
  }
}
