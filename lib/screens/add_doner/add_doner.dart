import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_web_app/controller/add_doner_controller.dart';
import 'package:responsive_web_app/model/doner_model.dart';
import 'package:responsive_web_app/utils/app_utils.dart';
import 'package:responsive_web_app/utils/device_screen_type.dart';

class AddDonerProfile extends StatefulWidget {
  const AddDonerProfile({super.key});

  @override
  State<AddDonerProfile> createState() => _AddDonerProfileState();
}

class _AddDonerProfileState extends State<AddDonerProfile> {
  final _formKey = GlobalKey<FormState>();
  String _fullName = '';
  String _villageName = '';
  String _advancedAmount = '0';
  String _radioValue = 'Money';
  String _totalAmount = '0';

  // String _bags = '';

  @override
  Widget build(BuildContext context) {
    var controller = context.read<AddDonerController>();

    return Scaffold(
      body: Padding(
        padding: DeviceScreenType.isWeb(context) || DeviceScreenType.isTablet(context) ? const EdgeInsets.all(60.0) : const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'দাতার নাম',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    _fullName = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'ডাতার নাম লিখুন!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'গ্রামের নাম/ঝালখুর হইলে লেখার দরকার নেই!',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    if (value.isEmpty) {
                      _villageName = "ঝালখুর";
                    } else {
                      _villageName = value;
                    }
                  });
                },

              ),

              const SizedBox(height: 16),
              Row(
                children: <Widget>[
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('টাকা'),
                      value: 'Money',
                      groupValue: _radioValue,
                      onChanged: (value) {
                        setState(() {
                          _radioValue = value!;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('সিমেন্ট/অন্যান্য জিনিস'),
                      value: 'Cement',
                      groupValue: _radioValue,
                      onChanged: (value) {
                        setState(() {
                          _radioValue = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              if (_radioValue == 'Money')
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'মোট টাকার পরিমাণ',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _totalAmount = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'মোট টাকার পরিমাণ লিখুন!';
                    }
                    return null;
                  },
                ),
              if (_radioValue == 'Cement')
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'সিমেন্ট/অন্যান্য জিনিসের মোট টাকা',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _totalAmount = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'সিমেন্ট/অন্যান্য জিনিসের মোট টাকা পরিমাণ লিখুন!';
                    }
                    return null;
                  },
                ),
              const SizedBox(height: 16),

              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'মোট জমার পরিমাণ',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    _advancedAmount = value;
                  });
                },
                validator: (value) {
                  // if (value == null || value.isEmpty) {
                  //   return 'মোট টাকার পরিমাণ লিখুন!';
                  // }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              ///button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    int totalPayableAmount = int.parse(_totalAmount)-int.parse(_advancedAmount);

                    if(_villageName.isEmpty){
                      _villageName = "ঝালখুর";
                    }
                    // Process the form data
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('আপনি কি সত্যিই দাতার তথ্য এড করতে চাচ্ছেন?'),
                        content: Text('নাম : $_fullName\n'
                            'মোট টাকার পরিমাণ : $_totalAmount টাকা\n'
                            'জমার পরিমাণ : $_advancedAmount টাকা\n'
                            'গ্রাম : $_villageName\n'
                            'বকেয়া টাকার পরিমাণ : $totalPayableAmount টাকা'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('ক্যানসেল করুন'),
                          ),
                          TextButton(
                            onPressed: () {


                              controller.addDonor(Doner(
                                donerType: _radioValue,
                                name: _fullName,
                                payableAmount: totalPayableAmount.toString(),
                                totalDonorAmount: _totalAmount,
                                totalSubmittedAmount: _advancedAmount,
                                village: _villageName,
                              ));

                              Future.delayed(const Duration(milliseconds: 1500),(){
                                AppUtils.showMessage(context, controller.errorMessage);
                                Navigator.of(context).pop();
                              });

                            },
                            child: const Text('সাবমিট করুন'),
                          ),
                        ],
                      ),
                    );
                  }
                },
                child: const Text('ফর্ম সাবমিট করুন'),
              ),
            ],
          ),
        ),
      ),
    );
  }


}
