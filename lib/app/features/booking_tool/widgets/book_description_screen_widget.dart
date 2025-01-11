import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tools_to_go_app/app/features/booking_tool/widgets/select_order_taker_widget.dart';
import 'package:tools_to_go_app/core/helpers/spacing.dart';
import 'package:tools_to_go_app/core/utils/style_manager.dart';
import 'package:tools_to_go_app/core/widgets/app_textfield.dart';

import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/string_manager.dart';
import '../../auth/widgets/select_location_user_widget.dart';

class BookDescriptionScreenWidget extends StatefulWidget {
  const BookDescriptionScreenWidget({super.key});

  @override
  State<BookDescriptionScreenWidget> createState() =>
      _BookDescriptionScreenWidgetState();
}

class _BookDescriptionScreenWidgetState
    extends State<BookDescriptionScreenWidget> {
  bool withOrderTaker = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'عنوان التوصيل',
          style: StyleManager.font14SemiBold(),
        ),
        verticalSpace(10.h),
        AppTextField(
          readOnly: true,
          onTap: () {
            showDialog(
              barrierDismissible: true,
              context: context,
              builder: (context) => SelectLocationUserWidget(),
            );
          },
          hintText: StringManager.enterYourLocationText,
        ),
        verticalSpace(20.h),
        Text(
          'تعليمات خاصة',
          style: StyleManager.font14SemiBold(),
        ),
        verticalSpace(10.h),
        AppTextField(
          hintText: 'أدخل تعليمات خاصة',
        ),
        verticalSpace(10.h),
        StatefulBuilder(builder: (context, orderTakerState) {
          return Column(
            children: [
              CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  value: withOrderTaker,
                  title: Text(
                    StringManager.withOrderTakerText,
                    style: StyleManager.font14SemiBold(),
                  ),
                  onChanged: (value) {
                    orderTakerState(() {
                      withOrderTaker = value!;
                    });
                  }),
              Visibility(
                visible: withOrderTaker,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'عامل التوصيل',
                      style: StyleManager.font14SemiBold(),
                    ),
                    verticalSpace(10.h),
                    AppTextField(
                      readOnly: true,
                      onTap: () {
                        showModalBottomSheet(
                            isScrollControlled: true,
                            showDragHandle: true,
                            backgroundColor: ColorManager.whiteColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                              top: Radius.circular(14.r),
                            )),
                            context: context,
                            builder: (context) => SelectOrderTakerWidget());
                      },
                      hintText: 'اختر عامل التوصيل',
                    ),
                  ],
                ),
              )
            ],
          );
        }),
      ],
    );
  }
}
