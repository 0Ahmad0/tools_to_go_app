import 'package:flutter/material.dart';

import '../../../../core/utils/string_manager.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringManager.chatScreenText),
      ),
    );
  }
}
