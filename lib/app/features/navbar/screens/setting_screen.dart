import 'package:flutter/material.dart';

import '../../../../core/utils/string_manager.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringManager.settingText),
      ),
    );
  }
}
