import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tools_to_go_app/core/helpers/spacing.dart';
import 'package:tools_to_go_app/core/utils/color_manager.dart';
import 'package:tools_to_go_app/core/utils/string_manager.dart';
import 'package:tools_to_go_app/core/utils/style_manager.dart';
import 'package:tools_to_go_app/core/widgets/app_button.dart';
import 'package:tools_to_go_app/core/widgets/app_padding.dart';

class ToolDetailsScreen extends StatelessWidget {
  const ToolDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: CircleAvatar(
                              backgroundColor: ColorManager.grayColor,
                              child: Icon(Icons.arrow_back_ios_new),
                            ),
                          ),
                          Flexible(
                            child: Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              height: 250.h,
                              decoration: BoxDecoration(
                                  color: ColorManager.grayColor,
                                  borderRadius: BorderRadius.circular(12.r)),
                              child: Text(
                                '1',
                                style: StyleManager.font20SemiBold(),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: CircleAvatar(
                              backgroundColor: ColorManager.grayColor,
                              child: Icon(Icons.arrow_forward_ios),
                            ),
                          ),
                        ],
                      ),
                      verticalSpace(20.h),
                      Text('مثقاب كهربائي احترافي',
                        style: StyleManager.font16SemiBold(),
                      )
                    ],
                  ),
                ),
              ),
              AppButton(onPressed: () {}, text: StringManager.orderNowText)
            ],
          ),
        ),
      ),
    );
  }
}
