import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                  CircleAvatar(
                    radius: 40.sp,
                    backgroundColor: ColorManager.orangeColor,
                    child:
                        const Icon(Icons.person, size: 40, color: Colors.grey),
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
