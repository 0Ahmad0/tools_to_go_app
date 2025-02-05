import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tools_to_go_app/core/utils/color_manager.dart';

import '../../core/utils/assets_manager.dart';

class ImageUserProvider extends StatelessWidget {
  const ImageUserProvider(
      {super.key,
      this.url,
      this.height = 80,
      this.width = 80,
      this.fit,
      this.radius,
      this.errorBuilder,
      this.backgroundColor});

  final String? url;
  final double? height;
  final double? width;
  final double? radius;
  final BoxFit? fit;
  final Widget? errorBuilder;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        width: height!.sp,
        height: width!.sp,
        decoration: BoxDecoration(
          color: ColorManager.orangeColor,
          shape: BoxShape.circle
        ),
        child: Image.network(
          url ?? '',

          fit: BoxFit.cover,
          frameBuilder: (context, widget, i, a) => i != null
              ? widget
              : errorBuilder ??
                  Icon(
                    FontAwesomeIcons.userLarge,
                  ),
          // Image.asset(AssetsManager.consultIMG,width: width,height: height,),
          errorBuilder: (context, _, __) =>
              errorBuilder ??
              Icon(
                FontAwesomeIcons.userLarge,
              ),
          // Image.asset(AssetsManager.consultIMG,width: width,height: height,),
        ),
      ),
    );
  }
}
