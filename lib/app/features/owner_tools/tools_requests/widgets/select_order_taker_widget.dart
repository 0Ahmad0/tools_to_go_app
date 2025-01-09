import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tools_to_go_app/app/features/owner_tools/tools_requests/widgets/order_taker_item_widget.dart';

class SelectOrderTakerWidget extends StatelessWidget {
  const SelectOrderTakerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            8,
            (index) => OrderTakerItemWidget(index: ++index,),
          ),
        ),
      ),
    );
  }
}
