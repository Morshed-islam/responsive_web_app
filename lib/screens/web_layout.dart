import 'dart:developer';

import 'package:flutter/material.dart';

import '../widgets/home_cards.dart';

class WebLayout extends StatelessWidget {
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
            margin: EdgeInsets.symmetric(horizontal: 200,vertical: 100),
            color: Colors.black12,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                        flex: 1,
                        child: HomeCard(
                          width: (size.width-400)/4,
                          height: size.height / 5,
                        )),
                    Flexible(
                        flex: 1,
                        child: HomeCard(
                          width: (size.width-400)/4,
                          height: size.height / 5,
                        )),
                    Flexible(
                        flex: 1,
                        child: HomeCard(
                          width: (size.width-400)/4,
                          height: size.height / 5,

                        )),
                    Flexible(
                        flex: 1,
                        child: HomeCard(
                          width: (size.width-400)/4,
                          height: size.height / 5,

                        )),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}