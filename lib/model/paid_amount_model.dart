import 'package:cloud_firestore/cloud_firestore.dart';

class PaidAmountModel {
  String id;
  String name;
  String amount;
  String date;
  String addedBy;


  PaidAmountModel({
    required this.id,
    required this.name,
    required this.amount,
    required this.date,
    required this.addedBy,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'amount': amount,
      'date': date,
      'addedby': addedBy,

    };
  }

  factory PaidAmountModel.fromMap(Map<String, dynamic> map) {
    return PaidAmountModel(
      id: map['id'],
      name: map['name'],
      amount: map['amount'] ?? '',
      date: map['date'] ?? '',
      addedBy: map['addedby'] ?? '',
    );
  }


  factory PaidAmountModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return PaidAmountModel.fromMap(data);
  }

}
