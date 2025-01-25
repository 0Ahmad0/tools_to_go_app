import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tools_to_go_app/core/helpers/spacing.dart';
import 'package:tools_to_go_app/core/utils/color_manager.dart';
import 'package:tools_to_go_app/core/utils/string_manager.dart';

import '../../booking_tool/controller/customer_booking_tool_controller.dart';

class RateDialogWidget extends StatelessWidget {
   RateDialogWidget({super.key});
  double currentRating = 1;

  @override
  Widget build(BuildContext context) {
    currentRating=      Get.put(CustomerBookingToolController()).tool?.getRateUser??currentRating;
    // currentRating=      Get.put(CustomerBookingToolController()).tool?.getRate?.toInt()??currentRating;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Material(
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(20.sp),
            decoration: BoxDecoration(
              color: ColorManager.whiteColor,
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ToDo : Add Rate
                Text(StringManager.rateToolText),
                verticalSpace(20.h),
                RatingBar.builder(
                  initialRating:   currentRating,
                  minRating: 1,

                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    currentRating =rating;

                  },
                ),
                verticalSpace(20.h),
                TextButton(onPressed: (){

                  Get.put(CustomerBookingToolController()).addReview(context, rate: currentRating,text:  "");


                }, child: Text(StringManager.rateText))
              ],
            ),
          ),
        )
      ],
    );
  }
}
