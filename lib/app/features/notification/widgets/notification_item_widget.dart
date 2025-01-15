import 'package:flutter/material.dart';
import 'package:tools_to_go_app/core/models/notification_model.dart';
import 'package:tools_to_go_app/core/utils/color_manager.dart';
import 'package:tools_to_go_app/core/utils/style_manager.dart';

class NotificationItemWidget extends StatelessWidget {
  const NotificationItemWidget({super.key, this.item});
  final NotificationModel? item;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      leading: CircleAvatar(
        backgroundColor: ColorManager.orangeColor,
        child: Icon(
          Icons.notifications,
          // color: ColorManager.whiteColor,
        ),
      ),
      title: Text(
        item?.title??
        'عنوان الإشعار',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: StyleManager.font14SemiBold(),
      ),
      subtitle: Text(
        item?.subtitle??
        'هذا النص يمكن استبداله بنص آخر عندما يكون التطبيق جاهزا!!',
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
