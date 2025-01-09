import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tools_to_go_app/app/features/auth/controller/auth_controller.dart';
import 'package:tools_to_go_app/app/features/profile/widgets/pick_source_widget.dart';
import 'package:tools_to_go_app/core/helpers/extensions.dart';
import 'package:tools_to_go_app/core/helpers/spacing.dart';
import 'package:tools_to_go_app/core/utils/color_manager.dart';
import 'package:tools_to_go_app/core/utils/string_manager.dart';
import 'package:tools_to_go_app/core/utils/style_manager.dart';
import 'package:tools_to_go_app/core/widgets/app_button.dart';
import 'package:tools_to_go_app/core/widgets/app_padding.dart';
import 'package:tools_to_go_app/core/widgets/app_textfield.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _paypalEmailController = TextEditingController();

  String _selectedPaymentMethod = 'Visa'; // طريقة الدفع الافتراضية
  bool _showPaymentDetails = false; // للتحكم في إظهار معلومات البطاقة
  bool _showPaypalEmail = false; // للتحكم في إظهار حقل PayPal

  final List<String> paymentMethods = ['Visa', 'Mada', 'MasterCard', 'PayPal'];

  void _saveChanges() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text(StringManager.profileUpdateSuccessFullText)),
    );
  }

  final ImagePicker picker = ImagePicker();
  File? userImage;

  Future _pickPhoto({required ImageSource source}) async {
    context.pop();
    final result = await picker.pickImage(source: source);
    if (result != null) {
      setState(() {
        userImage = File(result.path);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('الرجاء اختيار صورة!!')),
      );
    }
  }

  _deletePhoto() {
    if (userImage != null) {
      userImage = null;
      setState(() {});
    }
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringManager.profileText),
      ),
      body: AppPaddingWidget(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    clipBehavior: Clip.hardEdge,
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(100.r),
                        onTap: () {
                          showModalBottomSheet(
                            showDragHandle: true,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(14.r))),
                            context: context,
                            builder: (context) => PickSourceWidget(
                              onPickCamera: () =>
                                  _pickPhoto(source: ImageSource.camera),
                              onPickGallery: () =>
                                  _pickPhoto(source: ImageSource.gallery),
                              onDelete: _deletePhoto,
                            ),
                          );
                        },
                        child: CircleAvatar(
                          radius: 40.sp,
                          backgroundColor: ColorManager.orangeColor,
                          child: userImage == null
                              ? Icon(Icons.person,
                                  color: ColorManager.primaryColor)
                              : ClipRRect(
                                  clipBehavior: Clip.antiAlias,
                                  borderRadius: BorderRadius.circular(100.r),
                                  child: Image.file(
                                    File(
                                      userImage!.path,
                                    ),
                                    fit: BoxFit.cover,
                                    width: 80.sp,
                                    height: 80.sp,
                                  ),
                                ),
                        ),
                      ),
                      ClipOval(
                        child: Container(
                          width: 80.sp,
                          height: 20.h,
                          decoration: BoxDecoration(
                              color: ColorManager.whiteColor.withOpacity(.75)),
                          child: Icon(
                            Icons.add_photo_alternate,
                            size: 16.sp,
                            color: ColorManager.primaryColor,
                          ),
                        ),
                      )
                    ],
                  ),
                  Flexible(
                    child: ListTile(
                      title: Text(
                        'ياسر المالكي',
                        style: StyleManager.font16SemiBold(),
                      ),
                      subtitle: Text('example@gmail.com'),
                    ),
                  ),
                ],
              ),
              verticalSpace(20.h),
              Text(
                StringManager.nameText,
                style: StyleManager.font14SemiBold(),
              ),
              verticalSpace(10.h),
              AppTextField(
                controller: _nameController,
                hintText: StringManager.enterNameHintText,
              ),
              verticalSpace(20.h),
              Text(
                StringManager.emailText,
                style: StyleManager.font14SemiBold(),
              ),
              verticalSpace(10.h),
              AppTextField(
                controller: _emailController,
                hintText: StringManager.enterEmailHintText,
              ),

              // const Text(
              //   'Add Payment Method',
              //   style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              // ),
              // const SizedBox(height: 8),
              // DropdownButtonFormField<String>(
              //   value: _selectedPaymentMethod,
              //   decoration: InputDecoration(
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //     filled: true,
              //     fillColor: Colors.grey[100],
              //   ),
              //   items: paymentMethods
              //       .map((method) => DropdownMenuItem<String>(
              //             value: method,
              //             child: Text(method),
              //           ))
              //       .toList(),
              //   onChanged: (value) {
              //     setState(() {
              //       _selectedPaymentMethod = value!;
              //       _showPaymentDetails =
              //           value == 'Visa' || value == 'MasterCard';
              //       _showPaypalEmail = value == 'PayPal';
              //     });
              //   },
              // ),
              // const SizedBox(height: 20),
              // if (_showPaymentDetails) ...[
              //   buildEditableField(
              //     label: 'Card Number',
              //     controller: _cardNumberController,
              //     hint: 'Enter your card number',
              //     keyboardType: TextInputType.number,
              //   ),
              //   const SizedBox(height: 10),
              //   buildEditableField(
              //     label: 'Expiry Date',
              //     controller: _expiryDateController,
              //     hint: 'MM/YY',
              //     keyboardType: TextInputType.datetime,
              //   ),
              //   const SizedBox(height: 10),
              //   buildEditableField(
              //     label: 'CVV',
              //     controller: _cvvController,
              //     hint: 'Enter CVV',
              //     keyboardType: TextInputType.number,
              //   ),
              // ],
              // // حقل PayPal
              // if (_showPaypalEmail) ...[
              //   buildEditableField(
              //     label: 'PayPal Email',
              //     controller: _paypalEmailController,
              //     hint: 'Enter your PayPal email',
              //     keyboardType: TextInputType.emailAddress,
              //   ),
              // ],
              // const SizedBox(height: 20),
              verticalSpace(30.h),
              AppButton(
                onPressed: _saveChanges,
                text: StringManager.saveChangesText,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
