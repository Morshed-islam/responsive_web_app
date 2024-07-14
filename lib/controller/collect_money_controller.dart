import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:responsive_web_app/model/collect_amount_model.dart';

import '../model/mixer_add_money_model.dart';
import '../utils/app_constant.dart';

class CollectMoneyController extends ChangeNotifier {
  String errorMessage = '';
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;


  bool _isLoading = true;
  bool _isSuccess = false;

  bool get isLoading => _isLoading;

  bool get isSuccess => _isSuccess;


  ///--------------all methods--------------------------

  Future<void> collectAmountAllMethod(MixerAddMoneyModel model, int updatedCollectAmount) async {

    // Future.delayed(const Duration(seconds: 1));
    // updateDonorPayableAndDepositAmount(documentId: model.donorId, model: model);

    // Future.delayed(const Duration(seconds: 1));
    // onlyCollectAmountsRecord(model.collectModel, model.donorId, updatedCollectAmount);

    // Future.delayed(const Duration(seconds: 1));
    allCollectedAmountNestedCollectionRecord(model.collectModel, model.donorId);

    _isLoading = false;
    notifyListeners();
  }


  Future<void> updateDonorPayableAndDepositAmount({required String documentId,required MixerAddMoneyModel model,}) async {

    ///  total amount 20000tk - 15000tk = 5000Tk already submitted / deposited
    // int uAlreadySubmittedAmount = totalAmount - totalPayableAmount;

    // ta:2000tk - ca:2000tk = 18000tk - ca:2000tk = 16k

    int uPayableAmount = model.totalAmount - model.collectAmount;

    // tp:19k - ca:1k = 18k
    int uLatestPayableAmount = model.totalPayableAmount - model.collectAmount;

    /// 5000Tk (already submitted) + 2000Tk = 7000Tk (deposit)
    int updatedDepositAmount = model.previousSubmittedAmount + model.collectAmount;

    log("payable amount $uLatestPayableAmount ${model.totalPayableAmount} ${model.collectAmount}");
    try {
      ///donorId == document id as i used document id as a donorId
      await fireStore.collection(AppConstants.donorListCollection).doc(documentId).update({
        'payable_amount': model.totalPayableAmount.toString(),
        'total_submitted_amount': updatedDepositAmount.toString(),
      });
      log("Due amount updated successfully");
      _isSuccess = true;
      log("method 1 $_isSuccess $_isLoading");

    } catch (e) {
      log("Error updating due amount: $e");
      _isSuccess = false;
    }
    notifyListeners();
  }


  Future<String> onlyCollectAmountsRecord(CollectAmountModel collectModel, String donorId, int updatedCollectAmount) async {

    CollectAmountModel updatedModel = CollectAmountModel(
      id: collectModel.id,
      name: collectModel.name,
      collectAmount: updatedCollectAmount.toString(),
      createdAt: collectModel.createdAt,
      addedBy: collectModel.addedBy,);
    try {

      log("update collect amount ${updatedModel.collectAmount}");
      // await fireStore.collection(AppConstants.individualCollectAmountRecordCollectionName).doc(donorId).update(updatedModel.toMapUpdateOnlyAmountNDate());
      await fireStore.collection(AppConstants.individualCollectAmountRecordCollectionName).doc(donorId).set(updatedModel.toMap(), SetOptions(merge: true),);

      _isSuccess = true;
      log("method 2 $_isSuccess $_isLoading");

      notifyListeners();
      return errorMessage = "Success";
    } on FirebaseException catch (error) {
      log("error message ${error.code}");
      if(error.code == "not-found"){
        await fireStore.collection(AppConstants.individualCollectAmountRecordCollectionName).doc(donorId).set(updatedModel.toMap(), SetOptions(merge: true),);
      }

      log("Error adding donor: $error");
      errorMessage = error.toString();
      _isSuccess = false;
      notifyListeners();

      return errorMessage;
    }
  }


  Future<String> allCollectedAmountNestedCollectionRecord(CollectAmountModel collectModel, String donorId) async {
    try {
      log("log 1");

      // Create a reference to the top-level collection "paid_amounts"
      CollectionReference paidAmounts = fireStore.collection(AppConstants.paidCollectionName);

      // Create a reference to the document with the user's ID
      DocumentReference userDoc = paidAmounts.doc(donorId);

      // Create a reference to the subCollection with the user's ID
      CollectionReference userSubCollection = userDoc.collection(donorId);
      log("log 2");

      // Add a new document with a random ID to the user's subCollection
      await userSubCollection.add({
        'name': collectModel.name,
        'collect_amount': collectModel.collectAmount,
      });

      log("log 3");
      _isSuccess = true;

      log("method 3 $_isSuccess $_isLoading");

      notifyListeners();
      return 'Success';
    } catch (error) {
      log("Error adding donor: $error");
      errorMessage = error.toString();
      _isSuccess = true;
      notifyListeners();
      return errorMessage;
    }
  }


}
