import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:responsive_web_app/model/collect_amount_model.dart';

import '../utils/app_constant.dart';

class CollectMoneyController extends ChangeNotifier {
  String errorMessage = '';
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;



  ///--------------all methods--------------------------


  Future<String> onlyCollectAmountsRecord(CollectAmountModel collectModel,String donorId) async {
    try {
      await fireStore.collection(AppConstants.individualCollectAmountRecordCollectionName).doc(donorId).set(collectModel.toMap());
      notifyListeners();
      return errorMessage = "Success";
    } catch (error) {
      log("Error adding donor: $error");
      errorMessage = error.toString();
      return errorMessage;
    }
  }


  Future<String> allCollectedAmountNestedCollectionRecord(CollectAmountModel collectModel,String donorId) async {
    try {
      log("log 1");

      // Create a reference to the top-level collection "paid_amounts"
      CollectionReference paidAmounts =  fireStore.collection(AppConstants.paidCollectionName);

      // Create a reference to the document with the user's ID
      DocumentReference userDoc = paidAmounts.doc(donorId);

      // Create a reference to the subCollection with the user's ID
      CollectionReference userSubCollection = userDoc.collection(donorId);
      log("log 2");

      // Add a new document with a random ID to the user's subCollection
      await userSubCollection.add({
        'name': collectModel.name,
        'collect_amount': collectModel.amount,
      });

      log("log 3");

      return 'Success';

    } catch (error) {
      log("Error adding donor: $error");
      errorMessage = error.toString();
      return errorMessage;
    }
  }





}
