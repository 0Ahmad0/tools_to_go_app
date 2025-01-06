import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tools_to_go_app/core/helpers/spacing.dart';
import 'package:tools_to_go_app/core/utils/style_manager.dart';
import 'package:tools_to_go_app/core/widgets/app_padding.dart';
import 'package:tools_to_go_app/core/widgets/app_search_text_filed.dart';

import '../../../../core/utils/string_manager.dart';
import '../widgets/search_item_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String sortKey = 'الصلة';

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
              SliverList.separated(
                  itemBuilder: (context, index) =>
                      SearchItemWidget(index: ++index),
                  separatorBuilder: (_, __) => verticalSpace(10.h))
            ],
          ),
        ),
      ),
    );
  }
}
