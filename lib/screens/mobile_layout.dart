import 'package:flutter/material.dart';

import '../widgets/home_cards.dart';

class MobileLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: Column(
      children: [
        Row(
          children: [
            Flexible(
                flex: 1,
                child: HomeCard(
                  height: 100,
                )),
            Flexible(
                flex: 1,
                child: HomeCard(
                  height: 100,
                )),
          ],
        ),
        Row(
          children: [
            Flexible(
                flex: 1,
                child: HomeCard(
                  height: 100,
                )),
            Flexible(
                flex: 1,
                child: HomeCard(
                  height: 100,
                )),
          ],
        ),
      ],
    ));
  }
}
