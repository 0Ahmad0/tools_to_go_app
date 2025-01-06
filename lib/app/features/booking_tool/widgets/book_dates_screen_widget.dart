import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:tools_to_go_app/app/features/auth/screens/change_password_screen.dart';
import 'package:tools_to_go_app/core/helpers/sizer.dart';
import 'package:tools_to_go_app/core/helpers/spacing.dart';
import 'package:tools_to_go_app/core/utils/color_manager.dart';
import 'package:tools_to_go_app/core/utils/string_manager.dart';
import 'package:tools_to_go_app/core/utils/style_manager.dart';

class BookDatesScreenWidget extends StatefulWidget {
  const BookDatesScreenWidget({super.key});

  @override
  State<BookDatesScreenWidget> createState() => _BookDatesScreenWidgetState();
}

class _BookDatesScreenWidgetState extends State<BookDatesScreenWidget> {
  final DateRangePickerController controller = DateRangePickerController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        verticalSpace(10.h),
        Text(
          StringManager.selectBookDateText,
          style: StyleManager.font14SemiBold(),
        ),
        verticalSpace(10.h),
        SizedBox(
          width: double.infinity,
          height: getHeight(context) / 2.5,
          child: SfDateRangePicker(
            controller:controller,
            headerStyle: DateRangePickerHeaderStyle(
                backgroundColor: ColorManager.grayColor
            ),
            showActionButtons: true,
            onSubmit: (value){
              print(value);
              print('////////////////////');
              print(controller.displayDate);
            },
            backgroundColor: Colors.transparent,
            todayHighlightColor: ColorManager.primaryColor,
            view: DateRangePickerView.year,
            selectionColor: ColorManager.primaryColor,
          ),
        )
      ],
    );
  }
}
