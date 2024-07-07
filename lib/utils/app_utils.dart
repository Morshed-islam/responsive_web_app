import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../controller/add_doner_controller.dart';

class AppUtils{
  static void showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  static String convertEngToBanglaNumber(String engNumber) {
    const englishDigits = '0123456789';
    const banglaDigits = '০১২৩৪৫৬৭৮৯';

    // First, format the number with commas
    String formattedNumber = formatWithCommas(engNumber);

    // Then, convert each digit to Bengali
    return formattedNumber.split('').map((char) {
      final index = englishDigits.indexOf(char);
      return index != -1 ? banglaDigits[index] : char;
    }).join('');
  }

  static String formatWithCommas(String number) {
    final buffer = StringBuffer();
    int count = 0;

    for (int i = number.length - 1; i >= 0; i--) {
      count++;
      buffer.write(number[i]);
      if (count == 3 && i != 0) {
        buffer.write(',');
        count = 0;
      } else if (count == 2 && i != 0 && buffer.length >= 6) {
        buffer.write(',');
        count = 0;
      }
    }

    return buffer.toString().split('').reversed.join('');
  }
}