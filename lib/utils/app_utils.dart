import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../controller/add_doner_controller.dart';

class AppUtils{
  static void showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}