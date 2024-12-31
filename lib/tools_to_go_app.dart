import '/app/features/auth/screens/login_screen.dart';
import '/app/features/auth/screens/sign_up_screen.dart';
import '/app/features/navbar/screens/navbar_screen.dart';
import '/app/features/splash/splash_screen.dart';
import '/core/helpers/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/routing/app_router.dart';
import 'core/routing/routes.dart';
import 'core/utils/color_manager.dart';
import 'core/utils/const_value_manager.dart';
import 'core/utils/string_manager.dart';
import 'core/utils/style_manager.dart';

class ToolsToGoApp extends StatelessWidget {
  const ToolsToGoApp({super.key, required this.appRouter});

  final AppRouter appRouter;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        minTextAdapt: true,
        designSize: const Size(
          ConstValueManager.widthSize,
          ConstValueManager.heightSize,
        ),
        builder: (context, child) {
          return GetMaterialApp(
            locale: Locale('ar'),
            debugShowCheckedModeBanner: false,
            title: StringManager.appName,
            theme: ThemeData(
              dividerColor: ColorManager.hintTextColor,
              primaryColor: ColorManager.primaryColor,
              primarySwatch: ColorManager.primaryColor.toMaterialColor(),
              colorScheme: ColorScheme.fromSeed(
                seedColor: ColorManager.primaryColor,
              ),
              appBarTheme: AppBarTheme(
                centerTitle: true,
                titleTextStyle: StyleManager.font18Medium(),
                backgroundColor: ColorManager.whiteColor,
                shadowColor: ColorManager.whiteColor,
                surfaceTintColor: ColorManager.whiteColor,
                elevation: 1.0,
              ),
              tabBarTheme: TabBarTheme(
                labelColor: ColorManager.whiteColor,
                indicatorSize: TabBarIndicatorSize.tab,
                overlayColor: MaterialStateProperty.all(
                    ColorManager.primaryColor.withOpacity(.1)),
                unselectedLabelColor: ColorManager.primaryColor,
                indicator: BoxDecoration(
                    color: ColorManager.primaryColor,
                    borderRadius: BorderRadius.circular(8.r)),
              ),
              inputDecorationTheme: InputDecorationTheme(

                contentPadding:
                    EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
                suffixIconColor: ColorManager.primaryColor,
              ),
              scaffoldBackgroundColor: ColorManager.whiteColor,
              fontFamily: GoogleFonts.poppins().fontFamily,
              outlinedButtonTheme: OutlinedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(
                    double.maxFinite,
                    ConstValueManager.heightButtonSize,
                  ),
                ),
              ),
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                  backgroundColor: ColorManager.grayColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.r),
                  )),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r)
                  ),
                  minimumSize: Size(
                    double.maxFinite,
                    ConstValueManager.heightButtonSize,
                  ),
                ),
              ),
            ),
            // home: NavbarScreen(),
            initialRoute: Routes.initialRoute,
            onGenerateRoute: appRouter.generateRoute,
            routes: {},
          );
        });
  }
}