import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/string_manager.dart';
import '../../../../core/utils/style_manager.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_padding.dart';
import '../../../../core/widgets/app_textfield.dart';

class SignupScreenWidget extends StatelessWidget {
  const SignupScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPaddingWidget(
      horizontalPadding: 12.w,
      child: SingleChildScrollView(
        child: Form(
          // key: ,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                decoration: BoxDecoration(
                    color: ColorManager.whiteColor,
                    border: Border.all(color: ColorManager.hintTextColor),
                    borderRadius: BorderRadius.circular(12.r)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      StringManager.signUpText,
                      style: StyleManager.font24Bold(),
                    ),
                    verticalSpace(20.h),
                    Text(StringManager.nameText),
                    verticalSpace(10.h),
                    AppTextField(
                      hintText: StringManager.enterNameText,
                    ),

                    verticalSpace(20.h),
                    Text(StringManager.emailText),
                    verticalSpace(10.h),
                    AppTextField(
                      hintText: StringManager.enterEmailText,
                    ),
                    verticalSpace(20.h),
                    Text(StringManager.passwordText),
                    verticalSpace(10.h),
                    AppTextField(
                      hintText: StringManager.enterPasswordText,
                      obscureText: true,
                      suffixIcon: true,
                    ),
                  verticalSpace(20.h),
                    Text(StringManager.confirmPasswordText),
                    verticalSpace(10.h),
                    AppTextField(
                      hintText: StringManager.enterConfirmPasswordText,
                      obscureText: true,
                      suffixIcon: true,
                    ),
                    verticalSpace(20.h),
                    AppButton(onPressed: (){}, text: StringManager.signUpText,)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }
}
