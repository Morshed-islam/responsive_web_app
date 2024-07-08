import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:responsive_web_app/model/doner_model.dart';

import '../utils/app_constant.dart';

class AddDonerController extends ChangeNotifier {
  String errorMessage = "";
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<String> addDonor(Doner donor) async {
    try {
      await firestore.collection(AppConstants.donorCollectionName).add(donor.toMap());
      notifyListeners();
      return errorMessage = "Success";
    } catch (error) {
      log("Error adding donor: $error");
      errorMessage = error.toString();

      return errorMessage;


    }
  }
}