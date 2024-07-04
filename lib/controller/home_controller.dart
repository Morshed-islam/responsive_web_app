import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:responsive_web_app/model/doner_model.dart';

class HomeController extends ChangeNotifier {
  String? totalPayableAmount = "";
  String? totalAmount = "";
  String? totalSubmittedAmount = "";
  int? donorCount = 0;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late QuerySnapshot querySnapshot;
  String donorCollectionName = "doner_user_collection";

  ///==================Method====================

  ///get due amount------------------------

  void fetchTotalDueAmount() async {
    String amount = await amountFetchingFromServer(collectionName: donorCollectionName,docName: "payable_amount");
      totalPayableAmount = amount;
      notifyListeners();
  }
  ///---------------------------------------

  ///get donor amount------------------------
  Future<int> getTotalDonorCount() async {
    try {
      final querySnapshot = await firestore.collection('doner_user_collection').get();
      return querySnapshot.docs.length;
    } catch (error) {
      log("Error getting total donor count: $error");
      return 0;
    }
  }

  void fetchTotalDonor() async {
    int donor = await getTotalDonorCount();
    donorCount = donor;
    notifyListeners();
  }
  ///---------------------------------------

  ///get total amount------------------------
  void fetchTotalAmount() async {
    String amount = await amountFetchingFromServer(collectionName: donorCollectionName, docName: "total_donor_amount");
    totalAmount = amount;
    notifyListeners();
  }


  ///get total submitted------------------------
  void fetchTotalSubmittedAmount() async {
    String amount = await amountFetchingFromServer(collectionName: donorCollectionName, docName: "total_submitted_amount");
    totalSubmittedAmount = amount;
    notifyListeners();
  }




  ///common method to fetch all types of amount from server
  Future<String> amountFetchingFromServer({required String collectionName, required String docName})async{
    int amount = 0;

    // Get all documents from user_list_tb collection
    querySnapshot = await firestore.collection(collectionName).get();

    // Loop through each document and sum the amount field
    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      String docAmount = doc[docName] ?? "0";
      amount += int.parse(docAmount);
    }
    notifyListeners();

    return amount.toString();
  }

  void updatePayableAmount(String amount)async{
    totalPayableAmount = amount;
    notifyListeners();
  }

}
