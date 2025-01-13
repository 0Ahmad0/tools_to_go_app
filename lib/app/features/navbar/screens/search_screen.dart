import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tools_to_go_app/core/helpers/spacing.dart';
import 'package:tools_to_go_app/core/utils/style_manager.dart';
import 'package:tools_to_go_app/core/widgets/app_padding.dart';
import 'package:tools_to_go_app/core/widgets/app_search_text_filed.dart';

import '../../../../core/models/tool.dart';
import '../../../../core/utils/string_manager.dart';
import '../../../../core/widgets/constants_widgets.dart';
import '../../../../core/widgets/no_data_found_widget.dart';
import '../../owner_tools/home/controller/tools_controller.dart';
import '../../owner_tools/home/controller/tools_filter_controller.dart';
import '../widgets/search_item_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String sortKey = 'الصلة';
  late ToolsFilterController controller;
  void initState() {
    controller = Get.put(ToolsFilterController());
    controller.onInit();
    super.initState();
  }
  _sort(){
    switch(sortKey){
      case "السعر":
        controller.sortByBestFee();
        break;
      case "التقييم":
        controller.sortByBestRate();
        break;
      default:
        controller.sortByDefault();
    }
  }
  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      child: Scaffold(
        appBar: AppBar(
          title: Text(StringManager.searchText),
        ),
        body: AppPaddingWidget(
          horizontalPadding: 12.w,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Text(
                  StringManager.searchResultText,
                  style: StyleManager.font24Bold(),
                ),
              ),
              SliverToBoxAdapter(
                child: verticalSpace(10.h),
              ),
              SliverToBoxAdapter(
                child: AppSearchTextFiled(
                  hintText: StringManager.searchToolsText,
                  onChanged: (value){
                    controller.searchController.text=value??"";
                    controller.filterTools(term: value??"");
                    _sort();
                  },
                ),
              ),
              SliverToBoxAdapter(
                child: verticalSpace(10.h),
              ),
              SliverToBoxAdapter(
                child: Row(
                  children: [
                    Text(StringManager.sortByText),
                    SizedBox(
                      width: 100.w,
                      child: DropdownButton(
                        value: sortKey,
                        isExpanded: true,
                        icon: Icon(Icons.keyboard_arrow_down),
                        items: ['الصلة', 'السعر', 'التقييم']
                            .map((item) => DropdownMenuItem(
                                  child: Center(
                                    child: Text(
                                      item,
                                      style: StyleManager.font12SemiBold(),
                                    ),
                                  ),
                                  value: item,
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            sortKey = value.toString();
                            _sort();
                          });
                        },
                      ),
                    ),
                    const Spacer(),
                    Text(StringManager.filtersText),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: verticalSpace(10.h),
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: controller.getTools,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return   SliverToBoxAdapter(child: ConstantsWidgets.circularProgress(),) ;
                    } else if (snapshot.connectionState ==
                        ConnectionState.active) {
                      if (snapshot.hasError) {
                        return  SliverToBoxAdapter(child: Text('Error'));
                      } else if (snapshot.hasData) {
                        controller.tools.items.clear();
                        if (snapshot.data!.docs.length > 0) {

                          controller.tools.items =
                              Tools.fromJson(snapshot.data?.docs).items;
                        }
                        controller.filterTools(term: controller.searchController.value.text);
                        _sort();
                        return
                          GetBuilder<ToolsFilterController>(
                              builder: (ToolsFilterController toolsController)=>

                              (toolsController.toolsWithFilter.items.isEmpty ?? true)
                                  ?
                              SliverFillRemaining(child: Center(child: NoDataFoundWidget(text: StringManager.noToolsText)))
                                  :
                              buildTools(context, toolsController.toolsWithFilter.items));
                      } else {
                        return SliverToBoxAdapter(child: const Text('Empty data'));
                      }
                    } else {
                      return SliverToBoxAdapter(child: Text('State: ${snapshot.connectionState}'));
                    }
                  })

            ],
          ),
        ),
      ),
    );
  }
  Widget buildTools(BuildContext context,List<ToolModel> items){
    return
      SliverList.separated(
          itemBuilder: (context, index) =>
              SearchItemWidget(index: 1+index, tool:items[index]),
          separatorBuilder: (_, __) => verticalSpace(10.h),
          itemCount: items.length
      );
  }

}
