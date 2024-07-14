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


  ///update provider data
  void updateDonorListPayableAmount({required String paidAmount, required String donorId}) {
    // Find the index of the user in the list
    int index = donorList.indexWhere((element) => element.id == donorId);

    if (index != -1) {
      // Update the user using copyWith and replace it in the list
      donorList[index] = donorList[index].copyWith(payableAmount: paidAmount);

      log("User id ${donorList[index].id}");
      log("User payable ${donorList[index].payableAmount}");
      notifyListeners();
    } else {
      log("User not found");
    }
  }


  ///get list of users
  Future<List<Doner>> _fetchUsers() async {
    await Future.delayed(const Duration(seconds: 2));
    QuerySnapshot querySnapshot = await _firestore.collection(AppConstants.donorListCollection).get();
    var list = querySnapshot.docs.map((doc) => Doner.fromFirestore(doc)).toList();
    _isLoading = false;
    notifyListeners();
    return list;
  }

  void getUsers() async {
    if(donorList.isEmpty){
      donorList = await _fetchUsers();
      log("empty user list");
      notifyListeners();
    }{
      log("Not empty user list");

      donorList = donorList;
    }

    // notifyListeners();
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



}
