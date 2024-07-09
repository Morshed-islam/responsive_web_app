import 'dart:developer';
import 'package:expansion_tile_group/expansion_tile_group.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:responsive_web_app/model/collect_amount_model.dart';
import '../../controller/collect_money_controller.dart';
import '../../controller/home_controller.dart';
import '../../utils/app_constant.dart';
import '../../utils/app_images.dart';
import '../../utils/app_utils.dart';
import '../../utils/colors.dart';
import '../../widgets/expenses_list_widget.dart';
import '../../widgets/highest_donor_list_widget.dart';
import '../../widgets/home_cards.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.controller,
    required this.size,
  });

  final HomeController controller;
  final Size size;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<int, bool> expandedState = {};

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 12,
        ),

        ///header section
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
                flex: 1,
                child: HomeCard(
                  onPressed: (){

                   var collectModel = CollectAmountModel(id: '', name: 'TestMorshed', amount: '33333', createdAt: '12/12/23', addedBy: 'test morshed',);
                    context.read<CollectMoneyController>().allCollectedAmountNestedCollectionRecord(collectModel, 'meYK1sRi3pBV7VPmYAqV');
                  },
                  icon: AppImages.users(),
                  // icon: 'assets/lotties/user_list.json',
                  title: "মোট দাতা",
                  value: "${AppUtils.convertEngToBanglaNumber("${widget.controller.donorCount ?? 00}")} জন",
                  color: AppColors.cardColor1(),
                  height: 200,
                  width: (widget.size.width - 32) / 2,
                )),
            Flexible(
                flex: 1,
                child: HomeCard(
                  icon: AppImages.totalMoney(),
                  // icon: 'assets/lotties/bill.json',
                  title: "মোট টাকা",
                  value: "${AppUtils.convertEngToBanglaNumber("${widget.controller.totalAmount ?? 00}")} টাকা",
                  color: AppColors.cardColor2(),
                  height: 200,
                  width: (widget.size.width - 32) / 2,
                )),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
                flex: 1,
                child: HomeCard(
                  icon: AppImages.dueAmount(),
                  // icon: 'assets/lotties/due.json',
                  title: "বাকির পরিমাণ",
                  value: "${AppUtils.convertEngToBanglaNumber("${widget.controller.totalPayableAmount ?? 00}")} টাকা",
                  color: AppColors.cardColor3(),
                  height: 200,
                  width: (widget.size.width - 32) / 2,
                )),
            Flexible(
                flex: 1,
                child: HomeCard(
                  icon: AppImages.paidMoney(),
                  // icon: "assets/lotties/amount.json",
                  title: "জমার পরিমাণ",
                  value: "${AppUtils.convertEngToBanglaNumber("${widget.controller.totalSubmittedAmount}")} টাকা",
                  height: 200,
                  color: AppColors.cardColor4(),
                  width: (widget.size.width - 32) / 2,
                )),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
                flex: 1,
                child: HomeCard(
                  onPressed: () {
                    Navigator.pushNamed(context, AppConstants.addMoneyRoute);
                  },
                  icon: AppImages.payMoney(),
                  // icon: 'assets/lotties/add.json',
                  title: "জমা নিন",
                  color: AppColors.cardColor5(),
                  height: 180,
                  width: (widget.size.width - 32) / 2,
                  isActionButton: true,
                )),
            Flexible(
                flex: 1,
                child: HomeCard(
                  onPressed: () {
                    Navigator.pushNamed(context, AppConstants.addUserScreenRoute);
                  },
                  icon: AppImages.addUser(),
                  // icon: 'assets/lotties/bill.json',
                  title: "দাতা এড করুন",
                  isActionButton: true,
                  height: 180,
                  color: AppColors.cardColor6(),
                  width: (widget.size.width - 32) / 2,
                )),
          ],
        ),

        ///Expenses list
        const SizedBox(
          height: 12,
        ),
        Text(
          "হিসেব বাবদ",
          style: GoogleFonts.lato(
            textStyle: TextStyle(color: Colors.black.withOpacity(.3), letterSpacing: .5, fontSize: 22, fontWeight: FontWeight.w600),
          ),
        ),
        ExpensesListWidget(controller: widget.controller),

        ///Highest donor list
        const SizedBox(height: 12),
        Text(
          "সর্বোচ্চ দাতার তালিকা",
          style: GoogleFonts.lato(
            textStyle: TextStyle(color: Colors.black.withOpacity(.3), letterSpacing: .5, fontSize: 22, fontWeight: FontWeight.w600),
          ),
        ),

        HighestDonorListWidget(controller: widget.controller),
        const SizedBox(height: 12),

        ///Highest donor list
        const SizedBox(height: 12),
        Text(
          "জমা দান কারীর তালিকা",
          style: GoogleFonts.lato(
            textStyle: TextStyle(color: Colors.black.withOpacity(.3), letterSpacing: .5, fontSize: 22, fontWeight: FontWeight.w600),
          ),
        ),

        ///table header
        Container(
          color: const Color(0xffddedefdf),
          child: Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Row(
              children: [
                const Spacer(),
                Text(
                  "নাম",
                  style: GoogleFonts.lato(
                    textStyle: const TextStyle(
                      color: Colors.black,
                      letterSpacing: .5,
                      fontSize: 20,
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  "টাকা",
                  style: GoogleFonts.lato(
                    textStyle: const TextStyle(
                      color: Colors.black,
                      letterSpacing: .5,
                      fontSize: 20,
                    ),
                  ),
                ),
                const Spacer(),


              ],
            ),
          ),
        ),
        Container(
          height: 250,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(6),bottomRight: Radius.circular(6)) ,
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ExpansionTileGroup(
                onExpansionItemChanged: (i, value) async {

                  widget.controller.paidAmountList.clear();
                  widget.controller.updatedIsCollectAmountLoadingStatus(true);
                  CollectAmountModel item = widget.controller.collectAmountList[i];
                  log("clicked $i ${item.id}");
                  setState(() {
                    expandedState[i] = value;
                  });
                  await context.read<HomeController>().getSinglePaidAmountData(userIdOfDonner: item.id);

                  setState(() {
                    expandedState[i] = true;
                  });
                },
                spaceBetweenItem: 5,
                toggleType: ToggleType.expandOnlyCurrent,
                children: widget.controller.collectAmountList.map<ExpansionTileItem>((CollectAmountModel item) {
                  int index = widget.controller.collectAmountList.indexOf(item);
                  var odd = index.isOdd;
                  return ExpansionTileBorderItem(
                    key: PageStorageKey<int>(index),
                    initiallyExpanded: expandedState[index] ?? false,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      border: Border(bottom: BorderSide(color: Colors.black,width: 1)),
                    ),
                    backgroundColor: Colors.white,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          item.name,
                          style: GoogleFonts.lato(
                            textStyle: const TextStyle(color: Colors.black, letterSpacing: .5, fontSize: 14, fontWeight: FontWeight.w400),
                          ),
                        ),
                        Text(
                          item.amount,
                          style: GoogleFonts.lato(
                            textStyle: const TextStyle(color: Colors.black, letterSpacing: .5, fontSize: 14, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                    children:

                    widget.controller.isCollectAmountLoading
                        ? [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Center(child: CircularProgressIndicator()),
                            )
                          ]
                        : widget.controller.paidAmountList.isEmpty ? [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(child: Text('No Data found!')),
                      )
                    ] :widget.controller.paidAmountList.map((nestedDocumentItem) {
                            return Container(
                              margin: EdgeInsets.only(bottom: 10),
                              padding: EdgeInsets.all(5),
                              color: index.isOdd ? Colors.black12 : Colors.white,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Flexible(
                                    flex: 1, // Adjust the flex values as needed
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          nestedDocumentItem.name,
                                          style: GoogleFonts.lato(
                                            textStyle: TextStyle(
                                              color: index == 0 ? Colors.green : Colors.black,
                                              letterSpacing: .5,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1, // Adjust the flex values as needed
                                    child: Text(
                                      AppUtils.convertEngToBanglaNumber(nestedDocumentItem.amount),
                                      style: GoogleFonts.lato(
                                        textStyle: TextStyle(
                                          color: index == 0 ? Colors.green : Colors.black,
                                          letterSpacing: .5,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1, // Adjust the flex values as needed
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 0.0),
                                      child: Text(
                                        nestedDocumentItem.createdAt,
                                        style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                            color: index == 0 ? Colors.green : Colors.black,
                                            letterSpacing: .5,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                  );
                }).toList(),
              ),
            ),
          ),
        ),

        const SizedBox(height: 50),
      ],
    );
  }
}

class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}
