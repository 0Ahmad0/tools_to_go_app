import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tools_to_go_app/app/features/auth/screens/change_password_screen.dart';
import 'package:tools_to_go_app/core/dialogs/delete_dialog.dart';
import 'package:tools_to_go_app/core/dialogs/general_dialog.dart';
import 'package:tools_to_go_app/core/utils/color_manager.dart';
import 'package:tools_to_go_app/core/utils/string_manager.dart';
import 'package:tools_to_go_app/core/utils/style_manager.dart';

class OrderTakerItemWidget extends StatelessWidget {
  const OrderTakerItemWidget({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => GeneralDialog(
            title: StringManager.addOrderTakerText,
            subTitle: StringManager.areYouSureAddOrderTakerText,
            onOkTap: () {},
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
          leading: CircleAvatar(
            backgroundColor: ColorManager.orangeColor,
            child: Text('${index}'),
          ),
          dense: true,
          title: Text(
            'اسم عامل التوصيل',
            style: StyleManager.font14SemiBold(),
          ),
          trailing: Icon(
            Icons.add_circle_outline,
            color: ColorManager.orangeColor,
          ),
        ),
      ),
    );
  }
}
