import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tools_to_go_app/app/features/auth/controller/auth_controller.dart';
import 'package:tools_to_go_app/app/features/navbar/widgets/chat_item_widget.dart';
import 'package:tools_to_go_app/app/features/owner_tools/home/widgets/owner_home_tool_widget.dart';
import 'package:tools_to_go_app/core/helpers/extensions.dart';
import 'package:tools_to_go_app/core/helpers/spacing.dart';
import 'package:tools_to_go_app/core/routing/routes.dart';
import 'package:tools_to_go_app/core/utils/color_manager.dart';
import 'package:tools_to_go_app/core/utils/string_manager.dart';
import 'package:tools_to_go_app/core/utils/style_manager.dart';
import 'package:tools_to_go_app/core/widgets/app_padding.dart';

class OwnerHomeScreen extends StatelessWidget {
  const OwnerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringManager.homeText),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              margin: EdgeInsets.zero,
              decoration: BoxDecoration(
                color: ColorManager.orangeColor,
              ),
              accountName: Text(
                'ياسر',
                style: StyleManager.font14SemiBold(),
              ),
              accountEmail: Text(
                'email@gmail.com',
                style: StyleManager.font12SemiBold(),
              ),
              currentAccountPicture: CircleAvatar(
                child: Icon(FontAwesomeIcons.userLarge),
              ),
            ),
            ListTile(
              dense: true,
              onTap: () {},
              leading: Icon(
                Icons.person,
              ),
              title: Text(
                StringManager.profileText,
                style: StyleManager.font14SemiBold(),
              ),
            ),
            Divider(
              height: 0,
            ),
            ListTile(
              dense: true,
              onTap: () {
                context.pop();
                context.pushNamed(Routes.ownerToolsRequestsRoute);
              },
              leading: Icon(Icons.shopping_cart),
              title: Text(
                StringManager.requestsText,
                style: StyleManager.font14SemiBold(),
              ),
            ),
            Divider(
              height: 0,
            ),
            ListTile(
              dense: true,
              onTap: () {
                context.pop();
              },
              leading: Icon(Icons.notifications),
              title: Text(
                StringManager.notificationText,
                style: StyleManager.font14SemiBold(),
              ),
            ),
            const Spacer(),
            ListTile(
              dense: true,
              onTap: () {},
              leading: Icon(Icons.logout),
              title: Text(
                StringManager.signOutText,
                style: StyleManager.font14SemiBold(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.pushNamed(Routes.ownerAddToolRoute);
        },
        label: Text(StringManager.addNewToolsText),
        icon: Icon(
          Icons.add,
        ),
      ),
      body: AppPaddingWidget(
        child: ListView.separated(
          padding: EdgeInsets.only(
            bottom: 70.h
          ),
            itemBuilder: (context,index)=>OwnerHomeToolWidget(),
            separatorBuilder: (_,__)=>verticalSpace(20.h),
            itemCount: 13
        ),
      ),
    );
  }
}
