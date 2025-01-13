import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tools_to_go_app/app/features/owner_tools/add_tool/controller/tool_controller.dart';
import 'package:tools_to_go_app/core/helpers/spacing.dart';
import 'package:tools_to_go_app/core/utils/string_manager.dart';
import 'package:tools_to_go_app/core/utils/style_manager.dart';
import 'package:tools_to_go_app/core/widgets/app_padding.dart';
import 'package:tools_to_go_app/core/widgets/app_textfield.dart';

import '../../../../../core/utils/color_manager.dart';
import '../../../../../core/widgets/app_button.dart';
import '../../../../../core/widgets/image_tool.dart';

class AddToolModel {
  final String imageTool;
  final String nameTool;
  final String priceTool;
  final String descriptionTool;

  AddToolModel(
      {required this.imageTool,
      required this.nameTool,
      required this.priceTool,
      required this.descriptionTool});
}

class OwnerAddToolScreen extends StatefulWidget {
  const OwnerAddToolScreen({super.key});

  @override
  State<OwnerAddToolScreen> createState() => _OwnerAddToolScreenState();
}

class _OwnerAddToolScreenState extends State<OwnerAddToolScreen> {
  final _formKey = GlobalKey<FormState>();
  File? _selectedToolImage;
  final ImagePicker _picker = ImagePicker();

   TextEditingController _nameToolController = TextEditingController();
   TextEditingController _priceToolController = TextEditingController();
   TextEditingController _descriptionToolController = TextEditingController();
   TextEditingController _specificationsToolController = TextEditingController();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedToolImage = File(pickedFile.path);
        controller.tool?.photoUrl=null;
      });
    }
  }

  List<File?> _files = [];

  late ToolController controller;
  @override
  void initState() {
    controller = Get.put(ToolController());
    controller.onInit();
    controller.tool=null;
    super.initState();
  }

  _pickMultipleFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.any,
    );

    if (result != null) {
      _files = result.paths.map((path) => File(path!)).toList();
      controller.tool?.images?.clear();
      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please select atleast 1 file'),
      ));
    }
  }

  void _addProduct(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      if (_selectedToolImage == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('الرجاء اختيار صورة للمنتج')),
        );
        return;
      }
      controller.addTool(context,
      name: _nameToolController.text,
      description:_descriptionToolController.text ,
          specifications:_specificationsToolController.text ,
      image:_selectedToolImage ,
      fee: num.tryParse(_priceToolController.text),
      images: _files);
      // final newProduct = AddToolModel(
      //     imageTool: _selectedToolImage!.path,
      //     nameTool: _nameToolController.text,
      //     priceTool: _priceToolController.text,
      //     descriptionTool: _descriptionToolController.text);
      // Navigator.pop(context, newProduct);
    }
  }
  void _updateProduct(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      if (_selectedToolImage == null&&controller.tool?.photoUrl==null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('الرجاء اختيار صورة للمنتج')),
        );
        return;
      }
      controller.updateTool(context,
          name: _nameToolController.text,
          description:_descriptionToolController.text ,
          specifications:_specificationsToolController.text ,
          image:_selectedToolImage ,
          fee: num.tryParse(_priceToolController.text),
          images: _files);
    }
  }
  bool isInit=false;
  _init(){
    if(isInit)
      return;
   isInit=true;
    _nameToolController=TextEditingController(text:controller.tool?.name );
    _descriptionToolController=TextEditingController(text:controller.tool?.description );
    _specificationsToolController=TextEditingController(text:controller.tool?.specifications );
    _priceToolController=TextEditingController(text:"${controller.tool?.fee ??''}");
  }

  @override
  Widget build(BuildContext context) {
    final args =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    controller.tool=args?["tool"];
    _init();
    return FadeInUp(
      child: Scaffold(
        appBar: AppBar(
          title: Text(controller.tool==null?StringManager.addNewToolsText:StringManager.updateToolsText),
        ),
        body: AppPaddingWidget(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child:
                      controller.tool?.photoUrl?.isNotEmpty??false?
                      ImageTool(
                        url:   controller.tool?.photoUrl,
                          fit: BoxFit.cover,

                      )
                          :
                      _selectedToolImage == null
                          ? Center(child: Text(StringManager.imageProductText))
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(_selectedToolImage!,
                                  fit: BoxFit.cover),
                            ),
                    ),
                  ),
                  verticalSpace(20.h),
                  Text(
                    StringManager.nameProductText,
                    style: StyleManager.font14SemiBold(),
                  ),
                  verticalSpace(10.h),
                  AppTextField(
                    controller: _nameToolController,
                    hintText: StringManager.nameProductHintText,
                    validator: (value) =>
                        value!.trim().isEmpty ? 'الرجاء إدخال اسم صحيح' : null,
                  ),
                  verticalSpace(20.h),
                  Text(
                    StringManager.priceProductText,
                    style: StyleManager.font14SemiBold(),
                  ),
                  verticalSpace(10.h),
                  AppTextField(
                    controller: _priceToolController,
                    keyboardType: TextInputType.number,
                    hintText: StringManager.priceProductHintText,
                    validator: (value) =>
                        value!.trim().isEmpty ? 'الرجاء إدخال سعر صحيح' : null,
                  ),
                  verticalSpace(20.h),
                  Text(
                    StringManager.specificationsProductText,
                    style: StyleManager.font14SemiBold(),
                  ),
                  verticalSpace(10.h),
                  AppTextField(
                    controller: _specificationsToolController,
                    hintText: StringManager.specificationsProductHintText,
                    minLine: 2,
                    maxLine: 6,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    validator: (value) =>
                    value!.isEmpty ? 'الرجاء إدخال مواصفات صحيحة' : null,
                  ),
                  verticalSpace(20.h),
                  Text(
                    StringManager.descriptionProductText,
                    style: StyleManager.font14SemiBold(),
                  ),
                  verticalSpace(10.h),
                  AppTextField(
                    controller: _descriptionToolController,
                    hintText: StringManager.descriptionProductHintText,
                    minLine: 2,
                    maxLine: 6,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    validator: (value) =>
                        value!.isEmpty ? 'الرجاء إدخال وصف صحيح' : null,
                  ),
                  verticalSpace(20.h),
                  Text(
                    StringManager.attachFilesText,
                    style: StyleManager.font14SemiBold(),
                  ),
                  verticalSpace(10.h),
                  InkWell(
                    borderRadius: BorderRadius.circular(12.r),
                    onTap: () {
                      _pickMultipleFile();
                    },
                    child: Container(
                      padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
                      decoration: BoxDecoration(
                        color: ColorManager.whiteColor,
                        border: Border.all(
                          color: ColorManager.primaryColor
                        ),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        children: [
                          Text(
                            StringManager.attachFilesHintText,
                            style: StyleManager.font14Regular(
                              color: ColorManager.hintTextColor,
                            ),
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              Visibility(
                                  visible: _files.isNotEmpty||( controller.tool?.images?.isNotEmpty??false),
                                  child: Text(
                                    '${(controller.tool?.images?.length??0)>0?
                                    controller.tool?.images?.length
                                        :_files.length} صورة ',
                                    style: StyleManager.font12Regular(
                                        color: ColorManager.blueColor
                                    ),
                                  )),
                              horizontalSpace(4.w),
                              Icon(
                                Icons.attach_file,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),

                  verticalSpace(20.h),
                  controller.tool==null?
                  AppButton(
                    onPressed: () => _addProduct(context),
                    text: StringManager.addNewProductText,
                  ):AppButton(
                    onPressed: () => _updateProduct(context),
                    text: StringManager.saveNewProductText,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
