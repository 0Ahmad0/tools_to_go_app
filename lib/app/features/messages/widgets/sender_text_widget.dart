import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import '../../../../core/enums/enums.dart';
import '../../../../core/helpers/sizer.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/models/message_model.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/style_manager.dart';
import '../controller/chat_room_controller.dart';

class SenderTextWidget extends StatelessWidget {
  const SenderTextWidget({
    super.key, required this.text, this.sendingTime,
  });
  final String text;
  final DateTime? sendingTime;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,

      child: Padding(
        padding:  EdgeInsets.symmetric(
            vertical: 10.h
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: 12.w, vertical: 12.h),
              constraints: BoxConstraints(
                  maxWidth: getWidth(context) / 1.75
              ),
              decoration: BoxDecoration(
                  color: ColorManager.blueColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(14.r),
                    topRight: Radius.circular(14.r),
                    bottomRight: Radius.circular(14.r),
                  )),
              child: Text(
                text,
                style: StyleManager.font12Regular(
                    color: ColorManager.whiteColor),
              ),
            ),
            horizontalSpace(8.w),
            Text(
              DateFormat().add_jm().format(sendingTime??DateTime.now()),
              style: StyleManager.font10Bold(
                  color: ColorManager.hintTextColor
              ),
            )
          ],
        ),
      ),
    );
  }

}
