import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../model/doner_model.dart';

class UserListController extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String donorCollectionName = "doner_user_collection";
  bool _isLoading = true;
  List<Doner> userList = [];
  List<Doner> filteredContacts = [];

  bool get isLoading => _isLoading;

  ///------------------------------------------------------

  ///get list of users
  Future<List<Doner>> _fetchUsers() async {
    await Future.delayed(const Duration(seconds: 2));
    QuerySnapshot querySnapshot = await _firestore.collection(donorCollectionName).get();
    var list = querySnapshot.docs.map((doc) => Doner.fromFirestore(doc)).toList();
    _isLoading = false;
    notifyListeners();
    return list;
  }

  void getUsers() async {
    userList = await _fetchUsers();
    notifyListeners();
  }

  void filterContacts(String query) {
    final results = userList.where((user) {
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
      await _firestore.collection(donorCollectionName).doc(documentId).update({
        'payable_amount': uSubmittedAmount.toString(),
        'total_submitted_amount' : uPayableAmount.toString(),
      });
      log("Due amount updated successfully");
    } catch (e) {
      log("Error updating due amount: $e");
    }
  }

}
