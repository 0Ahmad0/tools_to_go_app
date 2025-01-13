import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../core/utils/assets_manager.dart';
class ImageTool extends StatelessWidget {
  const ImageTool({super.key, this.url, this.height, this.width, this.fit, this.radius, this.errorBuilder, this.backgroundColor});
  final String? url;
  final double? height;
  final double? width;
  final double? radius;
  final BoxFit? fit;
  final Widget? errorBuilder;
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    return

    ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.network(
        url??'',fit:fit,// BoxFit.fitHeight,
        height: height,
        width: width,
        frameBuilder:(context,widget,i,a)=>i!=null?widget:
        errorBuilder??
            // Icon(FontAwesomeIcons.userLarge),
        Image.asset(AssetsManager.completeOrdersIcon,width: width,height: height,),
        errorBuilder:(context,_,__)=>
            errorBuilder??
                // Icon(FontAwesomeIcons.userLarge),
        Image.asset(AssetsManager.completeOrdersIcon,width: width,height: height,),
      ),
    );
  }
}
