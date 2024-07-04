import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:responsive_web_app/utils/app_constant.dart';

import '../utils/colors.dart';
import '../widgets/home_cards.dart';

class WebLayout extends StatefulWidget {
  @override
  State<WebLayout> createState() => _WebLayoutState();
}

class _WebLayoutState extends State<WebLayout> {
  int touchedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    log("height ${size.height}");
    log("height ${size.width}");
    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      color: Colors.blue,
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 200, vertical: 100),
        color: Colors.black12,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                      flex: 1,
                      child: HomeCard(
                        icon: 'user_list.json',
                        title: "মোট দাতা",
                        value: "70 জন",
                        width: (size.width - 400) / 6,
                        height: size.height / 4,
                      )),
                  Flexible(
                      flex: 1,
                      child: HomeCard(
                        icon: 'bill.json',
                        title: "মোট টাকা",
                        value: "80000 টাকা",
                        width: (size.width - 400) / 6,
                        height: size.height / 4,
                      )),
                  Flexible(
                      flex: 1,
                      child: HomeCard(
                        icon: 'due.json',
                        title: "বাকির পরিমাণ",
                        value: "705000 টাকা",
                        width: (size.width - 400) / 6,
                        height: size.height / 4,
                      )),
                  Flexible(
                      flex: 1,
                      child: HomeCard(
                        icon: 'amount.json',
                        title: "জমার পরিমাণ",
                        value: "50000 টাকা",
                        width: (size.width - 400) / 6,
                        height: size.height / 4,
                      )),
                  Flexible(
                      flex: 1,
                      child: HomeCard(
                        onPressed: () {
                          Navigator.pushNamed(context, AppConstants.addMoneyRoute);
                        },
                        icon: 'add.json',
                        title: "জমা নিন",
                        isActionButton: true,
                        width: (size.width - 400) / 6,
                        height: size.height / 4,
                      )),
                  Flexible(
                      flex: 1,
                      child: HomeCard(
                        onPressed: () {
                          Navigator.pushNamed(context, AppConstants.addUserScreenRoute);
                        },
                        icon: 'bill.json',
                        title: "দাতা এড করুন",
                        isActionButton: true,
                        width: (size.width - 400) / 6,
                        height: size.height / 4,
                      )),
                ],
              ),
              AspectRatio(
                aspectRatio: 5,
                child: AspectRatio(
                  aspectRatio: 3,
                  child: PieChart(
                    PieChartData(
                      pieTouchData: PieTouchData(
                        touchCallback: (FlTouchEvent event, pieTouchResponse) {
                          setState(() {
                            if (!event.isInterestedForInteractions || pieTouchResponse == null || pieTouchResponse.touchedSection == null) {
                              touchedIndex = -1;
                              return;
                            }
                            touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
                          });
                        },
                      ),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 0,
                      centerSpaceRadius: 0,
                      sections: showingSections(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 20.0 : 16.0;
      final radius = isTouched ? 110.0 : 100.0;
      final widgetSize = isTouched ? 55.0 : 40.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.red,
            value: 40,
            title: '40%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
            badgeWidget: _Badge(
              'assets/icons/ophthalmology-svgrepo-com.svg',
              size: widgetSize,
              borderColor: Colors.black,
            ),
            badgePositionPercentageOffset: .98,
          );
        case 1:
          return PieChartSectionData(
            color: Colors.yellow,
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
            badgeWidget: _Badge(
              'assets/icons/librarian-svgrepo-com.svg',
              size: widgetSize,
              borderColor: Colors.black,
            ),
            badgePositionPercentageOffset: .98,
          );
        case 2:
          return PieChartSectionData(
            color: Colors.pink,
            value: 16,
            title: '16%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
            badgeWidget: _Badge(
              'assets/icons/fitness-svgrepo-com.svg',
              size: widgetSize,
              borderColor: Colors.black,
            ),
            badgePositionPercentageOffset: .98,
          );
        case 3:
          return PieChartSectionData(
            color: Colors.green,
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
            badgeWidget: _Badge(
              'assets/icons/worker-svgrepo-com.svg',
              size: widgetSize,
              borderColor: Colors.black,
            ),
            badgePositionPercentageOffset: .98,
          );
        default:
          throw Exception('Oh no');
      }
    });
  }
}

class _Badge extends StatelessWidget {
  const _Badge(
    this.svgAsset, {
    required this.size,
    required this.borderColor,
  });

  final String svgAsset;
  final double size;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: PieChart.defaultDuration,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(.5),
            offset: const Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      padding: EdgeInsets.all(size * .15),
      child: Center(
        child: Icon(Icons.account_circle),
      ),
    );
  }
}
