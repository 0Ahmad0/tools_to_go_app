import 'package:flutter/material.dart';
import 'package:tools_to_go_app/app/features/tool_details/screen/tool_details_screen.dart';

import '../../app/features/auth/screens/auth_screen.dart';
import '../../app/features/auth/screens/check_inbox_screen.dart';
import '../../app/features/auth/screens/forgot_password_screen.dart';
import '../../app/features/messages/screens/messages_screen.dart';
import '../../app/features/navbar/screens/navbar_screen.dart';
import '../../app/features/splash/splash_screen.dart';
import 'routes.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(
          builder: (_) => SplashScreen(),
        );

      case Routes.loginRoute:
        return MaterialPageRoute(
          builder: (_) => AuthScreen(),
        );
      case Routes.forgotPasswordRoute:
        return MaterialPageRoute(
          builder: (_) => ForgotPasswordScreen(),
        );
      case Routes.checkYourInboxRoute:
        return MaterialPageRoute(
          builder: (_) => CheckInboxScreen(),
        );

      /// Nav Bar Screens
      case Routes.navbarRoute:
        return MaterialPageRoute(
          builder: (_) => NavbarScreen(),
        );
      case Routes.messagesRoute:
        return MaterialPageRoute(
          builder: (_) => MessagesScreen(),
        );
        case Routes.toolDetailsRoute:
        return MaterialPageRoute(
          builder: (_) => ToolDetailsScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('NO DATA'),
            ),
          ),
        );
    }
  }
}
