import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:tools_to_go_app/app/features/auth/screens/change_password_screen.dart';
import 'package:tools_to_go_app/app/features/booking_tool/widgets/book_dates_screen_widget.dart';
import 'package:tools_to_go_app/app/features/booking_tool/widgets/book_description_screen_widget.dart';
import 'package:tools_to_go_app/app/features/booking_tool/widgets/book_payment_screen_widget.dart';
import 'package:tools_to_go_app/core/helpers/spacing.dart';
import 'package:tools_to_go_app/core/models/appointment.dart';
import 'package:tools_to_go_app/core/utils/const_value_manager.dart';
import 'package:tools_to_go_app/core/utils/string_manager.dart';
import 'package:tools_to_go_app/core/utils/style_manager.dart';
import 'package:tools_to_go_app/core/widgets/app_button.dart';
import 'package:tools_to_go_app/core/widgets/app_padding.dart';

import '../../../../core/utils/color_manager.dart';
import '../controller/customer_booking_tool_controller.dart';

class BookingToolScreen extends StatefulWidget {
  const BookingToolScreen({super.key});

  @override
  State<BookingToolScreen> createState() => _BookingToolScreenState();
}

class _BookingToolScreenState extends State<BookingToolScreen> {
  int _currentIndex = 0;

  _getCurrentScreen(int index){
    switch(index){
      case 0:
        return BookDatesScreenWidget();
        case 1:
        return BookDescriptionScreenWidget();
        case 2:
        return BookPaymentScreenWidget();
    }
  }
  late CustomerBookingToolController controller;

  @override
  void initState() {
    controller = Get.put(CustomerBookingToolController());
    controller.onInit();
    controller.appointment=Appointment();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      child: Scaffold(
        appBar: AppBar(
          title: Text(StringManager.bookingOperationText),
        ),
        body: AppPaddingWidget(
          horizontalPadding: 12.w,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 600),
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
            decoration: BoxDecoration(
                color: ColorManager.whiteColor,
                border: Border.all(color: ColorManager.hintTextColor),
                borderRadius: BorderRadius.circular(12.r)),
            child:
            GetBuilder<CustomerBookingToolController>(
                builder: (CustomerBookingToolController customerBookingToolController)=>
            SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    StringManager.bookingOperationText,
                    style: StyleManager.font24Bold(),
                  ),
                  verticalSpace(20.h),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 8.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      color: ColorManager.grayColor,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                        children: List.generate(
                            ConstValueManager.bookingList.length,
                            (index) => Flexible(
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        _currentIndex = index;
                                      });
                                    },
                                    child: AnimatedContainer(
                                      duration: Duration(milliseconds: 600),
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 8.w,
                                        vertical: 8.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _currentIndex == index
                                            ? ColorManager.whiteColor
                                            : null,
                                        borderRadius: BorderRadius.circular(4.r),
                                      ),
                                      child: Text(
                                        ConstValueManager.bookingList[index],
                                        style: StyleManager.font14Regular(
                                            color: _currentIndex == index
                                                ? ColorManager.primaryColor
                                                : ColorManager.hintTextColor),
                                      ),
                                    ),
                                  ),
                                ))),
                  ),
                  verticalSpace(10.h),
                  _getCurrentScreen(_currentIndex),
              
                  if(customerBookingToolController.appointment?.selectDate!=null)...[
                    verticalSpace(20.h),
                    Text.rich(
                      TextSpan(children: [
                        TextSpan(
                            text:"تفاصيل المنتج:"+"\n",
                            style: StyleManager.font14SemiBold()),
                        TextSpan(
                          text: DateFormat.yMd().format(
                            customerBookingToolController.appointment?.selectDate??
                            DateTime.now(),
                          ),
                        ),
                      ]),
                    ),
                  ],
              
              
                  verticalSpace(20.h),
                  AppButton(onPressed: () async {
              
                    if(await controller.validateBook(context)){
                      controller.addAppointment(context);
                    }
                  }, text:
                  StringManager.confirmBookingText)
              
                ],
              ),
            )),
          ),
        ),
      ),
    );
  }
}
