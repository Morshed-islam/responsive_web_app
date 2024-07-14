import 'dart:developer';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_web_app/controller/user_list_controller.dart';
import 'package:responsive_web_app/model/collect_amount_model.dart';
import 'package:responsive_web_app/model/mixer_add_money_model.dart';

import '../controller/add_doner_controller.dart';
import '../controller/collect_money_controller.dart';
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

  static void showAddMoneyDialog(BuildContext context, Doner user, UserListController controller,CollectMoneyController collectMoneyController) {
    final _formKey = GlobalKey<FormState>();
    final _collectAmountEd = TextEditingController();
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
                  controller: _collectAmountEd,
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
              onPressed: () async{
                if (_formKey.currentState!.validate()) {
                  if (int.parse(user.payableAmount) < int.parse(_collectAmountEd.text)) {
                    showCustomMessage(context, "জমার টাকার পরিমাণ লিখুন!");
                    return;
                  } else {
                    log("oke");

                    int calculatePayableAmount = int.parse(user.payableAmount) - int.parse(_collectAmountEd.text);
                    log("calculatePayableAmount $calculatePayableAmount");

                    var modelData = MixerAddMoneyModel(
                      donorId: user.id,
                      collectAmount: int.parse(_collectAmountEd.text),
                      totalPayableAmount: calculatePayableAmount,
                      totalAmount: int.parse(user.totalDonorAmount),
                      previousSubmittedAmount: int.parse(user.totalSubmittedAmount),
                      collectModel: CollectAmountModel(
                        id: user.id,
                        name: user.name,
                        collectAmount: _collectAmountEd.text,
                        createdAt: DateTime.now().toString(),
                        addedBy: "admin",
                      ),
                    );

                    var collectionModel = CollectAmountModel(
                      id: user.id,
                      name: user.name,
                      collectAmount: _collectAmountEd.text,
                      createdAt: DateTime.now().toString(),
                      addedBy: "admin",
                    );

                    int payableAmount = int.parse(_collectAmountEd.text)+int.parse(user.totalSubmittedAmount);
                    int updatedCollectAmount = int.parse(user.totalSubmittedAmount)+int.parse(_collectAmountEd.text);

                    // collectMoneyController.collectAmountAllMethod(modelData,updatedCollectAmount);


                    log("model data ${modelData} ${modelData.collectModel.toMap()}");

                    collectMoneyController.onlyCollectAmountsRecord(collectionModel, collectionModel.id, 50);
                    collectMoneyController.allCollectedAmountNestedCollectionRecord(modelData.collectModel, modelData.donorId);

                    if(collectMoneyController.isLoading == false && collectMoneyController.isSuccess){
                      // controller.updateDonorListPayableAmount(paidAmount: payableAmount.toString(), donorId: user.id);
                      showCustomMessage(context, "জাযাকাল্লাহ!টাকা জমা সম্পূর্ণ হয়েছে!");

                    }else{
                      showCustomMessage(context, "দু:খিত আবার চেষ্টা করুণ!");
                    }

                  }
                  Navigator.of(context).pop();


                  // Perform submit action
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

  static Future<bool> isInternetAvailable() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.mobile) || connectivityResult.contains(ConnectivityResult.wifi)) {
      try {
        final result = await InternetAddress.lookup('example.com');
        return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
      } on SocketException catch (_) {
        return false;
      }
    } else {
      return false;
    }
  }
}
