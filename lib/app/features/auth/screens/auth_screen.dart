import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tools_to_go_app/core/utils/color_manager.dart';
import 'package:tools_to_go_app/core/utils/string_manager.dart';

import '../widgets/login_screen_widget.dart';
import '../widgets/signup_screen_widget.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(StringManager.accountText),
          bottom: TabBar(
            tabs: [
              Tab(
                text: StringManager.loginText,
              ),
              Tab(
                text: StringManager.signUpText,
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            LoginScreenWidget(),
            SignupScreenWidget(),
          ],
        ),
      ),
    );
  }
}
