import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tools_to_go_app/app/features/booking_tool/widgets/select_order_taker_widget.dart';
import 'package:tools_to_go_app/core/helpers/extensions.dart';
import 'package:tools_to_go_app/core/helpers/spacing.dart';
import 'package:tools_to_go_app/core/models/location_model.dart';
import 'package:tools_to_go_app/core/utils/style_manager.dart';
import 'package:tools_to_go_app/core/widgets/app_textfield.dart';

import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/string_manager.dart';
import '../../auth/widgets/select_location_user_widget.dart';
import '../controller/customer_booking_tool_controller.dart';

class BookDescriptionScreenWidget extends StatefulWidget {
  const BookDescriptionScreenWidget({super.key});

  @override
  State<BookDescriptionScreenWidget> createState() =>
      _BookDescriptionScreenWidgetState();
}

class _BookDescriptionScreenWidgetState
    extends State<BookDescriptionScreenWidget> {
  bool withOrderTaker = false;
  TextEditingController specialInstructionsController=TextEditingController();
  TextEditingController nameWorkerController=TextEditingController();
  TextEditingController locationController=TextEditingController();
  late CustomerBookingToolController customerBookingToolController;
  @override
  void initState() {
    customerBookingToolController = Get.put(CustomerBookingToolController());
    super.initState();
    withOrderTaker=customerBookingToolController.appointment?.withDelivery??false;
    specialInstructionsController=TextEditingController(text: customerBookingToolController.appointment?.specialInstructions);
    nameWorkerController=TextEditingController(text: customerBookingToolController.appointment?.nameWorker);
    if(customerBookingToolController.appointment?.deliveryAddress!=null)
    locationController=TextEditingController(text: customerBookingToolController.appointment?.deliveryAddress?.address??
    "${customerBookingToolController.appointment?.deliveryAddress?.latitude??""} ${customerBookingToolController.appointment?.deliveryAddress?.longitude??""}"
    );


  }
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
          controller:locationController ,
          readOnly: true,
          onTap: () {
            showDialog(
              barrierDismissible: true,
              context: context,
              builder: (context) => SelectLocationUserWidget(
                confirmLocation: (selectedLocation,address){
                  if(selectedLocation!=null){
                    customerBookingToolController.appointment?.deliveryAddress=LocationModel(
                      address: address,
                        latitude: selectedLocation?.longitude,
                        longitude:selectedLocation?.latitude
                    );
                    if(customerBookingToolController.appointment?.deliveryAddress!=null)
                    locationController.text=customerBookingToolController.appointment?.deliveryAddress?.address??
                        "${customerBookingToolController.appointment?.deliveryAddress?.latitude??""} ${customerBookingToolController.appointment?.deliveryAddress?.longitude??""}";

                  }

                  },

              ),
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
          controller: specialInstructionsController,
          hintText: 'أدخل تعليمات خاصة',
          onChanged: (value){
            customerBookingToolController.appointment?.specialInstructions=value;
          },
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
                      customerBookingToolController.appointment?.withDelivery=withOrderTaker;
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
                      controller: nameWorkerController,
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
                            builder: (context) => SelectOrderTakerWidget(
                              confirmLocation: (selectedWorker){
                                if(selectedWorker!=null){
                                  customerBookingToolController.appointment?.idWorker=selectedWorker.uid;
                                  customerBookingToolController.appointment?.nameWorker=selectedWorker.name;
                                  nameWorkerController.text=customerBookingToolController.appointment?.nameWorker??"";
                                  context.pop();
                                }

                              },

                            ));
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
