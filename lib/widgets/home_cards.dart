import 'package:flutter/material.dart';

class HomeCard extends StatelessWidget {
  final double? height;
  final double? width;
  final EdgeInsets? margin;
  const HomeCard({super.key, this.height, this.width, this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      height: height ?? 200,
      width: width ?? 200,
      color: Colors.amber,
    );
  }
}
