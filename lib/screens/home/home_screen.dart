import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controller/home_controller.dart';
import '../../utils/app_constant.dart';
import '../../utils/app_images.dart';
import '../../utils/app_utils.dart';
import '../../utils/colors.dart';
import '../../widgets/expenses_list_widget.dart';
import '../../widgets/highest_donor_list_widget.dart';
import '../../widgets/home_cards.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.controller,
    required this.size,
  });

  final HomeController controller;
  final Size size;

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
                  icon: AppImages.users(),
                  // icon: 'assets/lotties/user_list.json',
                  title: "মোট দাতা",
                  value: "${AppUtils.convertEngToBanglaNumber("${controller.donorCount ?? 00}")} জন",
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
        ExpensesListWidget(controller: controller),

        ///Highest donor list
        const SizedBox(height: 12),
        Text(
          "সর্বোচ্চ দাতার তালিকা",
          style: GoogleFonts.lato(
            textStyle: TextStyle(color: Colors.black.withOpacity(.3), letterSpacing: .5, fontSize: 22, fontWeight: FontWeight.w600),
          ),
        ),

        HighestDonorListWidget(controller: controller),
        const SizedBox(height: 12),

        const SizedBox(
          height: 50
        ),
      ],
    );
  }
}
