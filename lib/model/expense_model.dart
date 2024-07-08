import 'package:cloud_firestore/cloud_firestore.dart';

class ExpenseModel {
  String title;
  String desc;
  String amount;
  String date;
  String addedBy;


  ExpenseModel({
    required this.title,
    required this.desc,
    required this.amount,
    required this.date,
    required this.addedBy,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'desc': desc,
      'amount': amount,
      'date': date,
      'addedby': addedBy,

    };
  }

  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
      title: map['title'],
      desc: map['desc'] ?? '',
      amount: map['amount'] ?? '',
      date: map['date'] ?? '',
      addedBy: map['addedby'] ?? '',
    );
  }


  factory ExpenseModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return ExpenseModel.fromMap(data);
  }

}
