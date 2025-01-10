import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:tools_to_go_app/app/features/notification/widgets/notification_item_widget.dart';
import 'package:tools_to_go_app/core/utils/string_manager.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      child: Scaffold(
        appBar: AppBar(
          title: Text(StringManager.notificationText),
        ),
        body: ListView.separated(
            itemBuilder: (context, index) => NotificationItemWidget(),
            separatorBuilder: (_, __) => Divider(),
            itemCount: 23),
      ),
    );
  }
}
