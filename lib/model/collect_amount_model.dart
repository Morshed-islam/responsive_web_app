import 'package:cloud_firestore/cloud_firestore.dart';

class CollectAmountModel {
  String id;
  String name;
  String collectAmount;
  String createdAt;
  String addedBy;


  CollectAmountModel({
    required this.id,
    required this.name,
    required this.collectAmount,
    required this.createdAt,
    required this.addedBy,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'collect_amount': collectAmount,
      'created_at': createdAt,
      'addedby': addedBy,
    };
  }

  Map<String, dynamic> toMapUpdateOnlyAmountNDate() {
    return {
      'collect_amount': collectAmount,
      'created_at': createdAt,
    };
  }

  factory CollectAmountModel.fromMap(Map<String, dynamic> map) {
    return CollectAmountModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      collectAmount: map['collect_amount'] ?? '',
      createdAt: map['created_at'] ?? '',
      addedBy: map['addedby'] ?? '',
    );
  }


  factory CollectAmountModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return CollectAmountModel.fromMap(data);
  }

}
