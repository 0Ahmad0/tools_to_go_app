import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tools_to_go_app/app/features/auth/screens/change_password_screen.dart';
import 'package:tools_to_go_app/core/dialogs/general_dialog.dart';
import 'package:tools_to_go_app/core/helpers/spacing.dart';
import 'package:tools_to_go_app/core/utils/color_manager.dart';
import 'package:tools_to_go_app/core/utils/string_manager.dart';
import 'package:tools_to_go_app/core/utils/style_manager.dart';

class OrderTakerOrderWidget extends StatelessWidget {
  const OrderTakerOrderWidget({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) => GeneralDialog(
                  title: StringManager.deliveryProductText,
                  subTitle: StringManager.areYouSureDeliveredProductToCustomerText,
                  onOkTap: () {},
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
                color: ColorManager.orangeColor,
                borderRadius: BorderRadius.circular(100.r),
              ),
              child: Text(
                'في الانتظار',
                style:
                    StyleManager.font12Regular(color: ColorManager.whiteColor),
              ),
            )
          ],
        ),
      ),
      trailing: Icon(Icons.arrow_forward_ios),
    );
  }
}
