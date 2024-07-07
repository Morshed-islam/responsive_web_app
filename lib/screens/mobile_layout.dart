import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_web_app/controller/home_controller.dart';
import 'package:responsive_web_app/utils/app_images.dart';
import 'package:responsive_web_app/utils/colors.dart';

import '../utils/app_constant.dart';
import '../utils/app_utils.dart';
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
          child: SingleChildScrollView(
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
                          icon: AppImages.users(),
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
                          icon: AppImages.totalMoney(),
                          // icon: 'assets/lotties/bill.json',
                          title: "মোট টাকা",
                          value: "${AppUtils.convertEngToBanglaNumber("${controller.totalAmount ?? 00}")} টাকা",
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
                          icon: AppImages.dueAmount(),
                          // icon: 'assets/lotties/due.json',
                          title: "বাকির পরিমাণ",
                          value: "${AppUtils.convertEngToBanglaNumber("${controller.totalPayableAmount ?? 00}")} টাকা",
                          color: AppColors.cardColor3(),
                          height: 200,
                          width: (size.width - 32) / 2,
                        )),
                    Flexible(
                        flex: 1,
                        child: HomeCard(
                          icon: AppImages.paidMoney(),
                          // icon: "assets/lotties/amount.json",
                          title: "জমার পরিমাণ",
                          value: "${AppUtils.convertEngToBanglaNumber("${controller.totalSubmittedAmount}")} টাকা",
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
                            Navigator.pushNamed(context, AppConstants.addMoneyRoute);
                          },
                          icon: AppImages.payMoney(),
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
                            Navigator.pushNamed(context, AppConstants.addUserScreenRoute);
                          },
                          icon: AppImages.addUser(),
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
          ),
        ));
  }
}
