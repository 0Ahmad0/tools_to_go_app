import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tools_to_go_app/app/features/auth/controller/auth_controller.dart';
import 'package:tools_to_go_app/app/features/auth/screens/change_password_screen.dart';
import 'package:tools_to_go_app/core/helpers/extensions.dart';
import 'package:tools_to_go_app/core/helpers/spacing.dart';
import 'package:tools_to_go_app/core/routing/routes.dart';
import 'package:tools_to_go_app/core/utils/color_manager.dart';
import 'package:tools_to_go_app/core/utils/string_manager.dart';
import 'package:tools_to_go_app/core/utils/style_manager.dart';
import 'package:tools_to_go_app/core/widgets/app_button.dart';
import 'package:tools_to_go_app/core/widgets/app_padding.dart';
import 'package:tools_to_go_app/core/widgets/app_textfield.dart';

class LoginScreenWidget extends StatelessWidget {
  const LoginScreenWidget({super.key});

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
                      StringManager.loginText,
                      style: StyleManager.font24Bold(),
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
                    verticalSpace(10.h),
                    InkWell(
                        onTap: () {
                          context.pushNamed(Routes.forgotPasswordRoute);
                        },
                        child: Text(StringManager.forgotPasswordLoginText)),
                    verticalSpace(20.h),
                    AppButton(onPressed: (){}, text: StringManager.loginText,)
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
