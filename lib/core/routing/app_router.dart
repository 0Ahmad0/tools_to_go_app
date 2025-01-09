import 'package:flutter/material.dart';
import 'package:tools_to_go_app/app/features/notification/screens/notification_screen.dart';
import 'package:tools_to_go_app/app/features/order_taker/home/screens/order_taker_home_screen.dart';
import 'package:tools_to_go_app/app/features/owner_tools/add_tool/screens/owner_add_tool_screen.dart';
import 'package:tools_to_go_app/app/features/owner_tools/home/screens/owner_home_screen.dart';
import 'package:tools_to_go_app/app/features/owner_tools/tools_requests/screens/owner_tools_requestes_screen.dart';
import 'package:tools_to_go_app/app/features/profile/screens/profile_screen.dart';
import 'package:tools_to_go_app/app/features/tool_details/screen/tool_details_screen.dart';

import '../../app/features/auth/screens/auth_screen.dart';
import '../../app/features/auth/screens/check_inbox_screen.dart';
import '../../app/features/auth/screens/forgot_password_screen.dart';
import '../../app/features/booking_tool/screens/booking_tool_screen.dart';
import '../../app/features/messages/screens/messages_screen.dart';
import '../../app/features/navbar/screens/navbar_screen.dart';
import '../../app/features/order_taker/show_location_on_map/screens/show_location_on_map_screen.dart';
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
      case Routes.bookingToolRoute:
        return MaterialPageRoute(
          builder: (_) => BookingToolScreen(),
        );
      case Routes.notificationRoute:
        return MaterialPageRoute(
          builder: (_) => NotificationScreen(),
        );
        case Routes.profileRoute:
        return MaterialPageRoute(
          builder: (_) => ProfileScreen(),
        );

      ///Owner
      case Routes.ownerHomeRoute:
        return MaterialPageRoute(
          builder: (_) => OwnerHomeScreen(),
        );

      case Routes.ownerAddToolRoute:
        return MaterialPageRoute(
          builder: (_) => OwnerAddToolScreen(),
        );

      case Routes.ownerToolsRequestsRoute:
        return MaterialPageRoute(
          builder: (_) => OwnerToolsRequestsScreen(),
        );

      ///Order Taker
      case Routes.orderTakerHomeRoute:
        return MaterialPageRoute(
          builder: (_) => OrderTakerHomeScreen(),
        );
      case Routes.showLocationOnMapRoute:
        return MaterialPageRoute(
          builder: (_) => ShowLocationOnMapScreen(),
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
