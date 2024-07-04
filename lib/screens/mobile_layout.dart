import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_web_app/controller/home_controller.dart';
import 'package:responsive_web_app/utils/colors.dart';

import '../utils/app_constant.dart';
import '../widgets/home_cards.dart';

class MobileLayout extends StatefulWidget {
  const MobileLayout({super.key});

  @override
  State<MobileLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<MobileLayout> {


  @override
  void initState() {
    context.read<HomeController>().fetchTotalDueAmount();
    context.read<HomeController>().fetchTotalDonor();
    context.read<HomeController>().fetchTotalAmount();
    context.read<HomeController>().fetchTotalSubmittedAmount();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    var controller = context.watch<HomeController>();
    return Scaffold(
        backgroundColor: Colors.black12,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                      flex: 1,
                      child: HomeCard(
                        icon: 'user_list.json',
                        // icon: 'assets/lotties/user_list.json',
                        title: "মোট দাতা",
                        value: "${controller.donorCount} জন",
                        color: AppColors.cardColor1(),
                        height: 200,
                        width: (size.width - 32) / 2,
                      )),
                  Flexible(
                      flex: 1,
                      child: HomeCard(
                        icon: 'bill.json',
                        // icon: 'assets/lotties/bill.json',
                        title: "মোট টাকা",
                        value: "${controller.totalAmount ?? 00} টাকা",
                        color: AppColors.cardColor2(),
                        height: 200,
                        width: (size.width - 32) / 2,
                      )),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                      flex: 1,
                      child: HomeCard(
                        icon: 'due.json',
                        // icon: 'assets/lotties/due.json',
                        title: "বাকির পরিমাণ",
                        value: "${controller.totalPayableAmount ?? 00} টাকা",
                        color: AppColors.cardColor3(),
                        height: 200,
                        width: (size.width - 32) / 2,
                      )),
                  Flexible(
                      flex: 1,
                      child: HomeCard(
                        icon: "amount.json",
                        // icon: "assets/lotties/amount.json",
                        title: "জমার পরিমাণ",
                        value: "${controller.totalSubmittedAmount} টাকা",
                        height: 200,
                        color: AppColors.cardColor4(),
                        width: (size.width - 32) / 2,
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
                          Navigator.popAndPushNamed(context, AppConstants.addMoneyRoute);
                        },
                        icon: 'add.json',
                        // icon: 'assets/lotties/add.json',
                        title: "জমা নিন",
                        color: AppColors.cardColor5(),
                        height: 180,
                        width: (size.width - 32) / 2,
                        isActionButton: true,
                      )),
                  Flexible(
                      flex: 1,
                      child: HomeCard(
                        onPressed: () {
                          Navigator.popAndPushNamed(context, AppConstants.addUserScreenRoute);
                        },
                        icon: 'bill.json',
                        // icon: 'assets/lotties/bill.json',
                        title: "দাতা এড করুন",
                        isActionButton: true,
                        height: 180,
                        color: AppColors.cardColor6(),
                        width: (size.width - 32) / 2,
                      )),
                ],
              ),
            ],
          ),
        ));
  }
}
