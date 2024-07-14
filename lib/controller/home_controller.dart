import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:responsive_web_app/model/doner_model.dart';
import 'package:responsive_web_app/model/expense_model.dart';
import 'package:responsive_web_app/model/collect_amount_model.dart';

import '../utils/app_constant.dart';

class HomeController extends ChangeNotifier {
  String? totalPayableAmount = "";
  String? totalAmount = "";
  String? totalSubmittedAmount = "";
  String errorMessage = "";
  int? donorCount = 0;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late QuerySnapshot querySnapshot;
  bool _isLoading = true;
  bool _isCollectAmountLoading = true;

  List<ExpenseModel> expenseList = [];
  List<Doner> topDonorUsersList = [];
  List<CollectAmountModel> paidAmountList = [];
  List<CollectAmountModel> collectAmountList = [];




  bool get isLoading => _isLoading;
  bool get isCollectAmountLoading => _isCollectAmountLoading;

  ///==================Method====================


  Future<String> addExpense(ExpenseModel expense) async {
    try {
      await firestore.collection(AppConstants.expenseCollectionName).add(expense.toMap());
      notifyListeners();
      getAllExpenses();
      return errorMessage = "Success";
    } catch (error) {
      log("Error adding donor: $error");
      errorMessage = error.toString();

      return errorMessage;

    }
  }



  updatedIsCollectAmountLoadingStatus(bool val){
    _isCollectAmountLoading = val;
    notifyListeners();
  }

  ///get list of individual collection amount
  Future<List<CollectAmountModel>> _fetchIndividualCollectAmount() async {
    await Future.delayed(const Duration(seconds: 2));
    QuerySnapshot querySnapshot = await firestore.collection(AppConstants.individualCollectAmountRecordCollectionName).get();
    var list = querySnapshot.docs.map((doc) => CollectAmountModel.fromFirestore(doc)).toList();
    _isLoading = false;
    notifyListeners();
    return list;
  }

  void getIndividualCollectAmount() async {
    collectAmountList = await _fetchIndividualCollectAmount();
    notifyListeners();
  }



  Future<List<CollectAmountModel>> fetchPaidAmountNestedCollection({required String userIdOfDonner}) async {
    List<CollectAmountModel> documents = [];
    try {
      await Future.delayed(const Duration(seconds: 2));
      QuerySnapshot querySnapshot = await firestore
          .collection(AppConstants.paidCollectionName)
          .doc(userIdOfDonner) //document id /userId
          .collection(userIdOfDonner) //nested collection
          .get();


      for (var doc in querySnapshot.docs) {
        documents.add(CollectAmountModel.fromFirestore(doc));
      }
      _isCollectAmountLoading = false;
      notifyListeners();
    } catch (e) {
      log('Error fetching nested collection: $e');
    }
    return documents;
  }

  ///get  amount and name
  Future<void> getSinglePaidAmountData({required String userIdOfDonner}) async {
    paidAmountList = await fetchPaidAmountNestedCollection(userIdOfDonner:userIdOfDonner);
    for (var item in paidAmountList) {
      log('paid amount: ${item.name}');
    }
    notifyListeners();

  }

  /// get top donor list
  Future<List<Doner>> getTopDonorUsers(int limit) async {
    List<Doner> topUsers = [];

    try {
      QuerySnapshot querySnapshot = await firestore.collection(AppConstants.donorListCollection).orderBy('total_donor_amount', descending: true).limit(limit).get();

      for (var doc in querySnapshot.docs) {
        topUsers.add(Doner.fromFirestore(doc));
      }
    } catch (e) {
      log('Error fetching top users: $e');
    }

    return topUsers;
  }

  void fetchTopUsers() async {
    int limit = 5; // Number of top users you want to fetch
    List<Doner> _topDonorUsers = await getTopDonorUsers(limit);

    for (var user in _topDonorUsers) {
      topDonorUsersList.add(user);
      log('User ID: ${user.totalDonorAmount}');
    }
  }

  ///get list of expenses
  Future<List<ExpenseModel>> _fetchExpenses() async {
    await Future.delayed(const Duration(seconds: 2));
    QuerySnapshot querySnapshot = await firestore.collection(AppConstants.expenseCollectionName).get();
    var list = querySnapshot.docs.map((doc) => ExpenseModel.fromFirestore(doc)).toList();
    _isLoading = false;
    notifyListeners();
    return list;
  }

  void getAllExpenses() async {
    expenseList = await _fetchExpenses();
    notifyListeners();
  }

  ///get due amount------------------------

  void fetchTotalDueAmount() async {
    String amount = await _amountFetchingFromServer(collectionName: AppConstants.donorListCollection, docName: "payable_amount");
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
    String amount = await _amountFetchingFromServer(collectionName: AppConstants.donorListCollection, docName: "total_donor_amount");
    totalAmount = amount;
    notifyListeners();
  }

  ///get total submitted------------------------
  void fetchTotalSubmittedAmount() async {
    String amount = await _amountFetchingFromServer(collectionName: AppConstants.donorListCollection, docName: "total_submitted_amount");
    totalSubmittedAmount = amount;
    notifyListeners();
  }

  ///common method to fetch all types of amount from server
  Future<String> _amountFetchingFromServer({required String collectionName, required String docName}) async {
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

  void updatePayableAmount(String amount) async {
    totalPayableAmount = amount;
    notifyListeners();
  }
}
