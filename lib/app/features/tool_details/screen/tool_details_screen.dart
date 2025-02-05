import 'package:animate_do/animate_do.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tools_to_go_app/app/features/auth/controller/auth_controller.dart';
import 'package:tools_to_go_app/app/features/tool_details/widgets/rate_dialog_widget.dart';
import 'package:tools_to_go_app/core/helpers/extensions.dart';
import 'package:tools_to_go_app/core/models/tool.dart';
import 'package:tools_to_go_app/core/routing/routes.dart';
import 'package:tools_to_go_app/core/widgets/image_tool.dart';
import '../../booking_tool/controller/customer_booking_tool_controller.dart';
import '/core/helpers/spacing.dart';
import '/core/utils/color_manager.dart';
import '/core/utils/string_manager.dart';
import '/core/utils/style_manager.dart';
import '/core/widgets/app_button.dart';
import '/core/widgets/app_padding.dart';

class ToolDetailsScreen extends StatefulWidget {
  const ToolDetailsScreen({super.key});

  @override
  State<ToolDetailsScreen> createState() => _ToolDetailsScreenState();
}

class _ToolDetailsScreenState extends State<ToolDetailsScreen> {
  String featuresTool = 'قوة : 800 واط\n'
      'سرعة دوران : 0-3000 دورة/دقيقة\n'
      'سعة الظرف : 13 مم\n'
      'وزن : 2.5 كجم';
  List<String> featuresList = [];
  ToolModel? tool;

  List<String> getFeaturesToolAsList(String text) {
    featuresList = text
        .split('\n')
        .map((feature) => feature.trim())
        .where((feature) => feature.isNotEmpty)
        .toList();
    return featuresList;
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    tool = args?["tool"];

    return FadeInUp(
      child: Scaffold(
        appBar: AppBar(
          title: Text(StringManager.toolDetailsText),
        ),
        body: FadeInDown(
          child: AppPaddingWidget(
            horizontalPadding: 12.w,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (tool?.images?.isNotEmpty ?? false) ...[
                          verticalSpace(20.h),
                          CarouselSlider(
                            items:
                                // [1, 2, 3, 4, 5]
                                (tool?.images ?? [])
                                    .map((item) => Container(
                                  margin: EdgeInsets.symmetric(
                                    vertical: 14.h
                                  ),
                                        alignment: Alignment.center,
                                        width: double.infinity,
                                        height: 250.h,
                                        decoration: BoxDecoration(
                                          color: ColorManager.grayColor,
                                          boxShadow: [
                                            BoxShadow(
                                              color: ColorManager.shadowColor,
                                              blurRadius: 16.sp,
                                              offset: Offset(0, 4),
                                            )
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(12.r),
                                        ),
                                        child: ImageTool(
                                          url: item,
                                          fit: BoxFit.fill,
                                          width: double.maxFinite,

                                        )
                                        // Text(
                                        //   item.toString(),
                                        //   style: StyleManager.font20SemiBold(),
                                        // ),
                                        ))
                                    .toList(),
                            options: CarouselOptions(
                              autoPlay: true,
                              enlargeCenterPage: true,
                              enlargeFactor: .35
                            ),
                          )
                        ],
                        verticalSpace(20.h),
                        Text(
                          tool?.name ?? 'مثقاب كهربائي احترافي',
                          style: StyleManager.font16SemiBold(),
                        ),
                        verticalSpace(10.h),
                        InkWell(
                          onTap: () {
                            Get.put(CustomerBookingToolController()).tool =
                                tool;

                            showDialog(
                                context: context,
                                builder: (_) => RateDialogWidget());
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.star,
                                color: ColorManager.rateStarColor,
                                size: 20.sp,
                              ),
                              horizontalSpace(10.w),
                              Text(
                                '${tool?.getRate ?? "4.5"} (${tool?.reviews?.length ?? 0} تقييم)',
                                // '4.5 (20 تقييم)',
                              ),
                            ],
                          ),
                        ),
                        verticalSpace(10.h),
                        Text(
                          '${tool?.fee ?? '??'} ريال/كل اسبوع',
                          // '${ tool?.fee??'??'} ريال/يوم',
                          // '25 ريال/يوم',
                          style: StyleManager.font14SemiBold(),
                        ),
                        verticalSpace(20.h),
                        Text(
                          StringManager.descriptionText,
                          style: StyleManager.font18SemiBold(),
                        ),
                        Text(
                          tool?.description ??
                              'مثقاب كهربائي احترافي وقوي متعدد الاستخدامات, مثالي للأعمال المنزلية و المهنية',
                          style: StyleManager.font14Regular()
                              .copyWith(height: 1.8),
                        ),
                        verticalSpace(20.h),
                        Text(
                          StringManager.featuresText,
                          style: StyleManager.font18SemiBold(),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: getFeaturesToolAsList(
                                  tool?.specifications ?? featuresTool)
                              .map((e) => Text(
                                    '* ' + e,
                                    style: StyleManager.font14SemiBold()
                                        .copyWith(height: 1.8),
                                  ))
                              .toList(),
                        )
                      ],
                    ),
                  ),
                ),
                AppButton(
                    onPressed: () {
                      Get.put(CustomerBookingToolController()).tool = tool;
                      Get.put(CustomerBookingToolController()).appointment =
                          null;
                      context.pushNamed(Routes.bookingToolRoute);
                    },
                    text: StringManager.orderNowText)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
