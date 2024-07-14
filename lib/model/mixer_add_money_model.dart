import 'collect_amount_model.dart';

class MixerAddMoneyModel {
  String donorId;
  int collectAmount;
  int totalPayableAmount;
  int totalAmount;
  int previousSubmittedAmount;
  CollectAmountModel collectModel;

  MixerAddMoneyModel({
    required this.donorId,
    required this.collectAmount,
    required this.previousSubmittedAmount,
    required this.totalPayableAmount,
    required this.totalAmount,
    required this.collectModel,
});

}
