import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tools_to_go_app/core/utils/color_manager.dart';
import 'package:tools_to_go_app/core/utils/string_manager.dart';
import 'package:tools_to_go_app/core/utils/style_manager.dart';

class PickSourceWidget extends StatelessWidget {
  const PickSourceWidget(
      {super.key, this.onPickCamera, this.onPickGallery, this.onDelete});

  final VoidCallback? onPickCamera;
  final VoidCallback? onPickGallery;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          onTap: onPickCamera,
          dense: true,
          title: Text(StringManager.pick_from_camera_text),
          leading: CircleAvatar(
            backgroundColor: ColorManager.orangeColor.withOpacity(.5),
            child: Icon(Icons.camera_alt_outlined),
          ),
        ),
        Divider(),
        ListTile(
          onTap: onPickGallery,
          dense: true,
          title: Text(StringManager.pick_from_camera_text),
          leading: CircleAvatar(
            backgroundColor: ColorManager.orangeColor.withOpacity(.5),
            child: Icon(Icons.photo_outlined),
          ),
        ),
        Divider(),
        ListTile(
          onTap: onDelete,
          dense: true,
          title: Text(
            StringManager.delete_photo_text,
            style: StyleManager.font14Regular(color: ColorManager.errorColor),
          ),
          leading: CircleAvatar(
            backgroundColor: ColorManager.errorColor,
            child: Icon(
              Icons.delete_outline,
              color: ColorManager.whiteColor,
            ),
          ),
        ),
      ],
    );
  }
}
