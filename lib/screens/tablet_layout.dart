import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:responsive_web_app/utils/app_constant.dart';

import '../widgets/home_cards.dart';

class TabletLayout extends StatelessWidget {
  const TabletLayout({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    log("height ${size.height}");
    log("width ${size.width}");
    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      color: Colors.black12,
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 200, vertical: 50),
        color: Colors.black12,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const SizedBox(height: 20,),
              Row(
                children: [
                  Flexible(
                      flex: 1,
                      child: HomeCard(
                        icon: 'user_list.json',
                        title: "মোট দাতা",
                        value: "70 জন",
                        height: 200,
                        width: (size.width - 400) / 3,
                      )),
                  Flexible(
                      flex: 1,
                      child: HomeCard(
                        icon: 'bill.json',
                        title: "মোট টাকা",
                        value: "80000 টাকা",
                        height: 200,
                        width: (size.width - 400) / 3,
                      )),
                  Flexible(
                      flex: 1,
                      child: HomeCard(
                        icon: 'due.json',
                        title: "বাকির পরিমাণ",
                        value: "705000 টাকা",
                        height: 200,
                        width: (size.width - 400) / 3,
                      )),
                ],
              ),
              Row(
                children: [
                  Flexible(
                      flex: 1,
                      child: HomeCard(
                        icon: 'amount.json',
                        title: "জমার পরিমাণা",
                        value: "50000 টাকা",
                        height: 200,
                        width: (size.width - 400) / 3,
                      )),
                  Flexible(
                      flex: 1,
                      child: HomeCard(
                        onPressed:(){
                          Navigator.pushNamed(context, AppConstants.addMoneyRoute);

                        },
                        icon: 'bill.json',
                        title: "জমা নিন",
                        isActionButton:true,
                        height: 200,
                        width: (size.width - 400) / 3,
                      )),
                  Flexible(
                      flex: 1,
                      child: HomeCard(
                        onPressed:(){
                          Navigator.pushNamed(context, AppConstants.addUserScreenRoute);

                        },
                        icon: 'bill.json',
                        title: "দাতা এড করুন",
                        isActionButton:true,
                        height: 200,
                        width: (size.width - 400) / 3,
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
