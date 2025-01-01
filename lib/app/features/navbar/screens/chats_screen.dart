import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tools_to_go_app/app/features/auth/controller/auth_controller.dart';
import 'package:tools_to_go_app/core/helpers/extensions.dart';
import 'package:tools_to_go_app/core/routing/routes.dart';
import 'package:tools_to_go_app/core/utils/style_manager.dart';

import '../../../../core/utils/string_manager.dart';
import '../../../../core/widgets/app_padding.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringManager.chatScreenText),
      ),
      body: AppPaddingWidget(
        horizontalPadding: 12.w,
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                onTap: (){
                  context.pushNamed(Routes.messagesRoute);
                },
                contentPadding: EdgeInsets.zero,
                dense: true,
                leading: CircleAvatar(),
                title: Text(
                  'البائع',
                  style: StyleManager.font14SemiBold(),
                ),
                subtitle: Text(
                  'آخر رسالة...',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: StyleManager.font12Regular(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
