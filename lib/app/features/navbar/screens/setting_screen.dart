import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tools_to_go_app/app/features/auth/screens/change_password_screen.dart';
import 'package:tools_to_go_app/core/helpers/spacing.dart';
import 'package:tools_to_go_app/core/utils/style_manager.dart';
import 'package:tools_to_go_app/core/widgets/app_button.dart';
import 'package:tools_to_go_app/core/widgets/app_padding.dart';

import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/string_manager.dart';
var _borderTextFiled = ({Color color = ColorManager.primaryColor}) =>
    OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(color: color, width: 1.sp));

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool notificationEnable = false;
  String languageValue = 'العربية';
  String modeValue = 'فاتح';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringManager.settingText),
      ),
      body: AppPaddingWidget(
        horizontalPadding: 12.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
              decoration: BoxDecoration(
                  color: ColorManager.whiteColor,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: ColorManager.hintTextColor)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    StringManager.settingText,
                    style: StyleManager.font24Bold(),
                  ),
                  verticalSpace(20.h),
                  Text(
                    StringManager.languageText,
                    style: StyleManager.font14SemiBold(),
                  ),
                  verticalSpace(10.h),
                  DropdownButtonFormField(
                      icon: Icon(Icons.keyboard_arrow_down),
                      value: languageValue,
                      decoration: InputDecoration(
                        border: _borderTextFiled(),
                        enabledBorder:_borderTextFiled(),
                        focusedBorder: _borderTextFiled(),

                      ),
                      items: [
                        StringManager.arabicText,
                        StringManager.englishText,
                      ]
                          .map(
                            (e) => DropdownMenuItem(
                          child: Text(e),
                          value: e,
                        ),
                      )
                          .toList(),
                      onChanged: (value) {
                        languageValue = value.toString();
                      }),
                  verticalSpace(20.h),
                  Text(
                    StringManager.notificationText,
                    style: StyleManager.font14SemiBold(),
                  ),
                  StatefulBuilder(builder: (context, notificationState) {
                    return CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      title: Text(StringManager.enableNotificationText),
                      value: notificationEnable,
                      onChanged: (value) {
                        notificationState(() {
                          notificationEnable = value!;
                        });
                      },
                    );
                  }),
                  Text(
                    StringManager.modeText,
                    style: StyleManager.font14SemiBold(),
                  ),
                  verticalSpace(10.h),
                  DropdownButtonFormField(
                      icon: Icon(Icons.keyboard_arrow_down),
                      value: modeValue,
                      decoration: InputDecoration(
                        border: _borderTextFiled(),
                        enabledBorder:_borderTextFiled(),
                        focusedBorder: _borderTextFiled(),

                      ),
                      items: [
                        StringManager.darkModeText,
                        StringManager.lightModeText,
                      ]
                          .map(
                            (e) => DropdownMenuItem(
                          child: Text(e),
                          value: e,
                        ),
                      )
                          .toList(),
                      onChanged: (value) {
                        modeValue = value.toString();
                      }),
                  verticalSpace(20.h),
                  AppButton(
                    onPressed: () {},
                    text: StringManager.saveChangesText,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
