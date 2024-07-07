import 'package:cloud_firestore/cloud_firestore.dart';

class Doner {
  String id;
  String donerType;
  String name;
  String payableAmount;
  String phone;
  String totalDonorAmount;
  String totalSubmittedAmount;
  String village;

  Doner({
    this.id = '',
    required this.donerType,
    required this.name,
    required this.payableAmount,
    this.phone = '',
    required this.totalDonorAmount,
    required this.totalSubmittedAmount,
    required this.village,
  });

  Map<String, dynamic> toMap() {
    return {
      'doner_type': donerType,
      'name': name,
      'payable_amount': payableAmount,
      'phone': phone,
      'total_donor_amount': totalDonorAmount,
      'total_submitted_amount': totalSubmittedAmount,
      'village': village,
    };
  }

  factory Doner.fromMap(Map<String, dynamic> map) {
    return Doner(
      id: 'id',
      donerType: map['doner_type'] ?? '',
      name: map['name'] ?? '',
      payableAmount: map['payable_amount'] ?? '',
      phone: map['phone'] ?? '',
      totalDonorAmount: map['total_donor_amount'] ?? '',
      totalSubmittedAmount: map['total_submitted_amount'] ?? '',
      village: map['village'] ?? '',
    );
  }


  factory Doner.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Doner.fromMap(data);
  }

}
