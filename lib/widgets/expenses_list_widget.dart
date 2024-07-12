import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:responsive_web_app/model/expense_model.dart';

import '../controller/home_controller.dart';
import '../utils/app_utils.dart';

class ExpensesListWidget extends StatelessWidget {
  const ExpensesListWidget({
    super.key,
    required this.controller,
  });

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: controller.expenseList.isEmpty
          ? 100
          : controller.expenseList.length >= 2
              ? 250
              : 150,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6), border: Border.all(color: Colors.black12, width: 1)),
      child: Column(
        children: [
          ///table header
          Container(
            color: const Color(0xffddedefdf),
            child: Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Row(
                children: [
                  const Spacer(),
                  Text(
                    "বিবিধ",
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
                  Row(
                    children: [
                      Text(
                        "তারিখ",
                        style: GoogleFonts.lato(
                          textStyle: const TextStyle(
                            color: Colors.black,
                            letterSpacing: .5,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          controller.addExpense(ExpenseModel(title: "test", desc: "test data ", amount: '1000', date: "05/12/34", addedBy: "Morhsed"));
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(left: 8, right: 8.0),
                          child: Icon(
                            Icons.add_circle_outline_rounded,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),

          if (controller.isLoading) ...[
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(color: Color(0xffddedefdf)),
            )
          ] else if (controller.expenseList.isNotEmpty) ...[
            Expanded(
              child: ListView.builder(
                itemCount: controller.expenseList.length,
                itemBuilder: (context, index) {
                  var item = controller.expenseList[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0), // Add some padding between rows
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
                              flex: 1, // Adjust the flex values as needed
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.title,
                                    style: GoogleFonts.lato(
                                      textStyle: const TextStyle(
                                        color: Colors.black,
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
                                AppUtils.convertEngToBanglaNumber(item.amount),
                                style: GoogleFonts.lato(
                                  textStyle: const TextStyle(
                                    color: Colors.black,
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
                                  item.date,
                                  style: GoogleFonts.lato(
                                    textStyle: const TextStyle(
                                      color: Colors.black,
                                      letterSpacing: .5,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: double.maxFinite,
                          color: Colors.black.withOpacity(0.05),
                          child: Column(children: [
                            Text(
                              item.desc,
                              style: GoogleFonts.lato(
                                textStyle: const TextStyle(
                                  color: Colors.black,
                                  letterSpacing: .5,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Text(
                              "স্বাক্ষর: - ${item.addedBy}",
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                  color: Colors.red.shade500,
                                  letterSpacing: .5,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ]),
                        )
                      ],
                    ),
                  );
                },
              ),
            )
          ] else ...[
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Center(
                child: Text(
                  "কোনো তথ্য পাওয়া যায়নি!",
                  style: GoogleFonts.lato(
                    textStyle: const TextStyle(
                      color: Colors.black38,
                      letterSpacing: .5,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          ]
        ],
      ),
    );
  }
}
