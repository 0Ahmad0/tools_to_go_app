import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tools_to_go_app/core/helpers/spacing.dart';
import 'package:tools_to_go_app/core/utils/string_manager.dart';
import 'package:tools_to_go_app/core/utils/style_manager.dart';
import 'package:tools_to_go_app/core/widgets/app_padding.dart';
import 'package:tools_to_go_app/core/widgets/app_textfield.dart';

import '../../../../../core/widgets/app_button.dart';

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

  final TextEditingController _nameToolController = TextEditingController();
  final TextEditingController _priceToolController = TextEditingController();
  final TextEditingController _descriptionToolController = TextEditingController();


  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedToolImage = File(pickedFile.path);
      });
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

      final newProduct = AddToolModel(
        imageTool: _selectedToolImage!.path,
        nameTool: _nameToolController.text,
        priceTool: _priceToolController.text,
        descriptionTool: _descriptionToolController.text
      );
      Navigator.pop(context, newProduct);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Asset'),
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
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: _selectedToolImage == null
                        ? Center(child: Text('Pick Picture'))
                        : Image.file(_selectedToolImage!, fit: BoxFit.cover),
                  ),
                ),
                verticalSpace(20.h),
                AppTextField(
                  controller: _nameToolController,
                  hintText: 'Name',
                  validator: (value) =>
                      value!.trim().isEmpty ? 'Please Enter Valid Name' : null,
                ),
                verticalSpace(20.h),
                AppTextField(
                  controller: _priceToolController,
                  hintText: 'Price',
                  validator: (value) =>
                      value!.trim().isEmpty ? 'Please Enter Valid Price' : null,
                ),
                verticalSpace(20.h),
                AppTextField(
                  controller: _descriptionToolController,
                  hintText: 'Description',
                  validator: (value) =>
                      value!.isEmpty ? 'Please Enter Valid Description' : null,
                ),
                verticalSpace(20.h),
                AppButton(
                  onPressed: () => _addProduct(context),
                  text: 'Add New Asset',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
