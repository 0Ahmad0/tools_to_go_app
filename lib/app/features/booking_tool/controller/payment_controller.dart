import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:tools_to_go_app/core/utils/const_value_manager.dart';

class PaymentController {

  Future<String> createPaymentIntent(int amount) async {
    try {
      final url = Uri.parse("https://api.stripe.com/v1/payment_intents");
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer ${ConstValueManager.skStripe}',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'amount': amount.toString(), // المبلغ بالعملة الأدنى (مثلاً: سنتات للدولار)
          'currency': 'SAR',
          'payment_method_types[]': 'card',
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return responseData['client_secret'];
      } else {
        throw Exception('Failed to create payment intent: ${response.body}');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> initializePaymentSheet(String clientSecret, String cardHolder) async {
    try {
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: cardHolder,
          allowsDelayedPaymentMethods: true,
        ),
      );
    } catch (e) {
      throw Exception('Failed to initialize payment sheet: $e');
    }
  }

  Future<void> processPayment(int amount, String cardHolder) async {
    try {
      // إنشاء طلب دفع
      String clientSecret = await createPaymentIntent(amount);

      // تهيئة واجهة الدفع
      await initializePaymentSheet(clientSecret, cardHolder);

      // عرض واجهة الدفع للمستخدم
      await Stripe.instance.presentPaymentSheet();

      print("Payment completed successfully.");
    } catch (e) {
      if (e is StripeException) {
        print("StripeException: ${e.error.localizedMessage}");
      } else {
        print("Payment failed: $e");
      }
      rethrow;
    }
  }
}