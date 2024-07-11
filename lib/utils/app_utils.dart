import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_web_app/controller/user_list_controller.dart';

import '../controller/add_doner_controller.dart';
import '../model/doner_model.dart';

class AppUtils {
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

  static void showAddMoneyDialog(BuildContext context, Doner user,UserListController controller) {
    final _formKey = GlobalKey<FormState>();
    final _textFieldController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('টাকা জমা নিন'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('নাম: ${user.name}'),
                Text('গ্রাম: ${user.village}'),
                Text('মোবাইল নং: ${user.phone}'),
                 Text(
                  'বকেয়ার পরিমাণ: ${user.payableAmount}',
                  style: const TextStyle(color: Colors.red),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _textFieldController,
                  decoration: const InputDecoration(
                    labelText: 'জমার পরিমাণ',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('কেটে দিন'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('জমা দিন'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  if (int.parse(user.payableAmount) < int.parse(_textFieldController.text)) {
                    showCustomMessage(context, "Please input below payable amount");
                    return;
                  } else {
                    log("oke");


                    int calculatePayableAmount = int.parse(user.payableAmount) - int.parse(_textFieldController.text);

                    controller.updateDonorListData(id: user.id,paidAmount: calculatePayableAmount.toString());

                  }

                  // Perform submit action
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  static void showCustomMessage(BuildContext context, message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}
