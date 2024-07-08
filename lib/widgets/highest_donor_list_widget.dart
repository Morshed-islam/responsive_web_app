import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_web_app/utils/app_utils.dart';

import '../controller/home_controller.dart';

class HighestDonorListWidget extends StatelessWidget {
  const HighestDonorListWidget({
    super.key,
    required this.controller,
  });

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: controller.topDonorUsersList.isEmpty
          ? 100
          : controller.topDonorUsersList.length >= 5
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
                  Row(
                    children: [
                      Text(
                        "গ্রাম",
                        style: GoogleFonts.lato(
                          textStyle: const TextStyle(
                            color: Colors.black,
                            letterSpacing: .5,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      const SizedBox(width: 40,)
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
          ] else if (controller.topDonorUsersList.isNotEmpty) ...[
            Expanded(
              child: ListView.builder(
                itemCount: controller.topDonorUsersList.length,
                itemBuilder: (context, index) {
                  var item = controller.topDonorUsersList[index];
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
                                    item.name,
                                    style: GoogleFonts.lato(
                                      textStyle:  TextStyle(
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
                                AppUtils.convertEngToBanglaNumber(item.totalDonorAmount),
                                style: GoogleFonts.lato(
                                  textStyle:  TextStyle(
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
                                  item.village,
                                  style: GoogleFonts.lato(
                                    textStyle:  TextStyle(
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