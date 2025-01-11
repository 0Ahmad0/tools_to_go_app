import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tools_to_go_app/app/features/auth/controller/auth_controller.dart';
import 'package:tools_to_go_app/app/features/auth/widgets/select_location_user_widget.dart';
import 'package:tools_to_go_app/core/helpers/extensions.dart';
import 'package:tools_to_go_app/core/routing/routes.dart';
import 'package:tools_to_go_app/core/utils/const_value_manager.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/string_manager.dart';
import '../../../../core/utils/style_manager.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_padding.dart';
import '../../../../core/widgets/app_textfield.dart';

var _borderTextFiled = ({Color color = ColorManager.primaryColor}) =>
    OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(color: color, width: 1.sp));

class SignupScreenWidget extends StatefulWidget {
  const SignupScreenWidget({super.key});

  @override
  State<SignupScreenWidget> createState() => _SignupScreenWidgetState();
}

class _SignupScreenWidgetState extends State<SignupScreenWidget> {
  String? typeUser;

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
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
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
                      Text(StringManager.typeUserText),
                      verticalSpace(10.h),
                      DropdownButtonFormField(
                        value: typeUser,
                        icon: Icon(Icons.keyboard_arrow_down),
                        decoration: InputDecoration(
                          focusedBorder: _borderTextFiled(),
                          border: _borderTextFiled(),
                          enabledBorder: _borderTextFiled(),
                          errorBorder:
                              _borderTextFiled(color: ColorManager.errorColor),
                          iconColor: ColorManager.grayColor,
                        ),
                        hint: Text(StringManager.typeUserHintText,
                            style: StyleManager.font14Regular(
                              color: ColorManager.hintTextColor,
                            )),
                        items: ConstValueManager.typeUserList
                            .map(
                              (e) => DropdownMenuItem(
                                child: Text(e),
                                value: e,
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          typeUser = value;
                          setState(() {});
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'يرجى اختيار نوع المستخدم';
                          }
                        },
                      ),
                      verticalSpace(20.h),
                      AppButton(
                        onPressed: () {
                          if (typeUser == 'مستخدم عادي') {
                            context.pushReplacement(
                              Routes.customerHomeRoute
                            );
                          }
                          if (typeUser == 'عامل توصيل') {
                            context.pushReplacement(
                                Routes.orderTakerHomeRoute
                            );
                          }
                          if (typeUser == 'مالك معدات') {
                            context.pushReplacement(
                                Routes.ownerHomeRoute
                            );
                          }
                        },
                        text: StringManager.signUpText,
                      )
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
