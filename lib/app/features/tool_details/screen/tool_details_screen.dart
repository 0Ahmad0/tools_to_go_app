import 'package:animate_do/animate_do.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tools_to_go_app/app/features/auth/controller/auth_controller.dart';
import 'package:tools_to_go_app/core/helpers/extensions.dart';
import 'package:tools_to_go_app/core/routing/routes.dart';
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
                        verticalSpace(20.h),
                        CarouselSlider(
                          items: [1, 2, 3, 4, 5]
                              .map((item) => Container(
                                    alignment: Alignment.center,
                                    width: double.infinity,
                                    height: 250.h,
                                    decoration: BoxDecoration(
                                        color: ColorManager.grayColor,
                                        borderRadius:
                                            BorderRadius.circular(12.r)),
                                    child: Text(
                                      item.toString(),
                                      style: StyleManager.font20SemiBold(),
                                    ),
                                  ))
                              .toList(),
                          options: CarouselOptions(
                            autoPlay: true,
                            enlargeCenterPage: true,

                          ),
                        ),
                        verticalSpace(20.h),
                        Text(
                          'مثقاب كهربائي احترافي',
                          style: StyleManager.font16SemiBold(),
                        ),
                        verticalSpace(10.h),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.star,
                              color: ColorManager.rateStarColor,
                              size: 20.sp,
                            ),
                            horizontalSpace(10.w),
                            Text(
                              '4.5 (20 تقييم)',
                            ),
                          ],
                        ),
                        verticalSpace(10.h),
                        Text(
                          '25 ريال/يوم',
                          style: StyleManager.font14SemiBold(),
                        ),
                        verticalSpace(20.h),
                        Text(
                          StringManager.descriptionText,
                          style: StyleManager.font18SemiBold(),
                        ),
                        Text(
                          'مثقاب كهربائي احترافي وقوي متعدد الاستخدامات, مثالي للأعمال المنزلية و المهنية',
                          style:
                              StyleManager.font14Regular().copyWith(height: 1.8),
                        ),
                        verticalSpace(20.h),
                        Text(
                          StringManager.featuresText,
                          style: StyleManager.font18SemiBold(),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: getFeaturesToolAsList(featuresTool)
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
                AppButton(onPressed: () {
                  context.pushNamed(Routes.bookingToolRoute);
                }, text: StringManager.orderNowText)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
