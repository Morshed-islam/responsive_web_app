import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../model/doner_model.dart';
import '../utils/app_constant.dart';

class UserListController extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _isLoading = true;
  List<Doner> donorList = [];
  List<Doner> filteredContacts = [];

  bool get isLoading => _isLoading;

  ///------------------------------------------------------


  void updateDonorListData({required String paidAmount,required String id}){
    var mDonor = donorList.where((element) => element.id == id).toList();

    if(mDonor.isNotEmpty){

      mDonor.first.payableAmount = paidAmount;

      log("User id ${mDonor.first.id}");
      log("User payable ${mDonor.first.payableAmount}");
      notifyListeners();
    }else{
      log("User not found");
    }

  }


  ///get list of users
  Future<List<Doner>> _fetchUsers() async {
    await Future.delayed(const Duration(seconds: 2));
    QuerySnapshot querySnapshot = await _firestore.collection(AppConstants.donorCollectionName).get();
    var list = querySnapshot.docs.map((doc) => Doner.fromFirestore(doc)).toList();
    _isLoading = false;
    notifyListeners();
    return list;
  }

  void getUsers() async {
    donorList = await _fetchUsers();
    notifyListeners();
  }

  void filterContacts(String query) {
    final results = donorList.where((user) {
      final nameLower = user.name.toLowerCase();
      final villageLower = user.village.toLowerCase();
      final searchLower = query.toLowerCase();

      log("filtered $nameLower");
      log("filtered ${nameLower.contains(searchLower)}");
      return nameLower.contains(searchLower) || villageLower.contains(searchLower);
    }).toList();

    filteredContacts = results;
    notifyListeners();
  }


  Future<void> collectAmount({required String documentId, required int submittedAmount,required int totalAmount}) async {

    int uSubmittedAmount = totalAmount - submittedAmount;
    int uPayableAmount = totalAmount - submittedAmount;

    try {
      await _firestore.collection(AppConstants.donorCollectionName).doc(documentId).update({
        'payable_amount': uSubmittedAmount.toString(),
        'total_submitted_amount' : uPayableAmount.toString(),
      });
      log("Due amount updated successfully");
    } catch (e) {
      log("Error updating due amount: $e");
    }
  }

}
