import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tools_to_go_app/app/features/auth/controller/auth_controller.dart';

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
    return FadeInLeft(
      child: AppPaddingWidget(
        horizontalPadding: 12.w,
        child: SingleChildScrollView(
          child: Form(
            // key: controller.formKey,
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
                        // controller: controller.nameController,
                        // validator: (value)=>controller.validateFullName(value!),
                        hintText: StringManager.enterNameText,
                      ),

                      verticalSpace(20.h),
                      Text(StringManager.emailText),
                      verticalSpace(10.h),
                      AppTextField(
                        // controller: controller.emailController,
                        // validator: (value)=>controller.validateEmail(value!),
                        hintText: StringManager.enterEmailText,
                      ),
                      verticalSpace(20.h),
                      Text(StringManager.passwordText),
                      verticalSpace(10.h),
                      AppTextField(
                        // controller: controller.passwordController,
                        // validator: (value)=>controller.validatePassword(value!),
                        hintText: StringManager.enterPasswordText,
                        obscureText: true,
                        suffixIcon: true,
                      ),
                    verticalSpace(20.h),
                      Text(StringManager.confirmPasswordText),
                      verticalSpace(10.h),
                      AppTextField(
                        // controller: controller.confirmPasswordController,
                        // validator: (value)=>,
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
      ),
    );

  }
}
